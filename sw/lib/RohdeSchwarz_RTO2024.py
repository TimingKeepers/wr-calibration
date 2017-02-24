#!/usr/bin/python

"""
Rohde & Schwarz RTO2024 remote control

-------------------------------------------------------------------------------
Copyright (C) 2016 Peter Jansweijer, 'stolen' from Tjeerd Pinkert and freely
    adjusted

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

Usage:
  RohdeSchwarz_RTO2024.py <IP#> [-c<1,2,3,4>] [-a<averages>]
  RohdeSchwarz_RTO2024.py -h | --help

  IP          IP number of the Oscilloscope
              (for example: 192.168.32.248 which is its DevNet IP number)

Options:
  -h --help   Show this screen.
  --version   Show version.
  -c<1,2,3,4> channel number
  -a          number of averages [default: 1]

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

def get_sweeps(scope, chan_str):
  # scope.write("ACQuire:COUNt 100")      Set RohdeSchwarz avarage number
  # print(scope.ask("ACQuire:COUNt?"))    read this back
  # print(scope.ask("ACQuire:CURRent?"))  Wait for acquisitions to complete
  sweep_str = str(scope.ask(chan_str + ':INSPECT? SWEEPS_PER_ACQ')).split(':')[2]
     # returns something like:
     # u'C1:INSP "SWEEPS_PER_ACQ     : 30                 "'
  sweep = int(sweep_str.strip('"').strip())       # strip the last " and spaces before cast to int
  return sweep

############################################################################

def get_waveforms(scope, channels=[1,2,3,4], num_avg=1):

  """
  Measure and save Keysight DSO-S 254A waveforms

  scope           -- instance of python-vxi connected to the oscilloscope
  channels        -- channels that are going to be measured for example '1,2'
  num_avg         -- the number of averiges taken by the oscilloscope

  the file output format is as described below:

  ----------------------------------
    #WaveformData:Keysight DSO-S 254A
    #version:0.2
    #type:RAW
    #channel:1,2,..
    #time:21 Jan 2016 11:03:38
    #byteorder:LSBFIRST
    #preamble:
      <channel 1 preamble>
    #preamble:
      <channel 2 preamble>
    #waveform_data:
      <channel 1 data>
    #waveform_data:
      <channel 2 data>
  ----------------------------------
  "preamble" data is a comma separated string
  "waveform_data" is binary data
  """

  scope.write(":STOP")                #Stop any running acquisition

  scope.write(":SYSTem:HEADer OFF")
  scope.write(":ACQuire:MODE RTIME")
  scope.write(":ACQuire:COMPlete 100")
  scope.write(":WAVeform:BYTeorder LSBFirst")
  scope.write(":WAVeform:FORMat WORD")
  
  if num_avg > 1:
    scope.write(":ACQUIRE:AVERAGE ON")
    scope.write(":ACQuire:COUNt "+str(num_avg))
  else:
    scope.write(":ACQUIRE:AVERAGE OFF")
  
  #scope.write(":ACQuire:POINts "+str(record_len))

  for chan in channels.split(','):
    scope.write(":CHANNEL"+str(chan)+":DISPLAY ON")     # For Function or Channel

  scope.write(":DIGitize")   # Whitout paramters => digitize operation is
                             # performed on the channels that are being
                             # displayed in the Infiniium waveform viewing area. 

#  scope.write(":TRIGGER:SWEEP SINGLE")
#  scope.write(":RUN")

  timestamp = time.localtime()

  file_header  = "#WaveformData:Keysight DSO-S 254A\n"
  file_header += "#version:0.2\n"
  file_header += "#type:RAW\n"
  file_header += "#channel:"+str(channels)+"\n"
  file_header += "#date:"+time.strftime(format("%d %b %Y"),timestamp)+"\n"
  file_header += "#time:"+time.strftime(format("%H:%M:%S"),timestamp)+"\n"
  file_header += "#byteorder:LSBFIRST\n"
  channel_preamble = []
  channel_data = []

  for chan in channels.split(','):
    scope.write(":WAVeform:SOURce CHANnel"+str(chan))
    channel_preamble.append("#preamble:\n")
    channel_preamble.append(scope.ask(":WAVeform:PREamble?")+"\n")
    channel_data.append("#waveform:\n")
    channel_data.append(scope.ask_raw(":WAVeform:DATA?")+"\n")

  # Write out file_header, followed by all preambles, followed by all channel_data
  data = [file_header]
  for i in range(len(channel_preamble)):
    data.append(channel_preamble[i])
  for i in range(len(channel_data)):
    data.append(channel_data[i])

  filename="data/"+time.strftime(format("%y%m%d_%H_%M_%S"),timestamp)+"_scope_keysight_dso_s_254A_bin"
  print("save waveform into file:",filename)

  file=open(filename,"w")
  for i in data:
    file.write(i)
  file.close()
  return data, filename

############################################################################

def preamble_string_to_dict(preamble_string):
    """
    Create DSO preamble dict from raw preamble string
    
    preamble_string -- raw preamble string as obtained from oscilloscope query
    
    returns: dict with parsed preamble string
    """
    _formats={
        0:"ASCII",
        1:"BYTE",
        2:"WORD",
        3:"LONG",
    }
    _types={
        1:"RAW",
        2:"AVERAGE",
        3:"VHISTOGRAM",
        4:"HHISTOGRAM",
        6:"INTERPOLATE",
        10:"PDETECT",
    }
    _couplings={
        0:"AC",
        1:"DC",
        2:"DCFIFTY",
        3:"LFREJECT",
    }
    _acquisition_modes={
        0:"RTIME",
        1:"ETIME",
        3:"PDETECT",
    }
    _units={
        0:"UNKNOWN",
        1:"VOLT",
        2:"SECOND",
        3:"CONSTANT",
        4:"AMP",
        5:"DECIBEL"
    }
    _preamble=None

    _preamble_raw=preamble_string
    preamble_fields=preamble_string.split(",")
    _preamble={}
    _preamble["format"]=_formats[int(preamble_fields.pop(0))]
    _preamble["type"]=_types[int(preamble_fields.pop(0))]
    _preamble["points"]=int(preamble_fields.pop(0))
    _preamble["count"]=int(preamble_fields.pop(0))
    _preamble["x_increment"]=float(preamble_fields.pop(0))
    _preamble["x_origin"]=float(preamble_fields.pop(0))
    _preamble["x_reference"]=float(preamble_fields.pop(0))
    _preamble["y_increment"]=float(preamble_fields.pop(0))
    _preamble["y_origin"]=float(preamble_fields.pop(0))
    _preamble["y_reference"]=float(preamble_fields.pop(0))
    _preamble["coupling"]=_couplings[int(preamble_fields.pop(0))]
    _preamble["x_display_range"]=float(preamble_fields.pop(0))
    _preamble["x_display_origin"]=float(preamble_fields.pop(0))
    _preamble["y_display_range"]=float(preamble_fields.pop(0))
    _preamble["y_display_origin"]=float(preamble_fields.pop(0))
    _preamble["date"]=str(preamble_fields.pop(0).strip("\""))
    _preamble["time"]=str(preamble_fields.pop(0).strip("\""))
    _preamble["frame_model_#"]=str(preamble_fields.pop(0).strip("\""))
    _preamble["acquisition_mode"]=_acquisition_modes[int(preamble_fields.pop(0))]
    _preamble["completion"]=int(preamble_fields.pop(0))
    _preamble["x_units"]=_units[int(preamble_fields.pop(0))]
    _preamble["y_units"]=_units[int(preamble_fields.pop(0))]
    _preamble["bandwidth_maximum"]=float(preamble_fields.pop(0))
    _preamble["bandwidth_minimum"]=float(preamble_fields.pop(0))

    if not len(preamble_fields)==0:
        _preamble=None
        raise Exception("preamble_string_to_dict: Excess information in preamble")

    return _preamble

############################################################################

def raw_to_scipy_array (waveform_raw, byte_order, preamble):
  """
  Interpreting the waveform block of raw data according to the preamble data.
  The waveform binary data is transformed to an x_data, y_data array in scale units
  given in preamble.

    preamble     -- preamble dictionary.
    waveform_raw -- raw block datastream excluding length header
    byteorder    -- byteorder (MSBFIRST, LSBFIRST) of the BINARY, BYTE and WORD formats.
        
    returns: <type 'numpy.ndarray'> array([[x1,x2,x3,...,xn],[y1,y2,y3,...,yn]])
  """

  #initialise class constants
  _byteorder_conversion={
    "MSBFIRST":{
      "BYTE":[">","b"],
      "WORD":[">","h"],
      "BINARY":[">","i"],
    },
    "LSBFIRST":{
      "BYTE":["<","b"],
      "WORD":["<","h"],
      "BINARY":["<","i"],
    },
  }

  format_string  = _byteorder_conversion[byte_order][preamble['format']][0]
  format_string += str(preamble["points"])
  format_string += _byteorder_conversion[byte_order][preamble['format']][1]

  #Convert to unit values.
  y_data=scipy.array(struct.unpack(format_string, waveform_raw), 
      dtype=scipy.float64) * preamble["y_increment"] + preamble["y_origin"]
  x_data=scipy.arange(preamble["points"]) * preamble["x_increment"] + preamble["x_origin"]

  #create array with x,y axis values.
  waveform_data = scipy.array([x_data,y_data])

  return waveform_data

############################################################################

def check_waveforms(waveform_data):
  """
  This function checks for the consistency of the captured waveform.
   
  waveform_data -- <type 'dict'> waveform_data (as returned by funtion "file_to_waveform")

  returns: number of points (of the first waveform found)
  """

  first = True

  for ch in waveform_data.keys():
    if first== True:
      first    = False
      channel  = ch
      points   = waveform_data[ch]["preamble"]["points"]
      print("Info: Record Length is", points,"sampels")
      count    = waveform_data[ch]["preamble"]["count"]
      x_inc    = waveform_data[ch]["preamble"]["x_increment"]
      print("Info: Sample Period is", x_inc)
      timebase = waveform_data[ch]["preamble"]["x_display_range"]
    else:
      if waveform_data[ch]["preamble"]["points"] != points:
        print("### WARNING! Different array length!")
        print("             Channel:",channel,points)
        print("             Channel:",ch,waveform_data[ch]["preamble"]["points"])
      if waveform_data[ch]["preamble"]["count"] != count:
        print("### WARNING! Different sweep counts per acquisition!")
        print("             Channel:",channel,count)
        print("             Channel:",ch,waveform_data[ch]["preamble"]["count"])
      if waveform_data[ch]["preamble"]["x_increment"] != x_inc:
        print("### WARNING! Different time base sample interval!")
        print("             Channel:",channel,x_inc)
        print("             Channel:",ch,waveform_data[ch]["preamble"]["x_increment"])
        print("             You may want to check the 'Interploation' setting in the 'pre-Processing' tab of the oscilloscopes channel setup")
      if waveform_data[ch]["preamble"]["x_display_range"] != timebase:
        print("### WARNING! Different time base!")
        print("             Channel:",channel,timebase)
        print("             Channel:",ch,waveform_data[ch]["preamble"]["x_display_range"])

  return(points)

############################################################################

def file_to_waveform(filename):
  """
  Retrieve the waveforms from a bytestring which is normally read from file.
   
  filename -- source file from which to retrieve data.
    
  returns: <type 'dict'> waveform_data with keys to a <type 'dict'> for each channel number
           each channel number is again a <type 'dict'> with keys:
              'byte_order' : <type 'str'>
              'preamble'   : <type 'dict'>
              'waveform'   : <type 'numpy.ndarray'>
           each preamble is a <type 'dict'> with keys:
              'acquisition_mode'  : <type 'str'>
              'bandwidth_maximum' : <type 'float'>
              'bandwidth_minimum' : <type 'float'>
              'completion'        : <type 'int'>
              'count'             : <type 'int'>
              'coupling'          : <type 'str'>
              'date'              : <type 'str'>
              'format'            : <type 'str'>
              'frame_model_#'     : <type 'str'>
              'points'            : <type 'int'>
              'time'              : <type 'str'>
              'type'              : <type 'str'>
              'x_display_origin'  : <type 'float'>
              'x_display_range'   : <type 'float'>
              'x_increment'       : <type 'float'>
              'x_origin'          : <type 'float'>
              'x_reference'       : <type 'float'>
              'x_units'           : <type 'str'>
              'y_display_origin'  : <type 'float'>
              'y_display_range'   : <type 'float'>
              'y_increment'       : <type 'float'>
              'y_origin'          : <type 'float'>
              'y_reference'       : <type 'float'>
              'y_units'           : <type 'str'>

           an example waveform_data dict looks like this:
           {1: { 'byte_order': 'LSBFIRST',
                 'preamble':  {'y_display_origin': 30707.0,
                              'bandwidth_minimum': 0.0,
                              'y_units': 'Unit Name = V',
                                 :
                              'x_units': 'Unit Name = S',
                              'time': '13:50:02'},
                'waveform': '\x8e\xef\x8b\.....'
               },
            2: {'byte_order': 'LSBFIRST',
                'preamble': {'y_display_origin': 30707.0,
                             'bandwidth_minimum': 0.0,
                             'y_units': 'Unit Name = V',
                                 :
                             'x_units': 'Unit Name = S',
                             'time': '13:50:02'},
                'waveform': 'C\x90X\x90]\x90N\x90@\x90G\x90a\....'}
           }             
  """

  data_file = open(filename,"r")

  # create an empty wavefrom_data dictionairy
  waveform_data = {}

  line = data_file.readline()
  if line.strip() != "#WaveformData:Keysight DSO-S 254A":
    #print("Exception: file_to_waveform: Not a Keysight DSO-S 254A Waveform Data file.")
    Exception("file_to_waveform: Not a Keysight DSO-S 254A Waveform Data file.")
    data_file.close()
    return

  line = data_file.readline()
  version = line.strip().split(":")
  if not(version[0]=="#version" and version[1]=="0.2"):
#  if version[0]=="#version" and version[1]=="0.1":
    #print("Exception: file_to_waveform: Keysight DSO-S 254A wrong version Waveform Data file.")
    Exception("file_to_waveform: Keysight DSO-S 254A wrong version Waveform Data file.")
    data_file.close()
    return

  channels=[]
  preamble_idx = 0
  waveform_idx = 0
  while 1:
    line=data_file.readline()
    if len(line)==0:
      break
    if line[:len("#channel:")]=="#channel:":
      chan_str=line.split(":")[1].strip()
      channels=chan_str.split(',')
    if line[:len("#date:")]=="#date:":
      date_in_file=line.split(":")[1].strip()
    if line[:len("#time:")]=="#time:":
      time_lst=line.split(":")
      time_in_file=time_lst[1].strip()+":"+time_lst[2].strip()+":"+time_lst[3].strip()
    if line[:len("#byteorder:")]=="#byteorder:":
      byte_order=line.split(":")[1].strip()

    # Preambles come first in the file.
    # Create a dictionairy channel entry for each
    if line[:len("#preamble:")]=="#preamble:":
      preamble_chan = int(channels[preamble_idx])
      waveform_data[preamble_chan] = {}
      waveform_data[preamble_chan]["byte_order"] = byte_order
      preamble_string=data_file.readline()
      waveform_data[preamble_chan]["preamble"] = preamble_string_to_dict(preamble_string)
      preamble_idx += 1

    # Next comes wavefrom data.
    # Create a dictionairy channel entry for each
    if line[:len("#waveform:")]=="#waveform:":
      waveform_chan = int(channels[waveform_idx])
      # the next part of the file looks like this:
      # '#564034\xe0....'
      wf_header = data_file.read(1)           # read the waveform_header "#"
      wf_no_of_digits = int(data_file.read(1)) # read the number of digits "5"
      wf_samples = int(data_file.read(wf_no_of_digits))
      #print("chan_no",waveform_chan) 
      #print(wf_header) 
      #print(wf_no_of_digits)
      #print(wf_samples) 

      # Add the waveform to the <type 'dict'> waveform_data but first convert it the RAW
      # waveform data in the file to scipy array with x,y axis values
      waveform_data[waveform_chan]["waveform"] = raw_to_scipy_array (data_file.read(wf_samples), byte_order, waveform_data[waveform_chan]['preamble'])

      #line = data_file.readline()    # waveform_data ends with a "\n". Read it!
      waveform_idx += 1


  data_file.close()
  return waveform_data

############################################################################
def osc_init(scope, time_base = 50.0e-9):

  """
  Initialize the Oscilloscope for the timestamp edge to SFD measurement.

    scope      -- instance of python-vxi connected to the oscilloscope
    time_base  -- <float> time base, default 50 ns/div
  """

  #scope =  vxi11.Instrument("192.168.32.248")
  print(scope.ask("*IDN?"))
  # Returns 'KEYSIGHT TECHNOLOGIES,DSOS254A,MY55160101,05.50.0004'

  # Use Channel 1 pulse input
  # use Channel 3 Ethernet Frame input

  # A fixed trigger level is important for proper timing measurement
  # Choose 1.4 Volt for a direct signal but 0.8  Volt when the signal
  # is split by a power splitter
  scope.write(":TRIGger1:SOURce CHAN1")
  scope.write(":TRIGger1:EDGE:SLOPe POS")
  scope.write(":TRIGger1:MODE NORMal")  # Normal trigger

  use_power_splitter = True

  if use_power_splitter:
    scope.write(":TRIGger1:LEVEl1 0.4")
    scope.write(":CHANnel1:RANGe 5.0")     # 500 mV/div
  else:  
    scope.write(":TRIGger1:LEVEl1 0.7")
    scope.write(":CHANnel1:RANGe 7.5")     # 750 mV/div

  scope.write(":CHANnel1:COUPling DC")     # DC 50 Ohm
  scope.write(":CHANnel1:OFFSet 0.0")
  scope.write(":CHANnel1:STATe ON")

  scope.write(":CHANnel3:COUPling DC")     # DC 50 Ohm
  scope.write(":CHANnel3:OFFSet 0.0")
  scope.write(":CHANnel3:RANGe 1.25")     # 125 mV/div
  scope.write(":CHANnel3:STATe ON")
  scope.write(":CHANnel4:COUPling DC")     # DC 50 Ohm
  scope.write(":CHANnel4:OFFSet 0.0")
  scope.write(":CHANnel4:RANGe 1.25")     # 125 mV/div
  scope.write(":CHANnel4:STATe ON")

  # Trigger in the centre of the screen; important for maximum estimations
  # forwarded to function average_edge_to_sfd
  scope.write(":TIMebase:HORizontal:POSition 0")
  scope.write(":TIMebase:TRIGger:POSition 0")
  scope.write(":TIMebase:REFerence 50")
  scope.write(":TIMebase:RANGe "+str(10*time_base))  # set 50 ns/div
  scope.write(":SENSe:ROSCillator:SOURce EXTernal")    # set external refrence clock
  scope.write(":SENSe:ROSCillator:FREQuency 10E+6")    # set frequency 10 MHz

  return

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Keysight DSO-S 254A version 01')

  if len(sys.argv) >= 2:            # just IP number
    scope =  vxi11.Instrument(sys.argv[1])    
    #scope =  vxi11.Instrument("192.168.32.248")
    print(scope.ask("*IDN?"))
    # Returns 'KEYSIGHT TECHNOLOGIES,DSOS254A,MY55160101,05.50.0004'
    channels = '1'
    #record_len = 1000
    num_avg = 1

    if len(sys.argv) >= 3:                  # There are more arguments...
      for arg_value in sys.argv[2:]:
        if arg_value[:2] == '-c':           # set channels
          channels=arg_value[2:]
          #print("channels:",channels)
        #if arg_value[:2] == '-l':           # set record length
        #  record_len=int(arg_value[2:])
        #  print(record_len)
        if arg_value[:2] == '-a':           # set number of averages
          num_avg=int(arg_value[2:])
          #print(num_avg)

    #print ("channels:",channels, "record length:", record_len, "num_avg", num_avg)


    # Use Channel 1 pulse input
    # use Channel 3 Ethernet Frame input

    # A fixed trigger level (1,4 Volt) is important for proper timing measurement
    scope.write(":TRIGger:LEVel CHANnel1,1.4")
    scope.write(":CHANnel1:INPut DCFifty")

    # Trigger in the centre of the screen; important for maximum estimations
    # forwarded to function average_edge_to_sfd
    scope.write(":TIMebase:DELay 0")

    #d,filename = get_waveforms(scope, channels, record_len, num_avg)
    d,filename = get_waveforms(scope, channels, num_avg)
    wf_data = file_to_waveform(filename)

    check_waveforms(wf_data)
    plt.figure("channel:"+str(channels))
    for chan in wf_data.keys():
      x = wf_data[chan]["waveform"][0]
      y = wf_data[chan]["waveform"][1]
      plt.plot(x,y)

    plt.show()

  sys.exit()
