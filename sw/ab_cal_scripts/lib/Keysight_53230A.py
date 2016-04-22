#!/usr/bin/python

"""
Keysight 53230A Universal Frequency Counter/Timer remote control

Usage:
  Keysight_53230A.py <IP#>  [--meas=<number>]
  Keysight_53230A.py -h | --help

  IP          IP number of the Frequency Counter/Timer
              (for example: 192.168.32.251 which is its DevNet IP number)

Options:
  -h --help            Show this screen.
  --version            Show version.
  -m --meas=<number>   number of measurements to be taken [default: 1]

"""

from docopt import docopt

import sys
import time
import scipy
import struct

#TJP: installed from web python-vxi Alex
import vxi11

import matplotlib.pyplot as plt

############################################################################

def get_time_interval(freq_cnt, num_meas=1):

  """
  Measure and save Keysight 53230A time interval

  freq_cnt        -- instance of python-vxi connected to the Frequency Counter/Timer
  num_meas        -- the number of measurements to be taken 

  the file output format is as described below:

  """

  timestamp = time.localtime()

  file_header  = "#MeasurementData:Keysight 53230A\n"
  file_header += "#version:0.3\n"
  file_header += "#type:ASCII\n"
  file_header += "#Time Interval 1->2\n"
  file_header += "#date:"+time.strftime(format("%d %b %Y"),timestamp)+"\n"
  file_header += "#time:"+time.strftime(format("%H:%M:%S"),timestamp)+"\n"
  file_header += "#byteorder: n.a.\n"
  file_header += "#measurements:\n"

  meas_data = []
  for measurement in range(num_meas):
    measurement = freq_cnt.ask("READ?")
    meas_data.append(measurement+"\n")
    print(measurement)

  # Write out file_header, followed by all measured data
  data = [file_header]
  for i in range(len(meas_data)):
    data.append(meas_data[i])

  filename="data/"+time.strftime(format("%y%m%d_%H_%M_%S"),timestamp)+"_freq_cnt_keysight_53230A"
  print("save waveform into file:",filename)

  file=open(filename,"w")
  for i in data:
    file.write(i)
  file.close()

  measurement_data = scipy.array(meas_data)

  return measurement_data, filename

############################################################################

def file_to_scipy_array(filename):
  """
  Retrieve the Keysight 53230A Universal Frequency Counter/Timer measurements from file.
   
  filename -- source file from which to retrieve data.
    
  returns: <type 'numpy.ndarray'> measurements
  """

  data_file = open(filename,"r")

  line = data_file.readline()
  if line.strip() != "#MeasurementData:Keysight 53230A":
    #print("Exception: file_to_scipy_array: Not a Keysight 53230A Measurement Data file.")
    Exception("file_to_scipy_array: Not a Keysight 53230A Measurement Data file.")
    data_file.close()
    return

  line = data_file.readline()
  version = line.strip().split(":")
  if not(version[0]=="#version" and version[1]=="0.3"):
    Exception("file_to_scipy_array: Keysight 53230A wrong version easurement Data file.")
    data_file.close()
    return

  lst_measurements = []

  while 1:
    line=data_file.readline()
    if len(line)==0:
      break
    if line[:len("#date:")]=="#date:":
      date_in_file=line.split(":")[1].strip()
    if line[:len("#time:")]=="#time:":
      time_lst=line.split(":")
      time_in_file=time_lst[1].strip()+":"+time_lst[2].strip()+":"+time_lst[3].strip()

    # All lines starting witout a "#" contain measurements
    if line[:len("#")]!="#":
      value = scipy.float64(line.strip())
      #print (type(value), value)
      lst_measurements.append(value)

  data_file.close()

  x_data = scipy.arange(0, len(lst_measurements), 1, dtype=scipy.float64)
  y_data = scipy.array(lst_measurements)
  measurement_data = scipy.array([x_data,y_data])

  return measurement_data

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Keysight DSO-S 254A version 01')

  num_meas = 1

  if len(sys.argv) >= 2:            # just IP number
    freq_cnt =  vxi11.Instrument(sys.argv[1])    
    #freq_cnt =  vxi11.Instrument("192.168.32.251")
    print(freq_cnt.ask("*IDN?"))
    # Returns 'Agilent Technologies,53230A,MY50001484,02.05-1519.666-1.19-4.15-127-155-35'
    if len(sys.argv) >= 3:          # There are more arguments...
      num_meas = int(sys.argv[2].split('=')[1])

    print ("num_meas", num_meas)

    # Put the device in a known state
    freq_cnt.write("*RST")

    # Setup Time Interval measurment from channel 1 -> 2
    freq_cnt.write("CONFigure:TINTerval (@1),(@2)")

    # Use external 10MHz reference
    freq_cnt.write("ROSCillator:SOURce EXTernal")


    # Channel 1 setup:
    freq_cnt.write("INP1:COUP DC")
    freq_cnt.write("INP1:RANGE 5")
    freq_cnt.write("INP1:SLOPE POS")
    freq_cnt.write("INP1:LEVEL:AUTO OFF")

    # A fixed trigger level is important for proper timing measurement
    # Choose 1.4 Volt for a direct signal.
    # With one power splitter this is reduced to 0.7 volt and with
    # With two power splitters (for cable and channel skew calibration)
    # this is even reduced to 0.35 volt

    use_power_splitter_ch1 = True
    use_power_splitter_ch2 = True

    freq_cnt.write("INP1:IMP 50")
    if use_power_splitter_ch1:
      freq_cnt.write("INP1:LEV 0.3")
    else:  
      freq_cnt.write("INP1:LEV 1.4")

    # Channel 2 setup:
    freq_cnt.write("INP2:COUP DC")
    freq_cnt.write("INP2:RANGE 5")
    freq_cnt.write("INP2:SLOPE POS")

    # A fixed trigger level is important for proper timing measurement
    # Choose 1.4 Volt for a direct signal but 0.4  Volt when the signal
    # is split by a power splitter

    freq_cnt.write("INP2:IMP 50")
    if use_power_splitter_ch2:
      freq_cnt.write("INP2:LEV 0.3")
    else:  
      freq_cnt.write("INP2:LEV 1.4")

    # initialize and wait for initialisatio to complete
    freq_cnt.write("INIT")
    freq_cnt.write("*WAI")

    d,filename = get_time_interval(freq_cnt, num_meas)
    meas_data  = file_to_scipy_array(filename)

    #plt.figure("Time Interval Measurements:")
    #x = meas_data[0]
    #y = meas_data[1]
    #plt.plot(x,y)
    #plt.show()

  sys.exit()
