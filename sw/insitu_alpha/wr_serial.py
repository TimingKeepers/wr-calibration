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
    time.sleep (0.05)
  ser.readline()	# Readback command

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
# Main
###############################################


ser = serial.Serial()

ser.port = "/dev/ttyUSB1"
ser.baudrate = 115200
ser.parity = serial.PARITY_NONE
ser.bytesize = serial.EIGHTBITS
ser.stopbits = serial.STOPBITS_ONE
ser.timeout = None
ser.open()

cl_wl=(fill_channel_wavelength_dict())

wr2wrpc(ser,"ptp stop\r")
wr2wrpc(ser,"ptp start\r")
wr2wrpc(ser,"stat\r")

sync_phase = False
track_phase = False
crtt = 0

if not wait_for_track_phase(ser):
  sys.exit()

print(stat_lst[6])
crtt_lst = stat_lst[17].split(":")
crtt = int(crtt_lst[1])
if "TRACK_PHASE" in stat_lst[6]:
  track_phase = True

if track_phase:
  stat = ser.readline()			# Readback status line
  stat_lst = stat.split(' ')		# split on spaces
  curr_crtt_lst = stat_lst[17].split(":")
  crtt = int(curr_crtt_lst[1])		# crtt first value to take into account

  for i in range(10):			# take mean value over 10
    stat = ser.readline()		# Readback status line
    stat_lst = stat.split(' ')		# split on spaces
    curr_crtt_lst = stat_lst[17].split(":")
    curr_crtt = int(curr_crtt_lst[1])	# Current crtt
    crtt = int(round((crtt + curr_crtt)/2))    # add with moving average
    print (curr_crtt, crtt)


#ser.close()


