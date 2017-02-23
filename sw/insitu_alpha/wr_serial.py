#!/usr/bin/python

"""
wr_serial.py: Scans the cable round trip time (crtt) versus the wavelength that
              is set for an SFP with a tunable laser using a serial interface
              connection to the WR console.

Usage:
  wr_serial.py
  wr_serial.py     -h | --help

Options:
  -h --help    Show this screen.
  --version    Show version.
"""

import numpy
import serial
import time
import sys

# Add parent directory (containing 'lib') to the module search path
sys.path.insert(0,'..')

from lib.docopt import docopt
import lib.itu_conversions as itu_conv
import lib.wrt_sfppt015sc as tunable

###############################################
def wr2wrpc(ser, cmd):

  ser.write("\r")
  time.sleep (0.05)
  ser.flushInput()

  for i in range(len(cmd)):
    ser.write(cmd[i])
    time.sleep (0.1)
  ser.readline()	# Readback command
  print("=> " + cmd)

  return

###############################################
def wait_for_track_phase(ser):

  sync_phase = False
  track_phase = False
  crtt = 0

  while not sync_phase:		# First wait for "SYNC_PHASE" state
    stat = ser.readline()	# Readback status line
    stat_lst = stat.split(' ')	# split on spaces
    if len(stat_lst) < 27:
      break			# break if not in "stat" output modus
    print(stat_lst[6])
    if "SYNC_PHASE" in stat_lst[6]:
      sync_phase = True

  if not sync_phase:
    return(track_phase)		# Return with False

  while not track_phase:	# then wait for "SYNC_PHASE" state
    stat = ser.readline()	# Readback status line
    stat_lst = stat.split(' ')	# split on spaces
    if len(stat_lst) < 27:
      break			# break if not in "stat" output modus
    print(stat_lst[6])
    crtt_lst = stat_lst[17].split(":")
    if "TRACK_PHASE" in stat_lst[6]:
      track_phase = True

  return(track_phase)

###############################################
def write_to_file(ch_crtt):

  timestamp = time.localtime()

  file_header = "#In Situ Alpha measurements\n"
  file_header += "#date:"+time.strftime(format("%d %b %Y"),timestamp)+"\n"
  file_header += "#time:"+time.strftime(format("%H:%M:%S"),timestamp)+"\n"
  file_header += "#sfp_channel, ITU channel, ITU wavelength [nm], crtt\n"

  # Write out file_header, followed by all measurements, sorted by itu_channel number
  data = [file_header]
  for itu_ch in sorted(ch_crtt):
    sfp_ch = tunable.sfp_channel(itu_ch)
    frequency = itu_conv.itu_2_frequency(itu_ch)
    wavelength = itu_conv.itu_2_wavelength(itu_ch)
    data.append(str(sfp_ch)+", "+str(itu_ch)+", "+str(wavelength*1e9)+", "+str(ch_crtt[itu_ch])+"\n")

  filename="data/"+time.strftime(format("%y%m%d_%H_%M_%S"),timestamp)+"_insitu_alpha_scan"
  print("save insitu_alpha_scan into file:",filename)

  file=open(filename,"w")
  for i in data:
    file.write(i)
  file.close()
  return data, filename

###############################################
# Main
###############################################

if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='White Rabbit controled via serial port')

  if len(sys.argv) != 1:
    print ("### wrong number of input arguments")
    sys.exit()
  else:

    # Some constants (for now)
    # scan from itu channel start to stop and skipt he channel that is used
    # for the return channel. "itu_skip_width" can be made larger than 1
    # in case the dwdm filters are wider than just the return channel
    # Step size of the scan is defined by "itu_channel_increment"
    fixed_delay=int(56265)
    params = tunable.get_parameters()
    sfp_module_vendor_id = params["vendor_id"]
    itu_channel_start = params["itu_channel_start"]
    itu_channel_stop = params["itu_channel_stop"]
    itu_channel_skip = 20
    itu_skip_width = 0.5
    itu_channel_increment = params["itu_channel_spacing"]
    #itu_channel_increment = 40

    ser = serial.Serial()

    ser.port = "/dev/ttyUSB1"
    ser.baudrate = 115200
    ser.parity = serial.PARITY_NONE
    ser.bytesize = serial.EIGHTBITS
    ser.stopbits = serial.STOPBITS_ONE
    ser.timeout = None
    #ser.timeout = 600 	# timeout 10 minutes
    ser.open()

    # stop any pending ptp and or statistics output
    wr2wrpc(ser,"stat off\r")
    print(ser.readline())
    wr2wrpc(ser,"ptp stop\r")
    #print(ser.readline())

    wr2wrpc(ser,"sfp erase\r")
    #print(ser.readline())
    wr2wrpc(ser,"sfp add "+sfp_module_vendor_id+" "+str(fixed_delay)+" 0 0\r")
    #print(ser.readline())
    wr2wrpc(ser,"sfp detect\r")
    print(ser.readline())
    wr2wrpc(ser,"sfp match\r")
    print(ser.readline())

    wr2wrpc(ser,"sfp sel_page2\r")
    #print(ser.readline())

    ch_crtt = {}

    # scan through selected wavelengths
    for ch in numpy.arange(itu_channel_start,itu_channel_stop+0.5, itu_channel_increment):

      # Exclude the ITU channel that is used for the return channel
      if not(ch > (itu_channel_skip - itu_skip_width) and ch < (itu_channel_skip + itu_skip_width)):

        sfp_ch = tunable.sfp_channel(ch)
        print("select ITU channel",ch, "which is sfp channel number",sfp_ch)

        # select a wavelength
        wr2wrpc(ser,"sfp wr_ch " + str(sfp_ch) + "\r")
        print(ser.readline())
        wr2wrpc(ser,"sfp rd_ch\r")
        print(ser.readline())

        # stop any pending ptp and or statistics output
        wr2wrpc(ser,"stat off\r")
        print(ser.readline())
        wr2wrpc(ser,"ptp stop\r")
        #print(ser.readline())
        wr2wrpc(ser,"ptp start\r")
        wr2wrpc(ser,"stat\r")

        crtt = 0
        track_phase = wait_for_track_phase(ser)

        if not track_phase:
          if ch_crtt != None and ch_crtt != []:	# see if anything ia already measured
            write_to_file(ch_crtt,cl_wl)		# and then write intermidiate results
    	    sys.exit()				# to file before exit
        else:
          stat = ser.readline()			# Readback status line
          stat_lst = stat.split(' ')		# split on spaces
          curr_crtt_lst = stat_lst[17].split(":")
          crtt = int(curr_crtt_lst[1])		# crtt first value to take into account

          for i in range(10):			# take mean value over 10
            stat = ser.readline()			# Readback status line
            stat_lst = stat.split(' ')		# split on spaces
            curr_crtt_lst = stat_lst[17].split(":")
            curr_crtt = int(curr_crtt_lst[1])	# Current crtt
            crtt = int(round((crtt + curr_crtt)/2))    # add with moving average
  
        print("sfp_channel: ", sfp_ch ,"itu_channel: ", ch ," crtt: ", crtt)
        ch_crtt[ch]=crtt

    write_to_file(ch_crtt)

    ser.close()
