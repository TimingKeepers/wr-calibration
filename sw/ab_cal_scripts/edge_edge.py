#!/usr/bin/python

"""
Delay determination from edge to edeg (for oscilloscope skew measurement)

Usage:
  edge_edge.py <IP#> [--meas=<number>]
  edge_edge.py -h | --help

  IP          IP number of the Oscilloscope
              (for example: 192.168.32.248 which is its DevNet IP number)

Options:
  -h --help            Show this screen.
  --version            Show version.
  -m --meas=<number>   number of measurements to be taken [default: 1]

"""

import sys
import delay_determination as dd
import vxi11
import scipy
import numpy
import matplotlib.pyplot as plt

# private imports:
from lib.docopt import docopt
import lib.Keysight_DSO_S_254A as DSO
#import lib.Agilent_DSO6104A as DSO
import lib.pat_gen as pat_gen

# 8B10B K symbols
K28_5p = "1100000101"   # = 0xBC (+RD)
K28_5m = "0011111010"   # = 0xBC (-RD)
K27_7p = "0010010111"   # = 0xFB is last preamble (+RD)
K27_7m = "1101101000"   # = 0xFB /S/ (-RD)
# 8B10B D symbols
D5_6   = "1010010110"   # = 0xC5 (both +RD and -RD)
D16_2p = "1001000101"   # = 0x50 (+RD)
D16_2m = "0110110101"   # = 0x50 (-RD)
D21_2  = "1010100101"   # = 0x55 is last preamble (both +RD and -RD)
D21_6  = "1010100110"   # = 0xD5 is Start of Frame Delimitter (both +RD and -RD)
D1_0p  = "1000101011"
D1_0m  = "0111010100"
D27_7p = "0010011011"
D27_0m = "1101100100"
D25_0p = "1001100100"
D25_0m = "1001101011"
D0_0p  = "0110001011"
D0_0m  = "1001110100"
D2_1p  = "0100101001"
D2_1m  = "1011011001"
D19_1  = "1100101001"
D2_0p  = "0100101011"
D2_0m  = "1011010100"
D10_7p = "0101010001"
D10_7m = "0101011110"
D8_4p  = "0001101101"
D8_4m  = "1110010010"
D23_7p = "0001011110"
D23_7m = "1110100001"

