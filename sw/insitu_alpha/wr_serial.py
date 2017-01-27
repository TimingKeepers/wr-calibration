import serial
import time
import sys

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
def fill_channel_wavelength_dict():

  c = 299792458	 # speed of light 
  # WRT-SFPPT015SC channel, ITU Channel, ITU Frequency, ITU Wavelength
  ch_wl = {}
  for ch in range(1,103):	# selectable channel numbers WRT-SFPPT015SC (1..102)
    ITU_ch = float((ch + 21)/2.0)
    ITU_freq = (190 + (ITU_ch/10))*1e12
    ITU_wl = (c/ITU_freq)
    ch_wl_item = [ITU_ch,ITU_freq,ITU_wl]
    ch_wl[ch]=ch_wl_item

  return (ch_wl)
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
def write_to_file(ch_crtt,cl_wl):

  timestamp = time.localtime()

  file_header = "#In Situ Alpha measurements\n"
  file_header += "#date:"+time.strftime(format("%d %b %Y"),timestamp)+"\n"
  file_header += "#time:"+time.strftime(format("%H:%M:%S"),timestamp)+"\n"
  file_header += "#channel, ITU channel, ITU wavelength [nm], crtt\n"

  # Write out file_header, followed by all preambles, followed by all channel_data
  data = [file_header]
  for ch in ch_crtt:
    # wl = "{0:.2f}".format((cl_wl[ch][2])*1e9)
    data.append(str(ch)+", "+str(cl_wl[ch][0])+", "+str((cl_wl[ch][2])*1e9)+", "+str(ch_crtt[ch])+"\n")

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


ser = serial.Serial()

ser.port = "/dev/ttyUSB1"
ser.baudrate = 115200
ser.parity = serial.PARITY_NONE
ser.bytesize = serial.EIGHTBITS
ser.stopbits = serial.STOPBITS_ONE
ser.timeout = None
#ser.timeout = 600 	# timeout 10 minutes
ser.open()

cl_wl=(fill_channel_wavelength_dict())

# stop any pending ptp and or statistics output
wr2wrpc(ser,"stat off\r")
print(ser.readline())
wr2wrpc(ser,"ptp stop\r")
#print(ser.readline())

wr2wrpc(ser,"sfp erase\r")
#print(ser.readline())
wr2wrpc(ser,"sfp add WRT-SFPPT015SC 56265 0 0\r")
#print(ser.readline())
wr2wrpc(ser,"sfp detect\r")
print(ser.readline())
wr2wrpc(ser,"sfp match\r")
print(ser.readline())

wr2wrpc(ser,"sfp sel_page2\r")
#print(ser.readline())

ch_crtt = {}

for ch in range (1,103):	# Loop through all wavelengths
#for ch in range (17,23):	# Loop through all wavelengths

  # Exclude ITU channel 19.5, 20 and 20.5 (= WRT-SFPPT015SC channel 17-21)
  # since this is the range where the filters for the return channel are
  if not((ch == 18) or (ch == 19) or (ch == 20)):

    # select a wavelength
    wr2wrpc(ser,"sfp wr_ch " + str(ch) + "\r")
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
  
    print("channel: ", ch ," crtt: ", crtt)
    ch_crtt[ch]=crtt

write_to_file(ch_crtt,cl_wl)

#ser.close()


