#!/usr/bin/python

"""
Delay determination from edge to Start Of Frame Delimiter
The oscilloscope needs to be hooked up in the following way:
Ch 1: The timestamp pulse
Ch 3: SFP+ Calibartion SMA "P"
Ch 4: SFP+ Calibartion SMA "N"

For a first run with one measurement using either:
  edge_sdf.py <IP#>
  edge_sdf.py <IP#> [--bitwidth=<20>] [--timebase=<float>]
Next look at the correlation plot and find the sample numbers for the pulse
and SFD maximum.
Redo measurement, now with the proper estimated max edge and sfd sample values.
  edge_sdf.py <IP#> [--edge=<i>] [--sfd=<i>] [--bitwidth=<20>] [--timebase=<float>]
Record the actual (mean) delay found and use this as a parameter for the estimated
delay. The default tolerance will automatically be narrowed to 10 ns (unless
otherwise specified)
Now a number of measurments (-m,--meas) can be taken to gather statistics
  edge_sdf.py <IP#> [--edge=<i>] [--sfd=<i>] [--del=<f>] [--bitwidth=<20>] [--timebase=<float>] [--meas=<i>]

Usage:
  edge_sdf.py <IP#>
  edge_sdf.py <IP#> [--bitwidth=<20>] [--timebase=<float>]
  edge_sdf.py <IP#> [--edge=<i>] [--sfd=<i>] [--del=<f>] [--tol=50.0e-8] [--bitwidth=<20>] [--timebase=<float>] [--meas=<i>]
  edge_sdf.py -h | --help

  IP          IP number of the Oscilloscope
              (for example: 192.168.32.248 which is its DevNet IP number)

Options:
  -h --help         : Show this screen.
  --version         : Show version.
  -e,--edge=<i>     : <int> expect_max_edge [default: 0]
                      scypi array sample number where the correlation maximum
                      is expected (may be a negative number)
  -s,--sfd=<i>      : <int> expect_max_sfd  [default: 0]
                      scypi array sample number where the correlation maximum
                      is expected (may be a negative number)
  -d,--del=<f>      : <float> estimated_delay [default: 0]
  -t,--tol=<sec>    : <float> tolerance [default: 10.0e-9] specifies how far the
                      measured delay may be off target. Tolerance helps you to
                      skip outliers in your measurements.
  -b,--bitwidth=<i> : <int> bit width [default: 20] timestamp pulse width in number
                      of serial bits (usual 20 = 16 ns for 62.5 MHz sysclk and
                      10 = 8 ns for 125MHz sysclk)
  --timebase=<sec>  : <float> time base [default: 50.0e-8]  # 50 ns/div
  -m,--meas=<i>     : <int> number of measurements to be taken [default: 1]
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
def correlate_mathematical_eth_sfd():
  
  """
    This function returns scipy array (<type 'numpy.ndarray'>) that holds the measured
    delay values for the time between the SFD and Edge.

    scope           -- instance of python-vxi connected to scope625Zi oscilloscope
    num_meas        -- nuber of measurement to be taken.
    expect_max_edge -- edge correlation result sample number maximum is expected
    expect_max_sdf  -- edge correlation result sample number maximum is expected
        
    returns: <type 'numpy.ndarray'> is an array of measured delay values
  """

  bit_rate = 1.25e+9     # fixed for 1 Gbps to 1250 MHz (i.e. one bit = 800 ps)

  samples = 15984
  a , b = divmod(samples,2)
  samples = 2 * a
  sample_period = 50.0e-12

  eth_frame = 22*(K28_5m+D16_2p)+K27_7m+5*D21_2+D21_6+D1_0m+D27_7p+D25_0m+D0_0p+D0_0m+D0_0p+D2_1m+D19_1+D2_0p+D10_7m+D8_4p+D16_2m+D8_4p+D23_7m+D0_0p+D2_0m+D1_0m+D27_7p+D25_0m+D0_0p+D0_0m+D0_0p+D2_1m+D19_1+D2_0p+D10_7m+D8_4p+D16_2m+D8_4p+D23_7m+D0_0p+D2_0m+D0_0p+D19_1+D2_0p+D10_7m+D8_4p+D16_2m+D8_4p+D23_7m+D0_0p+D2_0m+D0_0p+D8_4p+D23_7m+D0_0p+D2_0m+D0_0p
  print("eth_frame:")
  print(eth_frame)
  print("eth_length:", len(eth_frame))

  eth = pat_gen.scipy_array_from_pattern(eth_frame,samples,bit_rate, sample_period, 1.0, 0.0)
  sfd = pat_gen.scipy_array_from_pattern(D21_2 + D21_6,samples,bit_rate, sample_period, 1.0, 0.0)

  cx,cy=dd.correlate_circular(eth[1], sfd[1])

  math_cor = plt.figure("Correlation 'mathematical' Eth frame and SDF <D21.2><D21.6>")
  ax = math_cor.add_subplot(111)
  ax.set_xlabel('Sample')
  ax.set_ylabel('Correlation')
  ax.plot(cx,cy)
  plt.draw()
  return()

############################################################################
def average_edge_to_sfd(scope, num_meas, bit_width, expect_max_edge, expect_max_sfd, estimate, tolerance = 1.0e-9):
  
  """
    This function returns scipy array (<type 'numpy.ndarray'>) that holds the measured
    delay values for the time between the SFD and Edge.

    scope           -- instance of python-vxi connected to scope625Zi oscilloscope
    num_meas        -- nuber of measurement to be taken.
    bit_width       -- the number of bits for a pulse (20 bits for 16 ns, 10 bits for 8 ns)
    expect_max_edge -- edge correlation result sample number maximum is expected
    expect_max_sdf  -- edge correlation result sample number maximum is expected
    estimate        -- a delay estimate, used to verify proper measurements and enable
                       to skip outliers (due to wrong automatic correlation maximum
                       determination)
    tollerance      -- delay measurements outside tollerance are skiped (default 1 ns)
    tollerance      -- delay measurements outside tollerance are skiped (default 1 ns)
        
    returns: <type 'numpy.ndarray'> -- an array of measured delay values
             samples                -- amount of samples in one waveform
             sample_period          -- the timebase used
             firts_filename         -- name of the first wavform file that contributed
             last_filename          -- name of the last wavform file that contributed
  """

  bit_rate = 1.25e+9     # fixed for 1 Gbps to 1250 MHz (i.e. one bit = 800 ps)

  lst_edge_to_sfd = []
  once = True

  for i in range(num_meas):
    d,filename = DSO.get_waveforms(scope, '1,3,4')
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

      sfd = pat_gen.scipy_array_from_pattern(D21_2 + D21_6,samples,bit_rate, sample_period, 1.0, 0.0)
      # One bit time = 800 ps. Pulse is 16 ns = 20 bit times
      edge = pat_gen.scipy_array_from_pattern(str(bit_width*"0"+bit_width*"1"),samples,bit_rate, sample_period, 1.0, 0.0)

    x1 = wf_data[1]["waveform"][0][:samples]
    y1 = wf_data[1]["waveform"][1][:samples]
    x3 = wf_data[3]["waveform"][0][:samples]
    y3 = wf_data[3]["waveform"][1][:samples]
    x4 = wf_data[4]["waveform"][0][:samples]
    y4 = wf_data[4]["waveform"][1][:samples]

    y_diff = y3 - y4

    c_sfd_x,c_sfd_y=dd.correlate_circular(y_diff, sfd[1])
    c_edge_x,c_edge_y=dd.correlate_circular(y1, edge[1])

    if once == True:
      once = False
      # Cross check: The inverse correlation should yield the same but negative
      #c_edge_x1,c_edge_y1=dd.correlate_circular(edge[1],y1)
      cor = plt.figure("Correlations: Pulse & SFD")
      ax = cor.add_subplot(111)
      ax.set_xlabel('Sample')
      ax.set_ylabel('Correlation')
      ax.plot(c_sfd_x,c_sfd_y)
      ax.plot(c_edge_x,c_edge_y)
      #ax.plot(c_edge_x1,c_edge_y1)
      plt.draw()

      wv_34 = plt.figure("Waveforms: Ch1 & Ch3-ch4")
      ax = wv_34.add_subplot(111)
      ax.set_xlabel('Time')
      ax.set_ylabel('Volt')
      ax.plot(x1,y1)
      ax.plot(x3,y_diff)
      plt.draw()

    d_edge= sample_period * dd.peak_position(c_edge_x,c_edge_y,x_estimate = expect_max_edge)
    d_sfd= sample_period * dd.peak_position(c_sfd_x,c_sfd_y,x_estimate = expect_max_sfd)

    if (d_edge - d_sfd < estimate - tolerance/2) or (d_edge - d_sfd > estimate + tolerance/2):
      print("### WARNING! Measurement",filename,"out of",estimate,"+/-", tolerance," tolerance window")
    else:
      lst_edge_to_sfd.append(d_edge - d_sfd)

    print("########################")

  edge_to_sfd = scipy.array(lst_edge_to_sfd)
  return(edge_to_sfd, samples, sample_period,first_filename, filename)

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Edge to SFD delay 1.1')

  # defaults:
  DEFAULT_TOL     = 1.0e+9

  expect_max_edge = 0
  expect_max_sfd  = 0
  estimated_delay = 0.0
  tolerance       = DEFAULT_TOL
  bit_width       = 20
  time_base       = 50.0e-9   # 50 ns/div
  num_meas = 1

  if len(sys.argv) < 8:
    for i in range(1,len(sys.argv)):
      option = sys.argv[i].split('=')
      if option[0] == '-e' or option[0] == '--edge':
        expect_max_edge = int(option[1])
      if option[0] == '-s' or option[0] == '--sfd':
        expect_max_sfd = int(option[1])
      if option[0] == '-d' or option[0] == '--del':
        estimated_delay = float(option[1])
        # when delay is given... Then new default tolerance = 10 ns
        # unless otherwise specified
        if tolerance == DEFAULT_TOL:
          tolerance = 10.0e-9
      if option[0] == '-t' or option[0] == '--tol':
        tolerance = float(option[1])
      if option[0] == '--bitwidth':
        bit_width = int(option[1])
      if option[0] == '--timebase':
        time_base = float(option[1])
      if option[0] == '-m' or option[0] == '--meas':
        num_meas = int(option[1])

    # When oscilloscope triggers on Channel 1 and trigger is set to the middle
    # of the screen then the expected edge maximum for edge and SFD are at:
  else:
    print ("### wrong measurement type")
    sys.exit()


  scope =  vxi11.Instrument(sys.argv[1])    
  #scope =  vxi11.Instrument("192.168.32.245")

  # Initialize oscilloscope
  # Use Channel 1 pulse input
  # use Channel 3-4 Ethernet Frame input
  DSO.osc_init(scope, time_base)    

  edge_to_sfd, samples, sample_period, first_filename, last_filename = average_edge_to_sfd(scope, num_meas, bit_width, expect_max_edge, expect_max_sfd, estimated_delay, tolerance)
  print("Samples:",samples)
  print("Sample Period:",sample_period)
  print("first_filename:",first_filename)
  print("last_filename:",last_filename)

  filename = last_filename+"_hist"
  print("save histogram into file:",filename)

  if len(edge_to_sfd) != 0:
    file=open(filename,"w")
    for i in edge_to_sfd:
      file.write(str(i)+"\n")

    file.write("# Above are measured delays values exracted from the following range\n")
    file.write("# of waveform files:\n")
    file.write("# First file: "+first_filename+"\n")
    file.write("# Last file:  "+last_filename+"\n")
    file.close()

    mean_delay  = numpy.mean(edge_to_sfd)
    max_delay   = numpy.max(edge_to_sfd)
    min_delay   = numpy.min(edge_to_sfd)
    stdev_delay = numpy.std(edge_to_sfd, ddof = 1)

    print("Input parameters used:")
    print("  expect_max_edge",expect_max_edge)
    print("  expect_max_sfd",expect_max_sfd)
    print("  estimated_delay",estimated_delay)
    print("  tolerance",tolerance)
    print("  bit_width",bit_width)
    print("  time_base",time_base)
    print("  num_meas",num_meas)

    print("Delay between edge and Start Of Frame delimiter:")
    print("  number of measurements:", num_meas)
    print("  mean:", mean_delay)
    print("  max:", max_delay)
    print("  min:", min_delay)
    print("  width:",max_delay-min_delay)
    print("  st-dev:", stdev_delay)

    hist_edge_sfd = plt.figure("Historam delay pulse to SFD")
    ax = hist_edge_sfd.add_subplot(111)
    ax.set_xlabel('Time')
    ax.set_ylabel('Count')
    ax.text(0.01,0.95,'mean = {0:.6g}'.format(mean_delay), transform=ax.transAxes)
    ax.text(0.01,0.90,'std = {0:.6g}'.format(stdev_delay), transform=ax.transAxes)
    ax.text(0.01,0.85,'max = {0:.6g}'.format(max_delay), transform=ax.transAxes)
    ax.text(0.01,0.80,'min = {0:.6g}'.format(min_delay), transform=ax.transAxes)
    ax.text(0.01,0.75,'n = {0:d}'.format(num_meas), transform=ax.transAxes)
    ax.hist(edge_to_sfd,20)
    plt.show()

  else:
    print ("### Warning: zero results for measurements; check tolerances")

sys.exit()
