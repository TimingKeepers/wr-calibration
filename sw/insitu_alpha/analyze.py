#!/usr/bin/python

"""
analyze.py: Analyzes itu_channel/wavelength/crtt that was stored in a file

Usage:
  analyze.py     <crtt_file>
  analyze.py     -h | --help

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
import lib.wrt_sfppt015sc as tunable

############################################################################

def file_to_dict(filename):
  """
  Retrieve the measurement file
   
  filename -- source file from which to retrieve data.
    
  returns: <type 'dict'>
              key        : value
              itu_channel: [wavelength, crtt]
  """

  # create an empty dictionairy
  crtt_data = {}
  data_file = open(filename,"r")

  line = data_file.readline()
  #print(line)
  if line.strip() != "#In Situ Alpha measurements":
    Exception("file_to_dict: Not an In Situ Alpha measurements file.")
    data_file.close()
    return (crtt_data)

  line = data_file.readline()	# Read date
  #print(line)
  line = data_file.readline()	# Read time
  #print(line)
  line = data_file.readline()	# Read comment
  #print(line)

  # create an empty lists for fields:
  # sfp module channel, ITU channel, ITU wavelength [nm], crtt

  while 1:
    line=data_file.readline()
    if line[:len("#")]!="#":  # Skip lines that are commented out
      line_lst = line.split(",")
      if len(line_lst) < 4:
        break

      # Values one one line are:
      # channel, ITU channel, ITU wavelength [nm], crtt
      lst_meas = []
      lst_meas.append(line_lst[2])		# Wavelength
      lst_meas.append(line_lst[3])		# crtt
      lst_meas.append(line_lst[0])		# sfp module channel number
      crtt_data.update({line_lst[1]:lst_meas})	# itu_channel: [wavelength, crtt]

  data_file.close()

  #for key_itu_ch,value_itu_ch in sorted(crtt_data.items()):
  #  print (key_itu_ch, value_itu_ch)

  return (crtt_data)

############################################################################

def dict_to_narray(crtt_data):
  """
  converts the data that is stored in crtt_data <type 'dict'> into 
  <type 'numpy.ndarray'>
   
  returns: <type 'numpy.ndarray'>
  """

  crtt_array = {}
  lst_channel = []
  lst_itu_channel = []
  lst_itu_wavelength = []
  lst_crtt = []

  for key_itu_ch,value_itu_ch in sorted(crtt_data.items()):
    #print (key_itu_ch, value_itu_ch)
    lst_itu_channel.append(key_itu_ch)
    lst_itu_wavelength.append(value_itu_ch[0])
    lst_crtt.append(value_itu_ch[1])
    lst_channel.append(value_itu_ch[2])

  crtt_array["itu_channel"]=scipy.array(lst_itu_channel)
  crtt_array["itu_wavelength"]=scipy.array(lst_itu_wavelength)
  crtt_array["crtt"]=scipy.array(lst_crtt)
  crtt_array["channel"]=scipy.array(lst_channel)

  return (crtt_array)

############################################################################
def calc_alpha(cl_wl, crtt_data, ref_itu_channel, fixed_itu_channel=20):
  """
  calc_alpha calculates the alpha factors for the wavelengths in the
  crtt_data array of measurements.
  It takes a ref_itu_channel for lambda 1 ans scans lambda 2 over each
  other measurment.
  A fixed wavelenth is used for either the forward or the backward
  connection between master ans slave.
  """
  
  tuneable_sfp_ch = tunable.sfp_channel(fixed_itu_channel)
  wl = cl_wl[tuneable_sfp_ch][2]

  print("fixed itu channel:",fixed_itu_channel, "= WRT-SFPPT015SC channel:", tuneable_sfp_ch, "wavelength: ", wl)

  return(0)

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

    crtt_data = file_to_dict(insitu_file)
    crtt_array = dict_to_narray(crtt_data)

    #calc_alpha(cl_wl,crtt_data,11)
    #sys.exit()

    fig = plt.figure("CRTT versus ITU Channel number")
    ax = fig.add_subplot(111)
    ax.set_xlabel('ITU Channel number')
    ax.set_ylabel('CRTT')
    ax.text(0.01,0.95,str(insitu_file), transform=ax.transAxes)
    x = crtt_array["itu_channel"]
    ax.plot(x,crtt_array["crtt"])
    plt.draw()
    plt.show()

  sys.exit()
