#!/usr/bin/python

"""
tic_gui: Analyzes Time Interval Count Measurements and White Rabbit Abslolute
    Calibration GUI output

-------------------------------------------------------------------------------
Copyright (C) 2016 Peter Jansweijer

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>
-------------------------------------------------------------------------------

This script calculates the differences between:
- the time measured on the Time Interval Counter for PPS -> Tx/Rx-timestamp
- the time stamped by the WR device (t1/t4) that was outputted on the WR GUI
  while running the absolute calibration software.

Measuremenrs should be taken while the WR device is in GrandMaster mode
('mode gm') and locked to an external 10 MHz reference. Measurments are started
after the 'ptp start' command

The same reference clock mentioned above should also have been used for the
Time Interval Counter measurement!

Usage:
  tic_gui.py     <tic_file> <wr_gui_file> <meas_type>
  tic_gui.py     <tic_file> <"tic">
  tic_gui.py     -h | --help

  <tic_file>     <type 'str'> file name that contains the Time Interval
                 measurements between pps_o and either tx_ts or rx_ts output
  <wr_gui_file>  <type 'str'> name of file containing the Time Interval
                 measurements between pps_o and either tx_ts or rx_ts output
  <meas_type>    <type 'str'> either
                 "t1"   -> (measured TIC for PPS/Tx-ts) - (WR_GUI t1)
                 "t4"   -> (measured TIC for PPS/Rx-ts) - (WR_GUI t4)
                 "t1_4" -> (WR_GUI t4) - (WR_GUI t1)
                 "tic"  -> histogram just the time interval measurements

Options:
  -h --help    Show this screen.
  --version    Show version.
"""

import sys
import time
import struct

#TJP: installed from web python-vxi Alex
import vxi11

import scipy
import numpy
import matplotlib.pyplot as plt

# Add parent directory (containing 'lib') to the module search path
sys.path.insert(0,'..')

# private imports:
from lib.docopt import docopt
import lib.Keysight_53230A as tic

############################################################################

def wr_abs_cal_gui_file_to_scipy_array(filename):
  """
  Retrieve the White Rabbit GUI info which is written during Absolute Calibration
   
  filename -- source file from which to retrieve data.
    
  returns: <type 'numpy.ndarray'> measurements
  """

  data_file = open(filename,"r")
  # header = data_file.read(5)           # read the waveform_header "wrc# "
  #if header != "wrc# ":
    #print("Exception: wr_abs_cal_gui_file_to_scipy_array: Not a WR Absolute Calibration GUI file.")
    #Exception("wr_abs_cal_gui_file_to_scipy_array: Not a WR Absolute Calibration GUI file.")
    #data_file.close()
    #return

  # create an empty gui_data dictionairy
  gui_data     = {}

  # create an empty lists for t1 and t4 components
  lst_t1_sec   = []
  lst_t1  = []
  lst_t4_sec   = []
  lst_t4  = []

  while 1:
    line=data_file.readline()
    line_lst = line.split(" ")
    if len(line_lst) < 6:
      break

    # Values one one line are:
    # t1 sec, t1[ns], t1_phase[ps], t4 sec, t4[ns], t4_phase[ps]
    # to calculate proper t1 and t4
    # ns must be scaled 1e-9 and phase scaled with 1e-12
    lst_t1_sec.append(line_lst[0])
    lst_t1.append(1e-9 * scipy.float64(line_lst[1]) + 1e-12 * scipy.float64(line_lst[2]))
    lst_t4_sec.append(line_lst[3])
    lst_t4.append(1e-9 * scipy.float64(line_lst[4]) + 1e-12 * scipy.float64(line_lst[5]))

  data_file.close()

  t1_sec = scipy.array(lst_t1_sec)
  t1 = scipy.array(lst_t1)
  t4_sec = scipy.array(lst_t4_sec)
  t4 = scipy.array(lst_t4)

  gui_data["t1 seconds"]=(t1_sec)
  gui_data["t1"]=(t1)
  gui_data["t4 seconds"]=(t4_sec)
  gui_data["t4"]=(t4)

  return gui_data

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Keysight DSO-S 254A version 01')

  tic_file = sys.argv[1]
  if len(sys.argv) == 3 and sys.argv[2] == "tic":
    tic_data = tic.file_to_scipy_array(tic_file)
    num = len(tic_data[0]) # x-axis in [0]
    t_hist = tic_data[1]   # y-axis in [1]
    hist_tic = plt.figure("Time Interval Counter skew")
  elif len(sys.argv) != 4:
    print ("### wrong number of input arguments")
    sys.exit()
  else:
    wr_gui_file = sys.argv[2]
    src = sys.argv[3]
    if src == "t1":
      ts_output = "tx_ts"
    elif src == "t4":
      ts_output = "rx_ts"
    elif src == "t1_4":
      ts_output = ""
    else:
      print ("### wrong timestamp source")
      sys.exit()

    gui_data = wr_abs_cal_gui_file_to_scipy_array(wr_gui_file)

    if src == "t1_4":
      t_hist = gui_data["t4"] - gui_data["t1"]
      num = len(gui_data["t1"])
      print("Delay between internal timestamp t1 and t4 (i.e. t4-t1):")
      hist_tic = plt.figure("Historam difference WR (t4-t1)")
    else:
      tic_data = tic.file_to_scipy_array(tic_file)

      num_tic = len(tic_data[0]) # x-axis in [0]
      num_gui = len(gui_data[src])
      num = min(num_tic,num_gui)

      print ("Measurements found in 53230A file:",num_tic,"in WR_GUI file:", num_gui)
      print ("Measurements to take into account:",num)
      print("Delay between internal timestamp "+src+" to "+ts_output+":")

      fig = plt.figure("Time Interval Counter measurements and WR GUI "+src+" versus measurment number")
      ax = fig.add_subplot(111)
      ax.set_xlabel('measurement number')
      ax.set_ylabel('TIC value, WR '+src)
      x = tic_data[0][:num]
      ax.plot(x,tic_data[1][:num])
      ax.plot(x,gui_data[src][:num])
      plt.draw()
      t_hist = tic_data[1][:num] - gui_data[src][:num]
      hist_tic = plt.figure("Historam difference (pps->ts) - WR "+src)

  mean_delay  = numpy.mean(t_hist)
  max_delay   = numpy.max(t_hist)
  min_delay   = numpy.min(t_hist)
  stdev_delay = numpy.std(t_hist, ddof = 1)

  print("number of measurements:", num)
  print("mean:", mean_delay)
  print("max:", max_delay)
  print("min:", min_delay)
  print("width:",max_delay-min_delay)
  print("st-dev:", stdev_delay)

  ax = hist_tic.add_subplot(111)
  ax.set_xlabel('Time')
  ax.set_ylabel('Count')
  ax.text(0.01,0.95,'mean = {0:.6g}'.format(mean_delay), transform=ax.transAxes)
  ax.text(0.01,0.90,'std = {0:.6g}'.format(stdev_delay), transform=ax.transAxes)
  ax.text(0.01,0.85,'max = {0:.6g}'.format(max_delay), transform=ax.transAxes)
  ax.text(0.01,0.80,'min = {0:.6g}'.format(min_delay), transform=ax.transAxes)
  ax.text(0.01,0.75,'n = {0:d}'.format(num), transform=ax.transAxes)
  ax.hist(t_hist,bins=20)
  plt.show()

  sys.exit()
