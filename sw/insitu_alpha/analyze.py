#!/usr/bin/python

"""
tic_gui: Analyzes Time Interval Count Measurements and White Rabbit Abslolute Calibration GUI output

This script calculates the differences between:
- the time measured on the Time Interval Counter for PPS -> Tx/Rx-timestamp
- the time stamped by the WR device (t1/t4) that was outputted on the WR GUI
  while running the absolute calibration software.

Measuremenrs should be taken while the WR device is in GrandMaster mode
('mode gm') and locked to an external 10 MHz reference. Measurments are started
after the 'ptp start' command

The same reference clock mentioned above should also have been used for the Time Interval Counter measurement!

Usage:
  tic_gui.py     <crtt_file>
  tic_gui.py     -h | --help

  <crtt_file>    <type 'str'> file name that contains the crtt measurements
                 for different SFP wavelengthes

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

# private imports:
from lib.docopt import docopt

############################################################################

def file_to_scipy_array(filename):
  """
  Retrieve the measurement file
   
  filename -- source file from which to retrieve data.
    
  returns: <type 'numpy.ndarray'> measurements
  """

  # create an empty dictionairy
  crtt_data = {}
  data_file = open(filename,"r")

  line = data_file.readline()
  #print(line)
  if line.strip() != "#In Situ Alpha measurements":
    Exception("file_to_scipy_array: Not an In Situ Alpha measurements file.")
    data_file.close()
    return (crtt_data)

  line = data_file.readline()	# Read date
  #print(line)
  line = data_file.readline()	# Read time
  #print(line)
  line = data_file.readline()	# Read comment
  #print(line)

  # create an empty lists for fields:
  # channel, ITU channel, ITU wavelength [nm], crtt
  lst_channel   = []
  lst_itu_channel  = []
  lst_itu_wavelength   = []
  lst_crtt  = []

  while 1:
    line=data_file.readline()
    line_lst = line.split(",")
    if len(line_lst) < 4:
      break

    # Values one one line are:
    # channel, ITU channel, ITU wavelength [nm], crtt
    lst_channel.append(line_lst[0])
    lst_itu_channel.append(line_lst[1])
    lst_itu_wavelength.append(line_lst[2])
    lst_crtt.append(line_lst[3])

  data_file.close()

  crtt_data["channel"]=scipy.array(lst_channel)
  crtt_data["itu_channel"]=scipy.array(lst_itu_channel)
  crtt_data["itu_wavelength"]=scipy.array(lst_itu_wavelength)
  crtt_data["crtt"]=scipy.array(lst_crtt)

  return crtt_data

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Analyze In Sity Alpha Measurements')

  if len(sys.argv) != 2:
    print ("### wrong number of input arguments")
    sys.exit()
  else:
    insitu_file = sys.argv[1]

    crtt_data = file_to_scipy_array(insitu_file)

    #print(crtt_data["itu_channel"])
    #print(crtt_data["crtt"])

    fig = plt.figure("CRTT versus ITU Channel number")
    ax = fig.add_subplot(111)
    ax.set_xlabel('ITU Channel number')
    ax.set_ylabel('CRTT')
    x = crtt_data["itu_channel"]
    ax.plot(x,crtt_data["crtt"])
    plt.draw()
    plt.show()

  sys.exit()
