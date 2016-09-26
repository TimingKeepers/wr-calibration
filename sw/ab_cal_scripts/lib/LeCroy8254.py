#!/usr/bin/python

"""
LeCroy WaveRunner 8254M-MS remote control

Usage:
  LeCroy8254.py <IP#> [-c=<1,2,3,4>] [-a=<averages>]
  LeCroy8254.py -h | --help

  IP          IP number of the Oscilloscope
              (for example: 192.168.32.243 which is its DevNet IP number)

Options:
  -h --help    Show this screen.
  --version    Show version.
  -c=<1,2,3,4> channel number
  -a=<number>  number of averages [default: 1]

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

def get_waveforms(scope, channels=[1,2,3,4],num_avg=1):

  """
  Measure and save LeCroy WaveRunner 8254M-MS waveforms

  scope           -- instance of python-vxi connected to LeCroy8254 oscilloscope
  channels        -- channels that are going to be measured for example '1,2'
  num_avg         -- the number of averiges taken by the oscilloscope before 

  the file output format is as described below:

  ----------------------------------
    #WaveformData:LeCroy8254
    #version:0.1
    #type:RAW
    #channel:1,2,..
    #time:21 Jan 2016 11:03:38
    #byteorder:LSBFIRST
    #preamble:
      C1:INSP "
    #preamble:
      C2:INSP "
    #waveform_desc:
      C1:WF DESC
    #waveform_desc:
      C2:WF DESC
      :
    #waveform_data:
      C1:WF DAT1
    #waveform_data:
      C2:WF DAT1
      :
  ----------------------------------
  "preamble" data is readable ASCII
  "waveform_desc" is coded according to the LeCroy template that can be querried by
    print(scope.ask("TEMPLATE?"))
  "waveform_data" is binary data
  """

  scope.write("STOP")                #Stop any running acquisition

  scope.write("COMM_FORMAT DEF9,WORD,BIN")
    # Encoding Block format DEF9
    # Data Type WORD (16-bit)
    # Encodig BIN

  scope.write("COMM_ORDER LO")       # i.e. LSB first

  #scope.write("WAVEFORM_SETUP SP,0,NP,"+str(data_record_len)+",FP,0,SN,0")
  scope.write("WAVEFORM_SETUP SP,0,NP,0,FP,0,SN,0")  # Always use the masimum record length
    # Sparing (SP=0: send all data points)
    # Number of points (NP=0: send all data points)
    # First point (FP=0)
    # Segment Number (SN=0: all segments)

  src_str = "F"
  scope.write("TRIG_MODE STOP")

  for chan in channels.split(','):
    scope.write(src_str + str(chan)+':TRACE ON')                               # For Function or Channel
    # Attention! LeCroy can set average in Channel Tab manually but not via
    # script!? For this we need to setup a function!
    # Also note that setting up a function does not mean that we need to
    # administrate the triggers by script (see for loop below where each loop
    # one sweep is armed and taken.
    scope.write("VBS 'app.Math."+src_str + str(chan)+".View = True'")
    scope.write("VBS 'app.Math."+src_str + str(chan)+".Source1 = \"C"+str(chan)+"\"'")
    scope.write("VBS 'app.Math."+src_str + str(chan)+".Operator1 = \"Average\"'")
    scope.write("VBS 'app.Math."+src_str + str(chan)+".Operator1Setup.Sweeps = " + str(num_avg))
    scope.write("VBS 'app.Math."+src_str + str(chan)+".MathMode = \"OneOperator\"'")

  scope.write("CLEAR_SWEEPS")
  scope.write("TRIG_MODE SINGLE")

  cnt = 1
  for num in range(0,num_avg):
    scope.write("ARM;WAIT")
    while ('1' not in scope.ask("*OPC?")):
      pass
    print(cnt)
    cnt = cnt +1

  timestamp = time.localtime()

  file_header  = "#WaveformData:LeCroy8254\n"
  file_header += "#version:0.2\n"
  file_header += "#type:RAW\n"
  file_header += "#channel:"+str(channels)+"\n"
  file_header += "#date:"+time.strftime(format("%d %b %Y"),timestamp)+"\n"
  file_header += "#time:"+time.strftime(format("%H:%M:%S"),timestamp)+"\n"
  file_header += "#byteorder:LSBFIRST\n"
  channel_preamble = []
  channel_descriptor = []
  channel_data = []

  for chan in channels.split(','):
    channel_preamble.append("#preamble:\n")
    channel_preamble.append(scope.ask(src_str+str(chan)+":INSPECT? WAVEDESC")+"\n")
    channel_preamble.append("#preamble_end:\n")
    channel_descriptor.append("#waveform_desc:\n")
    channel_descriptor.append(scope.ask_raw(src_str+str(chan)+":WAVEFORM? DESC"))
    channel_data.append("#waveform_data:\n")
    channel_data.append(scope.ask_raw(src_str+str(chan)+":WAVEFORM? DAT1"))

  # Write out file_header, followed by all preambles, followed by all channel_data
  data = [file_header]
  for i in range(len(channel_preamble)):
    data.append(channel_preamble[i])
  for i in range(len(channel_descriptor)):
    data.append(channel_descriptor[i])
  for i in range(len(channel_data)):
    data.append(channel_data[i])

  filename="data/"+time.strftime(format("%y%m%d_%H_%M_%S"),timestamp)+"_LeCroy8254_bin"
  print("save LeCroy8254 Waveform into file:",filename)

  file=open(filename,"w")
  for i in data:
    file.write(i)
  file.close()
  return data, filename

############################################################################

def get_preamble_from_file(data_file, date_in_file, time_in_file):

  """
  This function takes a file pointer to the data file and reads a "LeCroy"
  preamble portion of the file. While the data is being read, it is interpreded
  and put into a format that is used in Tjeerd Pinkerts correlation classes.
  The latter format is inspired on Agilent DSO type oscilloscopes.
  
  Preamble data can be asked from the LeCroy oscilloscope by for example:
    print(scope.ask("C1:INSPECT? WAVEDESC"))
  It outputs a string like this:
    C1:INSP "
    DESCRIPTOR_NAME    : WAVEDESC           
    TEMPLATE_NAME      : LECROY_2_3         
    COMM_TYPE          : word               
    COMM_ORDER         : LOFIRST            
    WAVE_DESCRIPTOR    : 346                
    USER_TEXT          : 0                  
    RES_DESC1          : 0                  
    TRIGTIME_ARRAY     : 0                  
    RIS_TIME_ARRAY     : 0                  
    RES_ARRAY1         : 0                  
    WAVE_ARRAY_1       : 100                
    WAVE_ARRAY_2       : 0                  
    RES_ARRAY2         : 0                  
    RES_ARRAY3         : 0                  
    INSTRUMENT_NAME    : LECROYWR625Zi      
    INSTRUMENT_NUMBER  : 57790              
    TRACE_LABEL        :                    
    RESERVED1          : 10002              
    RESERVED2          : 0                  
    WAVE_ARRAY_COUNT   : 50                 
    PNTS_PER_SCREEN    : 10000              
    FIRST_VALID_PNT    : 0                  
    LAST_VALID_PNT     : 10001              
    FIRST_POINT        : 0                  
    SPARSING_FACTOR    : 1                  
    SEGMENT_INDEX      : 0                  
    SUBARRAY_COUNT     : 1                  
    SWEEPS_PER_ACQ     : 1                  
    POINTS_PER_PAIR    : 0                  
    PAIR_OFFSET        : 0                  
    VERTICAL_GAIN      : 6.4862e-005        
    VERTICAL_OFFSET    : -9.9500e-001       
    MAX_VALUE          : 3.0579e+004        
    MIN_VALUE          : -3.0835e+004       
    NOMINAL_BITS       : 8                  
    NOM_SUBARRAY_COUNT : 1                  
    HORIZ_INTERVAL     : 5.0000e-011        
    HORIZ_OFFSET       : -2.50016176e-007   
    PIXEL_OFFSET       : -2.50000000e-007   
    VERTUNIT           : Unit Name = V
    HORUNIT            : Unit Name = S
    HORIZ_UNCERTAINTY  : 1.0000e-012        
    TRIGGER_TIME       : Date = JAN 22, 2016, Time = 10: 3:44.616851309
    ACQ_DURATION       : 0.0000e+000        
    RECORD_TYPE        : single_sweep       
    PROCESSING_DONE    : no_processing      
    RESERVED5          : 0                  
    RIS_SWEEPS         : 1                  
    TIMEBASE           : 50_ns/div          
    VERT_COUPLING      : ground             
    PROBE_ATT          : 1.0000e+000        
    FIXED_VERT_GAIN    : 500_mV/div         
    BANDWIDTH_LIMIT    : off                
    VERTICAL_VERNIER   : 1.0000e+000        
    ACQ_VERT_OFFSET    : -9.9500e-001       
    WAVE_SOURCE        : CHANNEL_1          
    "
  
  This LeCroy string needs to be interpreted and converted to a preamble dict:
    preamble["format"]=             2,
    preamble["type"]=               1,
    preamble["points"]=             2050000,
    preamble["count"]=              1,
    preamble["x_increment"]=        2.5000000E-11,
    preamble["x_origin"]=          -2.5624966255289E-05,
    preamble["x_reference"]=        0,
    preamble["y_increment"]=        1.31732E-05,
    preamble["y_origin"]=           1.16459E-02,
    preamble["y_reference"]=        0,
    preamble["coupling"]=           2,
    preamble["x_display_range"]=    1.00000E-07,
    preamble["x_display_origin"]=   -5.0000000000E-08,
    preamble["y_display_range"]=    8.00000E-01,
    preamble["y_display_origin"]=   0.0E+00,
    preamble["date"]=               "17 DEC 2014",
    preamble["time"]=               "18:45:43:65",
    preamble["frame_model_#"]=      "DSO80804B:MY46001
    preamble["acquisition_mode"]=
    preamble["completion"]=
    preamble["x_units"]=
    preamble["y_units"]=
    preamble["bandwidth_maximum"] =
    preamble["bandwidth_minimum"] =
  
  """

  # LeCroy outputs Time/Div.
  # This dict enables conversion to float
  _timebase = {
    "1_ps/div"   : 1.00000E-12, 
    "2_ps/div"   : 2.00000E-12,
    "5_ps/div"   : 5.00000E-12,
    "10_ps/div"  : 1.00000E-11,
    "20_ps/div"  : 2.00000E-11,
    "50_ps/div"  : 5.00000E-11,
    "100_ps/div" : 1.00000E-10,
    "200_ps/div" : 2.00000E-10,
    "500_ps/div" : 5.00000E-10,
    "1_ns/div"   : 1.00000E-09,
    "2_ns/div"   : 2.00000E-09,
    "5_ns/div"   : 5.00000E-09,
    "10_ns/div"  : 1.00000E-08,
    "20_ns/div"  : 2.00000E-08,
    "50_ns/div"  : 5.00000E-08,
    "100_ns/div" : 1.00000E-07,
    "200_ns/div" : 2.00000E-07,
    "500_ns/div" : 5.00000E-07,
    "1_us/div"   : 1.00000E-06,
    "2_us/div"   : 1.00000E-06,
    "5_us/div"   : 2.00000E-06,
    "10_us/div"  : 5.00000E-05,
    "20_us/div"  : 1.00000E-05,
    "50_us/div"  : 2.00000E-05,
    "100_us/div" : 5.00000E-04,
    "200_us/div" : 1.00000E-04,
    "500_us/div" : 2.00000E-04,
    "1_ms/div"   : 5.00000E-03,
    "2_ms/div"   : 1.00000E-03,
    "5_ms/div"   : 2.00000E-03,
    "10_ms/div"  : 5.00000E-02,
    "20_ms/div"  : 1.00000E-02,
    "50_ms/div"  : 2.00000E-02,
    "100_ms/div" : 5.00000E-01,
    "200_ms/div" : 1.00000E-01,
    "500_ms/div" : 2.00000E-01,
    "1_s/div"    : 5.00000E+00,
    "2_s/div"    : 1.00000E+00,
    "5_s/div"    : 2.00000E+00,
    "10_s/div"   : 5.00000E+01,
    "20_s/div"   : 1.00000E+01,
    "50_s/div"   : 2.00000E+01,
    "100_s/div"  : 5.00000E+02,
    "200_s/div"  : 1.00000E+02,
    "500_s/div"  : 2.00000E+02,
    "1_ks/div"   : 5.00000E+03,
    "2_ks/div"   : 1.00000E+03,
    "5_ks/div"   : 2.00000E+03,
    "EXTERNAL"   : 0.00000E+00,
  }

  # prepare _preamble as type dict
  _preamble={}
  
  # LeCroy gives MAX and MIN grid values that need to be recalculated to
  # "y_display_range"  = y_max_grid - y_min_grid            and
  # "y_display_origin" = (y_max_grid - y_min_grid) / 2
  # Calculation can only take place when both are found in the file
  y_max_grid_found = False
  y_min_grid_found = False

  while 1:
    line=data_file.readline()
    if len(line) == 0:
      Exception("get_preamble_from_file: premature end of file.")
      break
    if line.strip() == "#preamble_end:":
      break

    line_lst = line.split(":")
    #print("ll:",line_lst)
   
    if line_lst[0].strip() == "COMM_TYPE":       # Either: "BYTE", "WORD"
      _preamble["format"] = line_lst[1].strip().upper()

    _preamble["type"]="RAW"

    if line_lst[0].strip() == "WAVE_ARRAY_COUNT":
      _preamble["points"] = int(line_lst[1])

    if line_lst[0].strip() == "SWEEPS_PER_ACQ":
      _preamble["count"]  = int(line_lst[1])

    if line_lst[0].strip() == "HORIZ_INTERVAL":
      _preamble["x_increment"] = float(line_lst[1])

    if line_lst[0].strip() == "HORIZ_OFFSET":    # Don't know which one to choose
    #if line_lst[0].strip() == "PIXEL_OFFSET":
      _preamble["x_origin"] = float(line_lst[1])

    if line_lst[0].strip() == "FIRST_POINT":
      _preamble["x_reference"] = float(line_lst[1])

    if line_lst[0].strip() == "VERTICAL_GAIN":
      _preamble["y_increment"] = float(line_lst[1])

    if line_lst[0].strip() == "VERTICAL_OFFSET":
      _preamble["y_origin"] = float(line_lst[1])
  
    #if line_lst[0].strip() == "VERTICAL_VERNIER":
    #  _preamble["y_reference"]=float(line_lst[1])
    _preamble["y_reference"]=float(0)            # Not sure which LeCroy parameter to take...

    if line_lst[0].strip() == "VERT_COUPLING":   # Either:"AC_1MOhm", "DC_1MOhm", "DC_50_Ohms", "ground"
      _preamble["coupling"] = line_lst[1].strip()
  
    if line_lst[0].strip() == "PIXEL_OFFSET":
      _preamble["x_display_origin"] = float(line_lst[1])

    if line_lst[0].strip() == "TIMEBASE":
      _preamble["x_display_range"]=float(10 * float(_timebase[line_lst[1].strip()]))

    if line_lst[0].strip() == "MAX_VALUE":
      y_max_grid = float(line_lst[1])
      y_max_grid_found = True
      if y_min_grid_found:
        _preamble["y_display_range"] = y_max_grid - y_min_grid
        _preamble["y_display_origin"] = (y_max_grid - y_min_grid) / 2
 
    if line_lst[0].strip() == "MIN_VALUE":
      y_min_grid = float(line_lst[1])
      y_min_grid_found = True
      if y_max_grid_found:
        _preamble["y_display_range"] = y_max_grid - y_min_grid
        _preamble["y_display_origin"] = (y_max_grid - y_min_grid) / 2
      
    _preamble["date"]=str(date_in_file)
    _preamble["time"]=str(time_in_file)

    if line_lst[0].strip() == "INSTRUMENT_NAME":
      _preamble["frame_model_#"]=line_lst[1].strip()

    if line_lst[0].strip() == "RECORD_TYPE":
      _preamble["acquisition_mode"]=line_lst[1].strip()

    _preamble["completion"]=int(0)          # assumed not to be used

    if line_lst[0].strip() == "HORUNIT":
      _preamble["x_units"]=line_lst[1].strip()

    if line_lst[0].strip() == "VERTUNIT":
      _preamble["y_units"]=line_lst[1].strip()

    _preamble["bandwidth_maximum"]=float(0)  # assumed not to be used
    _preamble["bandwidth_minimum"]=float(0)  # assumed not to be used

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
      dtype=scipy.float64) * preamble["y_increment"] - preamble["y_origin"]
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
      print("Info: Record Legth is", points,"sampels")
      count    = waveform_data[ch]["preamble"]["count"]
      x_inc    = waveform_data[ch]["preamble"]["x_increment"]
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
  if line.strip() != "#WaveformData:LeCroy8254":
    #print("Exception: file_to_waveform: Not a LeCroy8254 Waveform Data file.")
    Exception("file_to_waveform: Not a LeCroy8254 Waveform Data file.")
    data_file.close()
    return

  line = data_file.readline()
  version = line.strip().split(":")
  if not(version[0]=="#version" and version[1]=="0.2"):
#  if version[0]=="#version" and version[1]=="0.1":
    #print("Exception: file_to_waveform: LeCroy8254 wrong version Waveform Data file.")
    Exception("file_to_waveform: LeCroy8254 wrong version Waveform Data file.")
    data_file.close()
    return

  while 1:
    line=data_file.readline()
    if len(line)==0:
      break
    if line[:len("#date:")]=="#date:":
      date_in_file=line.split(":")[1].strip()
    if line[:len("#time:")]=="#time:":
      time_lst=line.split(":")
      time_in_file=time_lst[1].strip()+":"+time_lst[2].strip()+":"+time_lst[3].strip()
    if line[:len("#byteorder:")]=="#byteorder:":
      byte_order=line.split(":")[1].strip()
    if line[:len("#preamble:")]=="#preamble:":
      line=data_file.readline()    # read something like "C1:INSP "
      chan_no = int(line[1])       # channel number is the second character
      # Preambles come first in the file.
      # Create a dictionairy channel entry for each
      waveform_data[chan_no] = {}
      waveform_data[chan_no]["byte_order"] = byte_order
      waveform_data[chan_no]["preamble"] = \
        preamble = get_preamble_from_file(data_file, date_in_file, time_in_file)
    if line[:len("#waveform_data:")]=="#waveform_data:":
      # the next part of the file looks like this:
      # C1:WF DAT1,#9000000100e\8E....
      wf_header = data_file.read(12)           # read the waveform_header "C1:WF DAT1,#"
      chan_no = int(wf_header[1])
      wf_no_of_digits = int(data_file.read(1)) # read the number of digits "9"
      wf_samples = int(data_file.read(wf_no_of_digits))
      #print("chan_no",chan_no) 
      #print(wf_header) 
      #print(wf_no_of_digits)
      #print(wf_samples) 

      # Add the waveform to the <type 'dict'> waveform_data but first convert it the RAW
      # waveform data in the file to scipy array with x,y axis values
      waveform_data[chan_no]["waveform"] = raw_to_scipy_array (data_file.read(wf_samples), byte_order, waveform_data[chan_no]['preamble'])

      line = data_file.readline()    # waveform_data ends with a "\n". Read it!

  data_file.close()
  return waveform_data

############################################################################
def osc_init(scope, time_base = 50.0e-9):

  """
  Initialize the Oscilloscope for the timestamp edge to SFD measurement.

    scope      -- instance of python-vxi connected to the oscilloscope
    time_base  -- <float> time base, default 50 ns/div
  """

  #scope =  vxi11.Instrument("192.168.32.243")
  print(scope.ask("*IDN?"))
  # Returns '*IDN LECROY,HDO4034-MS,LCRY-HDO,7.9.0'

  # Use Channel 1 pulse input
  # use Channel 3 Ethernet Frame input

  # A fixed trigger level is important for proper timing measurement
  # Choose 1.4 Volt for a direct signal but 0.8  Volt when the signal
  # is split by a power splitter
  scope.write("TRIG_SELECT EDGE,SR,C1")

  use_power_splitter = True

  if use_power_splitter:
    scope.write("C1:TRIG_LEVEL 0.4")
    scope.write("C1:Volt_DIV 0.5")
  else:  
    scope.write("C1:TRIG_LEVEL 0.7")
    scope.write("C1:Volt_DIV 0.75")

  scope.write("C1:COUPLING D50")
  scope.write("C1:OFFSET 0.0")

  scope.write("C3:COUPLING D50")
  scope.write("C3:OFFSET 0.0")
  scope.write("C3:Volt_DIV 0.125")
  scope.write("C4:COUPLING D50")
  scope.write("C4:OFFSET 0.0")
  scope.write("C4:Volt_DIV 0.125")


  # Trigger in the centre of the screen; important for maximum estimations
  # forwarded to function average_edge_to_sfd
  scope.write("TRIG_DELAY 0 ns")
  scope.write("TIME_DIV "+str(time_base))  # set 50 ns/div
  #scope.write("REFERENCE_CLOCK EXTERNAL")  # set external refrence clock

  return

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='LeCroy WaveRunner 8254M-MS version 01')

  if len(sys.argv) >= 2:            # just IP number
    scope =  vxi11.Instrument(sys.argv[1])    
    #scope =  vxi11.Instrument("192.168.32.243")
    print(scope.ask("*IDN?"))
    # Returns '*IDN LECROY,HDO4034-MS,LCRY-HDO,7.9.0'
    channels = '1'
    #record_len = 1000
    num_avg = 1

    if len(sys.argv) >= 3:                  # There are more arguments...
      for i in range(1,len(sys.argv)):
        option = sys.argv[i].split('=')
        if option[0] == '-c':           # set channels
          channels=option[1]
          #print("channels:",channels)
        #if arg_value[:2] == '-l':           # set record length
        #  record_len=int(arg_value[2:])
        #  print(record_len)
        if option[0] == '-a':           # set number of averages
          num_avg=int(option[1])

    #print ("channels:",channels, "num_avg", num_avg)
    
    # Use Channel 1 pulse input
    # use Channel 3 Ethernet Frame input

    # A fixed trigger level (1,4 Volt) is important for proper timing measurement
    scope.write("C1:TRIG_LEVEL 0.1")
    scope.write("C1:COUPLING DC50")

    # Trigger in the centre of the screen; important for maximum estimations
    # forwarded to function average_edge_to_sfd
    scope.write("TRIG_DELAY 0")

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