############################################################################
def average_edge_to_edge(scope, num_meas, expect_max, estimate, tolerance = 1.0e-9):
  
  """
    This function returns scipy array (<type 'numpy.ndarray'>) that holds the measured
    delay values for the time between the SFD and Edge.

    scope           -- instance of python-vxi connected to scope625Zi oscilloscope
    num_meas        -- nuber of measurement to be taken.
    expect_max      -- edge correlation result sample number maximum is expected
    estimate        -- a delay estimate, used to verify proper measurements and enable
                       to skip outliers (due to wrong automatic correlation maximum
                       determination)
    tollerance      -- delay measurements outside tollerance are skiped (default 1 ns)
        
    returns: <type 'numpy.ndarray'> -- an array of measured delay values
             samples                -- amount of samples in one waveform
             sample_period          -- the timebase used
             firts_filename         -- name of the first wavform file that contributed
             last_filename          -- name of the last wavform file that contributed
  """

  lst_meas = []
  once = True

  for i in range(num_meas):
    d,filename = DSO.get_waveforms(scope, '1,3')
    wf_data = DSO.file_to_waveform(filename)
    samples = DSO.check_waveforms(wf_data)
    # Make sure the buffer holds an even number of samples
    a , b = divmod(samples,2)
    samples = 2 * a

    if once == True:
      #once = False
      # extract the sample frequency from the preamble of the first enabled channel
      first_channel = wf_data.keys()[0]
      sample_period = wf_data[first_channel]["preamble"]["x_increment"]
      first_filename = filename

    x1 = wf_data[1]["waveform"][0][:samples]
    y1 = wf_data[1]["waveform"][1][:samples]
    x3 = wf_data[3]["waveform"][0][:samples]
    y3 = wf_data[3]["waveform"][1][:samples]

    cx,cy=dd.correlate_circular(y1, y3)

    if once == True:
      once = False
      # Cross check: The inverse correlation should yield the same but negative
      #cx1,cy1=dd.correlate_circular(y3,y1)
      plt.figure("Correlation")
      plt.plot(cx,cy)
      plt.draw()

    delay = sample_period * dd.peak_position(cx,cy,x_estimate = expect_max)

    if (delay < estimate - tolerance/2) or (delay > estimate + tolerance/2):
      print("### WARNING! Measurement",filename,"out of",estimate,"+/-", tolerance," tolerance window")
    else:
      lst_meas.append(delay)

    print("########################")

  meas = scipy.array(lst_meas)
  return(meas, samples, sample_period,first_filename, filename)

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Edge to SFD delay 1.1')

  num_meas = 1

  if len(sys.argv) >= 3:
    num_meas = int(sys.argv[2].split('=')[1])

  # When oscilloscope triggers on Channel 1 and trigger is set to the middle
  # of the screen then the expected edge maximum for edge and SFD are at:
  expect_max = -22
  estimated_delay = 7.257475000009182e-11
  tolerance       = 10.0e-9
  time_base       = 20.0e-9   # 2 ns/div

  scope =  vxi11.Instrument(sys.argv[1])    
  #scope =  vxi11.Instrument("192.168.32.248")
  print(scope.ask("*IDN?"))
  # Returns 'KEYSIGHT TECHNOLOGIES,DSOS254A,MY55160101,05.50.0004'

  # Use Channel 1 pulse input
  # use Channel 3 Ethernet Frame input

  # A fixed trigger level is important for proper timing measurement
  # Choose 1.4 Volt for a direct signal but 0.8  Volt when the signal
  # is split by a power splitter
  scope.write(":TRIGger:EDGE:SOURce CHANnel1")
  scope.write(":TRIGger:SWEep TRIGgered")

  use_power_splitter = True

  if use_power_splitter:
    scope.write(":TRIGger:LEVel CHANnel1, 0.4")
    scope.write(":CHANnel1:RANGe 2.0")     # 250 mV/div
  else:  
    scope.write(":TRIGger:LEVel CHANnel1, 0.7")
    scope.write(":CHANnel1:RANGe 3.0")     # 750 mV/div

  scope.write(":CHANnel1:INPut DCFifty")
  scope.write(":CHANnel1:OFFSet 0.0")

  scope.write(":CHANnel3:INPut DCFifty")
  scope.write(":CHANnel3:OFFSet 0.0")
  scope.write(":CHANnel3:RANGe 4.0")     # 500 mV/div


  # Trigger in the centre of the screen; important for maximum estimations
  # forwarded to function average_meas
  scope.write(":TIMebase:DELay 0")
  scope.write(":TIMebase:RANGe "+str(time_base))  # set 50 ns/div
  scope.write(":TIMebase:REFClock ON")    # set external refrence clock


  meas, samples, sample_period, first_filename, last_filename = average_edge_to_edge(scope, num_meas, expect_max, estimated_delay, tolerance)
  print("Samples:",samples)
  print("Sample Period:",sample_period)
  print("first_filename:",first_filename)
  print("last_filename:",last_filename)

  filename = last_filename+"_hist"
  print("save histogram into file:",filename)

  if len(meas) != 0:
    file=open(filename,"w")
    for i in meas:
      file.write(str(i)+"\n")

    file.write("# Above are measured delays values exracted from the following range\n")
    file.write("# of waveform files:\n")
    file.write("# First file: "+first_filename+"\n")
    file.write("# Last file:  "+last_filename+"\n")
    file.close()

    mean_delay  = numpy.mean(meas)
    max_delay   = numpy.max(meas)
    min_delay   = numpy.min(meas)
    stdev_delay = numpy.std(meas, ddof = 1)

    print("Delay between oscilloscope channels:")
    print("number of measurements:", num_meas)
    print("mean:", mean_delay)
    print("max:", max_delay)
    print("min:", min_delay)
    print("width:",max_delay-min_delay)
    print("st-dev:", stdev_delay)

    hist_edge_edge = plt.figure("Historam delay edge -> edge")
    ax = hist_edge_edge.add_subplot(111)
    ax.set_xlabel('Time')
    ax.set_ylabel('Count')
    ax.text(0.01,0.95,'mean = {0:.6g}'.format(mean_delay), transform=ax.transAxes)
    ax.text(0.01,0.90,'std = {0:.6g}'.format(stdev_delay), transform=ax.transAxes)
    ax.text(0.01,0.85,'max = {0:.6g}'.format(max_delay), transform=ax.transAxes)
    ax.text(0.01,0.80,'min = {0:.6g}'.format(min_delay), transform=ax.transAxes)
    ax.text(0.01,0.75,'n = {0:d}'.format(num_meas), transform=ax.transAxes)
    ax.hist(meas,20)
    plt.show()
  else:
    print ("### Warning: zero results for measurements; check tolerances")

  sys.exit()
