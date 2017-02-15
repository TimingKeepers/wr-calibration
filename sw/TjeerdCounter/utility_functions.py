# -*- coding: utf-8 -*-

"""Collection of functions that can be handy to have at hand, especially some
   more general optical stuff like "read file" and "full width half maximum"
   functions that are to difficult to quickly type out but used often enough to
   be worth typing out once.
"""

import math
#import pylab
import scipy
import scipy.fftpack
import scipy.optimize
import scipy.signal
import scipy.stats
import scipy.special
import time
import csv
import datetime
import os
import sys
import unit_conversion as uc
import decimal

# float128 check (float128 does usually not exist in 32 bit environments.)
try:
    if scipy.float128:
        pass
except:
    print 'utiltity_functions: float128 does not exist. using float96'
    scipy.float128=scipy.float96

# user long floats... (96 or 128 bit)
float=scipy.longfloat

DEBUG=False


##
## File reading and writing.
##
def read_comments(filename, comment_string="#", comment_stop=None, read_all=False):
    """
    Read comments from the start of the file, stop reading at first non-comment
    line. For now we implement only reading from full comment lines, but in the
    future we could implement reading e.g. C or Python style inline comments
    too.
    
    file_name -- name of the file to read comments from
    comment_start -- string that indicates the start of a comment (default: #)
    comment_stop -- string that indicates the end of a comment (default: None)
    read_all -- read complete file for more comments (default: False)
    
    returns: array with comments
    """
    read_lines=True
    comments=[]
    
    file=open(filename, "r")
    
    while read_lines:
        line=file.readline()
        if line.find(comment_string) == 0:
            comments.append(line)
        else:
            read_lines=False

    return comments

def read_file(filename, separator=None, datatypes=None, converters=None, assume_multiple=True, new_lines=2):
    """Read the data from file <filename>. Data is returned as an array of
    comment lines and a python array of data lines.
   
    separator: If no column separator is given we asume <TAB> is the separator.
    datatypes: If no datatypes array is given we asume float128
    converters: Conversion functions to call on imported data, e.g. timestamp to seconds
    assume_multiple: Multiple datasets in a file are separated by a (double)
        empty line. We asume there are always multiple datasets but this
        behaviour can be overridden. If there is only one dataset and
        asume_multiple=False, the "extra" array will be stripped.
    new_lines: the number of empty lines separating datasets (default 2 for
        backward compatibility)
    
    returns: data, comments
    """
    
    file=open(filename,"r")
    
    if separator==None:
        separator="\t"
    
    #TODO: implement datatypes array in the reading routine...
    if datatypes==None:
        datatypes=scipy.float128
    else:
        pass
    
    if convertors==None:
        conversion=False
    else:
        conversion=True
    
    # data containers
    data = []
    dataset = []
    comments = []
    
    newlinecount=0
    
    for line in file:
        if line[0]=='#':
            comments.append(line.strip("# \r\n").split(separator))
        else:
            dataline=line.strip().split(separator)
            if not dataline == ['']:
                if conversion:
                    for i in range(len(dataline)):
                        if not convertors[i]==None:
                            dataline[i]=convertors[i](dataline[i])
                dataset.append(scipy.array(dataline).astype(datatypes))
            else:
                newlinecount+=1
                if newlinecount >= new_lines:
                    if dataset and len(dataset)>0:
                        data.append(scipy.array(dataset))
                    dataset=[]
                    newlinecount=0
    
    file.close()
    
    if dataset and len(dataset)>0:
        data.append(scipy.array(dataset))
    
    if len(data) == 1 and assume_multiple:
        data=data[0]

    return data, comments

def write_file(name, data, separator=None, data_types=None, convertors=None, multiple_sets=False, new_lines=2, comments=None):
    """Write data to file by a plain str() cast of the datatypes in the data
    array. The data array can be a plain array or a scipy array.
    
    name: file name to write to
    data: 1D or 2D array of data to write to file. for a 2 dimensional array
        we write out the fields of the 2nd dimension separated by separator.
    separator: column separator, default three whitespaces.
    datatypes: Array with datatype for each output column. If no datatypes array
        is given we asume float128
    convertors: Conversion functions to call on exported data, e.g. timestamp
        to seconds.
    multiple_sets: Multiple datasets in data are to be separated by a (double)
        empty line.
    new_lines: the number of empty lines separating datasets (default 2 for
        backward compatibility)
    comments: 1D or 2D array of comment lines, these are prepended by #

    #TODO: implement data_types, convertors, assume_multiple and new_lines functionality

    """
    DEBUG=False
    
    if separator==None:
        separator="   "
    
    of=open(name, "w")
    
    if comments:
        for item in comments:
            if type(item) == list:
                out_line="#"
                for field in item:
                    out_line+=(str(field)+separator)
                out_line=out_line.strip()
                of.write(out_line+"\n")
            else:
                of.write("#"+str(item)+"\n")

    if multiple_sets:
        if DEBUG:
            print "multiple sets assumed"

        for item in data:
            item=scipy.array(item)
            #We have a 1D array
            if len(item.shape)==1 and item.shape[0]>1:
                for datum in item:
                    of.write(str(datum)+"\n")
                #write set separator
                for i in range(new_lines):
                    of.write("\n")

            #We have a 2D array
            elif len(item.shape)==2:
                for line in item:
                    out_line=""
                    for datum in line:
                        out_line+=(str(datum)+separator)
                    of.write(out_line+"\n")
                #write set separator
                for i in range(new_lines):
                    of.write("\n")

            #We have a single data point
            else:
                of.write(str(item)+"\n")
    #We have a 1D or 2D array with a single set
    else:
        if DEBUG:
            print "single set assumed"

        for item in data:
            #We have a 2D array
            if hasattr(item, "__iter__"):
                out_line=""
                for datum in item:
                    out_line+=(str(datum)+separator)
                of.write(out_line+"\n")
            #We have a single data point
            else:
                of.write(str(item)+"\n")

    of.close()

def write_arrays_to_file(name, arrays, column_names=None, separator="   ", comment=None, sizecheck=False, digits=15):
    """takes an array of 1 dimensional arrays, or a 2 dimensional numpy array
       and writes the contents to a file with filename.
       
       filename: string with a file name
       arrays: array with 1D arrays or a 2D array
       column_names: array with column names to put into the comment section of
           the file. Default is to omit column names.
       separator: column separator, default three whitespaces
       comment: optional comment string, newline as \n
       digits: number of digits of accuracy for the numbers to write out.
           (currently not implemented)
       
       we can enable a check if all arrays in the array have the same length
       (TODO: implement this "feature")
    """
    #TODO: implement size check
    #    raise("array's not of equal length in 'write_array_pair_to_file'")

    columns=len(arrays)
    rows=0
    for i in range(columns):
        if len(arrays[i]) > rows:
            rows=len(arrays[i])
    
    fp = open(name, "w")
    if comment:
        fp.write("# "+comment.replace("\n","\n# ")+"\n#\n")
    if column_names:
        fp.write("#")
        for name in column_names:
            fp.write(name+separator)
        fp.write("\n")

    for i in range(rows):
        for j in range(columns):
            if i <= len(arrays[j]):
		string=".%ie"%(digits)
                fp.write(("%"+string)%(arrays[j][i])+separator)
            else:
                fp.write("   ")
        fp.write("\n")
    fp.close()

def create_date_directory():
    """Create a directory in the working directory with date_number where number
    is the next in order for a certain date, numbers start at 01.
    
    returns: absolute path name
    """
    count=1
    dirname=os.path.abspath("%s_%02i"%(datetime.datetime.strftime(datetime.datetime.utcnow().date(), "%y%m%d"), count))
    while os.path.exists(dirname):
        count+=1
        dirname=os.path.abspath("%s_%02i"%(datetime.datetime.strftime(datetime.datetime.utcnow().date(), "%y%m%d"), count))

    os.mkdir(dirname)
    
    return dirname

def string_in_list(string, string_list, position=0):
    """If date_name string is a substring starting at position in list return
    True, otherwise False
    
    string: string to be found in list of strings (e.g. filenames in a directory)
    string_list: list of strings
    position: position at which string should first occur
    
    returns: True or False
    """
    return_value=False
    
    for the_string in string_list:
        if the_string.find(string)==position:
            return_value=True
            
    return return_value

def create_date_name(directory=None, previous_number=None, previous_base_name=None, base_name_suffix=""):
    """Create a base filename for the current directory with date_number where
    number is the next in order for a certain date, numbers start at 01.
    
    directory: path is which to look for already existing files
    previous_number: if given, we take this +1 for the number, if the file
        exists we increment from here
    previous_base_name: if given, split it in a date and number, number on from
        the number defined
    base_name_suffix: if given, determine the next file name with this suffix
    
    NOTE: if both previous_number and previous_base_name are defined we take the
        highest count number of both
    
    returns: date file name
    """
    if previous_number and previous_base_name:
        count=max(previous_number+1, int(previous_base_name.split("_")[1])+1)
    elif previous_number:
        count=previous_number+1
    elif previous_base_name:
        count=int(previous_base_name.split("_")[1])+1
    else:
        count=1

    if not directory:
        directory="."

    base_file_name="%s_%02i"%(datetime.datetime.strftime(datetime.datetime.utcnow().date(), "%y%m%d"), count)+str(base_name_suffix)
    files=os.listdir(directory)

    while string_in_list(base_file_name, files):
        count+=1
        base_file_name="%s_%02i"%(datetime.datetime.strftime(datetime.datetime.utcnow().date(), "%y%m%d"), count)+str(base_name_suffix)

    return base_file_name

def read_tekscope_file(file_name, max_length=None):
    """Read in the cvs file format from the tektronix.
    
    returns: signal, properties
        where signal is an array with [time, voltage] pairs and properties
        is an array with ["Property", value, unit] triples
    """
    line_count=1
    
    signal=[]
    properties=[]

    fp=csv.reader(open(file_name, "rb"))
    for line in fp:
        if not line[0]=="":
            properties.append([line[0],line[1],line[2]])
        signal.append([float(line[3]),float(line[4])])
        line_count+=1
        if max_length < line_count and not max_length==None:
            break
    del fp
    return scipy.array(signal), scipy.array(properties)

def write_signal_to_file(file_name, axis, signal, comment=None):
    """Write a gnuplot readable file with "axis_value   signal_value" pairs.
    array indices for axis and signal correspond to each other...
    
    file_name: relative or absolute file name.
    axis: array with axis values
    signal: array with signal values
    comment: string (including linebreaks) with comment, including a line with
        column names for the values
    """
    of=open(file_name, "w")
    if comment:
        comment=comment.split("\n")
        for line in comment:
            of.write("#"+line+"\n")

    for i in range(len(signal)):
        of.write(str(axis[i])+"   "+str(signal[i])+"\n")
    
    of.close()

def write_config(file_name, configuration, path=None, mode="w"):
    """Write a program configuration to file.
    
    file_name: file_name of the configuration file
    configuration: a dictionary of which the keys and values will be converted
        to strings when written to file.
    path: a pathname to write the configuration file to.
    mode: mode to open the file in for writing (default=overwrite existing)
    """
    fd=open(path+"/"+file_name, mode)
    fd.write("#Configuration\n#\n")
    for key in scipy.sort(configuration.keys()):
        fd.write("%s=%s\n"%(str(key),str(configuration[key])))
    fd.close()

##
## Time delay estimation (e.g. to capture every n seconds something...)
##
def delay_until(date_time):
    """
    Try to estimate the time until we reach datetime, sleep if this time is
    positive.
    """
    time_stamp=datetime.datetime.utcnow()
    sleep_time=date_time-time_stamp
#    print "sleep: ",sleep_time.total_seconds(),"seconds"
    time.sleep(sleep_time.total_seconds())

def delay_until_next(hour=None, minute=None, second=None, microsecond=None):
    """
    Delay until the next complete...
    """
    next_time=time_at_next(hour, minute, second, microsecond)
    time_stamp=datetime.datetime.utcnow()

#    sleep_time=next_time-time_stamp
#    print "sleep: ",sleep_time.total_seconds(),"seconds"
#    time.sleep(sleep_time.total_seconds())
    
    time.sleep((next_time-time_stamp).total_seconds())

def time_at_next(hour=None, minute=None, second=None, microsecond=None):
    """
    Calculate the time at next divisible of hour, minute, second or microsecond
    this rendering can become weird if multiple of the above are specified. Note
    alse that this rendering in microseconds depends on the execution speed of
    the script...
    
    hour -- 1 to 24
    minute -- 1 to 59
    second -- 1 to 60
    microsecond -- 1 to 1 000 000
    
    returns: datetime object.
    """
    time_stamp=datetime.datetime.utcnow()
    ts_day=time_stamp.day
    ts_hour=time_stamp.hour
    ts_minute=time_stamp.minute
    ts_second=time_stamp.second
    ts_microsecond=time_stamp.microsecond

    days_add=0
    hours_add=0
    minutes_add=0
    seconds_add=0
    microseconds_add=0

    if hour:
        while ts_hour%hour or hour_add==0:
            if ts_hour < 23:
                ts_hour+=1
                hours_add+=1
            else:
                ts_hour=0
                hours_add+=1
        time_stamp=time_stamp.replace(minute=0, second=0, microsecond=0)
    elif minute:
        while ts_minute%minute or minute_add==0:
            if ts_minute < 59:
                ts_minute+=1
                minutes_add+=1
            else:
                ts_minute=0
                minutes_add+=1
        time_stamp=time_stamp.replace(second=0, microsecond=0)
    elif second:
        while ts_second%second or seconds_add==0:
            if ts_second < 59:
                ts_second+=1
                seconds_add+=1
            else:
                ts_second=0
                seconds_add+=1
        time_stamp=time_stamp.replace(microsecond=0)
    elif microsecond:
        while ts_microsecond%microsecond:
            if ts_microsecond < 1000000:
                ts_microsecond+=1
                microseconds_add+=1
            else:
                ts_microsecond=0
                microseconds_add+=1

    return time_stamp+datetime.timedelta(days=days_add, hours=hours_add, minutes=minutes_add, seconds=seconds_add, microseconds=microseconds_add)

##
## Bit/byte fuctions
##
def reverse_word(word, bytes=1):
    """MSB to LSB first conversion for value. We asume a value of bytes length.
       The most simple appraoch here is to apply a mask, convert value to a
       string, add leading zero's, reverse the string and convert back to a
       value.
       
       word: word to reverse
       bytes: number of bytes of the word
       
       returns: integer value of the reversed word
    """
    word&=(2**(bytes*8)-1)
    string=bin(word).lstrip("0b")
    string_length=len(string)

    #prepend leading zeros
    if string_length < bytes*8:
        string="0"*(bytes*8-string_length)+string

    #reverse the string, prepend 0b, convert back to integer
    return_value=int("0b"+string[::-1],2)
    
    return return_value

def value_to_byte(value, byte_index=0):
    """Convert an arbitrary length integer value to a byte value. This is
       done by taking the value and apply a bitmask for the lowest 8 bytes
       (bitmask=255)
    
       value: integer value
       byte_index: integer adressing bytes from 0=lsb up. We shift value by
           byte_index*8 number of times to the right before we apply the
           bitmask (bitmask=255)
    
       return: byte value
    """
    return_value=None
    
    if not ( type(value)==int or type(value)==long ):
        raise TypeError("value_to_byte: value type should be int or long")
    
    if byte_index > -1:
        return_value=value>>byte_index*8&255
    else:
        raise ValueError("value_to_byte: byte_index should be 0 or a positive number")

    return return_value

def int_to_byte_string(integer, string_length=1):
    """Convert an integer value to a string of byte values. If the integer is
    larger than the amount an integer of string_length (in bytes) can take, we
    clamp to the highest value, if lower than 0, we clamp to 0.
    
    integer: unsigned integer
    string_length: length of the byte string to generate
    """
    max_value=2**(8*int(string_length))
    if not integer < max_value:
        integer=max_value-1
    if integer < 0:
        integer=0

    integer_bytes=[]
    for i in range(string_length):
        integer_bytes.append(int(integer)>>8*i&255)
    
    return_value=""
    while len(integer_bytes):
        return_value+=struct.pack("B",integer_bytes.pop())
        
    return return_value

def byte_string_to_int(byte_string):
    """Convert an integer value to a string of byte values. If the integer is
    larger than the amount an integer of string_length (in bytes) can take, we
    clamp to the highest value.
    
    integer
    """
    string_length=len(str(byte_string))

    return_value=0
    for i in range(string_length):
        return_value+=struct.unpack("B",byte_string[i])[0]<<8*(string_length-i-1)
    
    return return_value

def bytes_to_bit_string(bytes):
    """Convert a byte or an array with byte values to an array of bit values
       (0,1).
       
       bytes: byte value, or array with byte values
       
       returns: array with bit values
    """
    return_value=None

    if type(bytes)==int:
        return_value=[]
        for i in range(8):
            return_value.append(bytes>>(7-i)&1)
    elif type(bytes)==list:
        return_value=[]
        for byte in bytes:
            for i in range(8):
                return_value.append(byte>>(7-i)&1)            
    else:
        raise TypeError("bytes should be of type int or list")

    return return_value

def bit_string_to_bytes(bit_string):
    """Convert an array of bit values to a(n array of) byte value(s).
       We start from position 0 in the string and treat the next positions as
       value of the consecutive bit in the first byte. If we read 8 bits, we
       start a new byte.
    
       bit_string: array of bit values
       
       returns: (array of) byte value(s)
    """
    return_value=None
    
    if not type(bit_string) == list:
        raise TypeError("bit_string should be of type list")
    
    byte_string=[]
    bit_count=0
    for bit in bit_string:
        if bit_count%8 == 0:
            byte_string.append(0)
        byte_string[bit_count/8]+=(bit&1)<<(bit_count%8)
        bit_count+=1

    if len(byte_string) > 1:
        return_value=byte_string
    else:
        return_value=byte_string[0]

    return return_value


##
## Date and time conversion from string to unix timestamp and datetime objects
##
def utc_to_datetime(utc_string):
    """convert the output from str(datetime) back to a datetime object.
    NOTE: we do not take into account the UTC offset to local time!
    
    utc_string: "YYYY-MM-DD HH:MM:SS.m"
    
    returns: datetime object
    """
    utc_string_split=utc_string.rsplit(".")
    
    #we might have an iso 8600 time string...
    if utc_string.count("T"):
        separator="T"
    else:
        separator=" "
    
    if len(utc_string_split)>1:
        return_value=datetime.datetime.strptime(utc_string, "%Y-%m-%d"+separator+"%H:%M:%S.%f")
    else: 
        return_value=datetime.datetime.strptime(utc_string, "%Y-%m-%d"+separator+"%H:%M:%S")
    
    return return_value

def utc_to_unix_timestamp(utc_string):
    """convert the utc_string to a unix timestamp, can be usefull for some
    plotting programs like gnuplot...
    NOTE: we do not take into account the UTC offset to local time!

    utc_string: "YYYY-MM-DD HH:MM:SS.m"
        
    returns: unix_timestamp in seconds from the UNIX epoch
    """
    dt=utc_to_datetime(utc_string)
    unix_timestamp=time.mktime(dt.timetuple())+dt.microsecond*1e-6
    
    return unix_timestamp

def fix_utc_string(utc_string):
    """Fix the following typical errors in time strings generated by some
    software:
    - missing .000000 subsecond (str(datetime) can yield this)
    - missing 0's in subsecond (KVI groningen format has this)

    return: fixed utc string
    """
    #Just in case the .000000 are missing, I have not seen these in the
    #Groningen data yet
    if not "." in utc_string:
        utc_string+=".000000"

    utc_parts=utc_string.split(".")
    new_subseconds_part=""
    for char in utc_parts[1]:
        if char==" ":
            new_subseconds_part+="0"
        else:
            new_subseconds_part+=char
	utc_parts[1]=new_subseconds_part
	utc_string=".".join(utc_parts)

    return utc_string

##
## General utility functions
##
def normalise(signal, normalisation="peak"):
    """Normalise a signal.
    
    signal: array with data to normalise
    normalisation:
        peak: normalise with respect to the maximum value of the signal (default)
        rms: normalise with respect to the rms (std) value of the signal
        abs_max: normalise with respect to the maximum of the |abs| of the signal
        abs_rms: normalise with respect to the rms (std) of the |abs| of the signal

    returns: normalised_signal
    """
    signal=scipy.array(signal)

    if normalisation=="rms":
        return signal/signal.std(ddof=0)
    elif normalisation=="abs_max":
        return signal/(2.0*abs(signal).max())
    elif normalisation=="abs_rms":
        return signal/(2.0*abs(signal).std(ddof=0))
    else:
        return signal/signal.max()

def correlate(signal1, signal2=None, mode="full", time_domain=False, cyclic=False, zero_padding=True, normalise=False, shift_signal=False):
    """Calculate the cross correlation between signal1 and signal2

    NOTE: FFT based methods resemble cyclic time domain methods. Cyclic methods
        should be distrusted in high resolution resolving of delay times due to
        the non-physical shift of part of the later time signal to the previous
        time.
    NOTE: cyclic and non-cyclic methods give shifted peaks with respect to each
        other. Shifts are larger when the correlation window (length of signal
        traces) is shorter.
    
    signal1,2: two arrays of values representing the signals to make
       a correlation between. If the signal2 is None we do an autocorrelation
       of signal1.
    mode: "full", "same", "valid"
        full: give the full correlation trace
        same: the output is the size of the largest of the two input signals,
            centered with respect to the full trace.
        valid: the output are numbers of full who were scaled with all the
            values of both signals.
    time_domain: do the analysis in time domain, or take a frequency domain
        approach which is much faster but can only calculate a cyclic correlation.
    cyclic: Calculate the cyclic time domain correlation...
    zero_padding: Use zero padding in frequency domain, this makes that the
        result of the correlation is an approximation.
    normalise: If true, we normalise according to the standard deviations
    shift_signal: If True, shift the result such that the zero time is centered
        NOTE: this can contribute to off-by-one errors since the center for
            N=odd lies differently from N=even.
    
    returns: the correlation trace.
    """
    return_value=[]

    signal1=scipy.array(signal1)
    if not signal2==None:
        signal2=scipy.array(signal2)
    else:
        signal2=signal1

    if normalise:
        normalisation=signal1.std(ddof=1)*signal2.std(ddof=1)
    else:
        normalisation=1.0

    #The time domain equivalent of the cross-correlation
    if time_domain:
        return_value=scipy.signal.correlate(signal1, signal2, mode)/normalisation
    #The frequency domain equivalent of the (cyclic?) cross-correlation
    else:
        max_length=max(len(signal1), len(signal2))

        #We will to zero padding here to use the Fast Fourier Transform algorithm
        if zero_padding:        
            N=scipy.log10(max_length)/scipy.log10(2.0)
            if scipy.ceil(N%1):
                N+=1
            N=int(N)
            fft_length=2**N
            n_pre=(fft_length-len(signal1))/2+1
            n_post=(fft_length-len(signal1)-n_pre)
            signal1=scipy.concatenate((scipy.zeros(n_pre), signal1, scipy.zeros(n_post)))
            n_pre=(fft_length-len(signal2))/2+1
            n_post=(fft_length-len(signal2)-n_pre)
            signal2=scipy.concatenate((scipy.zeros(n_pre), signal2, scipy.zeros(n_post)))        
        else:
            fft_length=max_length
        #The old cyclic result...
        #return_value=scipy.real(scipy.fftpack.ifft(scipy.fftpack.fft(signal1, fft_length)*scipy.fftpack.fft(signal2, fft_length).conjugate()))/(normalisation)
        #The new noncyclic fft version from the signal library
        return_value=scipy.signal.fftconvolve(signal1, signal2[::-1], mode)

    if cyclic and mode=="full":
        n1=len(signal1)
        n2=len(signal2)
        nmax=max(n1,n2)
        #create cyclic signal from non-cyclic correlation...
        return_value=scipy.concatenate((scipy.zeros(nmax-n1), return_value[-n1:])) + scipy.concatenate((scipy.zeros(nmax-n2+1), return_value[:(n2-1)]))
    elif cyclic:
        print "Cyclic correlation can only be calculated with mode=full!\nReturning non-cyclic correlation..."

    if shift_signal:
        return_value=scipy.fftpack.fftshift(return_value)

    return return_value


##
## Statistical functions (not in scipy, unfortunately)
##
def median_absolute_deviation(data):
    """
    Calculate the MAD (median absolute deviation) this is a robust, though
    symmetric statistic that can be used to calculate an estimate of the
    standard deviation of the dataset by multiplication with 1.4826
    
    data: linear array of data (scipy array)
    
    returns: mean absolute deviation of dataset
    """
    data_median=scipy.median(data)
    return scipy.median(abs(data-data_median))

def median_absolute_std_estimator(data):
    """
    Calculate an estimate of the standard deviation by means of the MAD
    statistic of the dataset. It is simply 1.4826 * MAD.
    
    data: linear array of data (scipy array)
    
    return: robust std estimate
    """
    return 1.4826 * median_absolute_deviation(data)

def S_n(data, print_progress=True, print_every=100):
    """Calculate the robust statistic S_n which does not assume a symmetric
    distribution. It can be used to estimate the Std by multiplication with
    1.1926. It takes O(n**2) time to calculate it. (see also JASA-rousseeuw-1993)

    data: linear array of data (scipy array)
    print_progress: print a progress line
    print_every: prints a progress line every n cycles

    returns: S_n    
    """
    #TODO: optimize loop by partial broadcasting
    tmp_medians=[]
    data_len=len(data)
    i=0
    time_old=time.time()

    for i in range(0,len(f_beat),print_every):
        tmp_medians.extend(scipy.median(abs(f_beat[i:i+print_every, scipy.newaxis]-f_beat), axis=1))
        print "rounds to go:", f_beat_len-i, " %s to go. (this round took %g seconds)"%( datetime.timedelta(seconds=(time.time()-time_old)/100.*(f_beat_len-i)) ,time.time()-time_old)
        time_old=time.time()

    return scipy.median(tmp_medians)

def chauvenet_filter(data, mean=None, deviation=None, d=0.5, distribution="normal", print_info=False):
    """
    Create a filter for the dataset based on the chauvenet criterium. The
    function returns an array with booleans, True=valid datapoint, False=invalid
    datapoint according to the given criterium.
    
    data -- one dimensional scipy array with data values.
    mean -- median estimate of the mean value of the data set. If None, the
        median is calculated as a robust estimate of the mean
    deviation -- median average deviation estimate of the deviation of the data
        set. If None, the MAD is calculated as a robust estimator of the
        deviation.
    d -- criterium; the chance that a datapoint is an outlier based on the
        distribution and size of the dataset

    For the moment we can only work with normally distributed data. The filter
    is simply calculated based on a fixed distribution based on mean and
    deviation. In the future we might implement skewed distributions too based
    on higher order moments.
    
    returns: array of booleans
    """
    if distribution == "normal":
        #Calculate mean and deviation if not specified
        if mean==None:
            mean=scipy.median(scipy.array(data,dtype=scipy.float128))
        if deviation==None:
            deviation=median_absolute_std_estimator(data)

        distribution=scipy.stats.norm(loc=mean, scale=deviation)
    else:
        raise ValueError("Error, distribution type unknown")

    if print_info:
        print "mean:", mean
        print "deviation:", deviation
                
    P_outside=scipy.float64(d/float(len(data)))
    #Note: we need to devide the chance over both sides of the distribution
    #      therefore P/2 on both sides of the percent point function (ppf).
    criterium_min=distribution.ppf(0.5*P_outside)
    criterium_max=distribution.ppf(1.0-0.5*P_outside)

    if print_info:
        print "minimum data value:",criterium_min
        print "maximum data value:",criterium_max
    
    data_valid=scipy.array( ((data>criterium_min) & (data<criterium_max)), dtype=bool)

    print(scipy.where(data_valid==False))

    return data_valid



##
## Signal processing
##
def zero_crossing_times(time, signal):
    """Determine the time of zero crossings of a signal. We read the signal
    point by point and on detection of a zero crossing we calculate the time of
    the crossing by linear interpolation between the points.
    
    time: array with sampletimes of signal
    signal: array with signal values for zero crossing detection.
    
    NOTE: time and signal arrays can be of different lengths, in that case we
    return only zero crossings in the minimum of both lengths.
    
    returns: array with zero crossing times.
    """
    if not len(time)==len(signal):
        length=min(len(time), len(signal))
    else:
        length=len(signal)
    
    if signal[0] < 0.0:
        zero_crossing="neg_pos"
    else:
        zero_crossing="pos_neg"

    times=[]

    #Bepaal het tijdstip van de nuldoorgangen
    for i in range(1, length):
        if signal[i] > 0.0 and signal[i-1] < 0.0 and zero_crossing=="neg_pos":
            crossing_time=(time[i]-time[i-1]) * -float(signal[i-1])/(signal[i]-signal[i-1]) + time[i-1]
            times.append(crossing_time)
            zero_crossing="pos_neg"
        elif signal[i] < 0.0 and signal[i-1] > 0.0 and zero_crossing=="pos_neg":
            crossing_time=(time[i]-time[i-1]) * -float(signal[i-1])/(signal[i]-signal[i-1]) + time[i-1]
            times.append(crossing_time)
            zero_crossing="neg_pos"
        elif signal[i]==0.0 and zero_crossing=="neg_pos":
            crossing_time=time[i]
            times.append(crossing_time)
            zero_crossing="pos_neg"
        elif signal[i]==0.0 and zero_crossing=="pos_neg":
            crossing_time=time[i]
            times.append(crossing_time)
            zero_crossing="neg_pos"
        elif (signal[i] > 0.0 and signal[i-1] < 0.0 and zero_crossing=="pos_neg") or (signal[i] < 0.0 and signal[i-1] > 0.0 and zero_crossing=="pos_neg"):
            print "Non-continuous sinewave error!"
    
    return times

def zero_crossings(signal):
    """Determine the zero_crossings of signal with respect to the array index.
    A real time can then be instantaneously calculated from the sample rate time
    step T which we have normalised here (T=1). The length of the returned array
    is the number of zero crossings detected.
    
    signal: an array of signal values
    
    returns: an array of times when zero crossings occur
    """
    return_value=[]

    if signal[0] < 0.0:
        zero_crossing="neg_pos"
    else:
        zero_crossing="pos_neg"

    for i in range(1, len(signal)):
        if signal[i] > 0.0 and signal[i-1] < 0.0 and zero_crossing=="neg_pos":
            crossing_time = -float(signal[i-1])/(signal[i]-signal[i-1]) + float(i-1)
            return_value.append(crossing_time)
            zero_crossing="pos_neg"
        elif signal[i] < 0.0 and signal[i-1] > 0.0 and zero_crossing=="pos_neg":
            crossing_time = -float(signal[i-1])/(signal[i]-signal[i-1]) + float(i-1)
            return_value.append(crossing_time)
            zero_crossing="neg_pos"
        elif signal[i]==0.0 and zero_crossing=="neg_pos":
            crossing_time=float(i)
            return_value.append(crossing_time)
            zero_crossing="pos_neg"
        elif signal[i]==0.0 and zero_crossing=="pos_neg":
            crossing_time=float(i)
            return_value.append(crossing_time)
            zero_crossing="neg_pos"
        elif (signal[i] > 0.0 and signal[i-1] < 0.0 and zero_crossing=="pos_neg") or (signal[i] < 0.0 and signal[i-1] > 0.0 and zero_crossing=="pos_neg"):
            print "Non-continuous wave error!"
    
    return return_value

def low_pass_filter(signal, f_filter=1.0, N_filter=101, convolution_type="same"):
    """Low pass filter the given signal. f_sample=1.0. The default is to apply
    a filter at the 1.0*f_sample frequency (so not filtering).
    
    signal: a signal array
    f_filter: normalised filter frequency (to f_sample=2.0) (default 1.0, Nyquist frequency)
    N_filter: number of points for the filter.
    convolution_type: One of the types "full", "same" (default) or "valid". This
        determines the length of the returned filtered signal.

    returns: filtered signal    
    """
    lp_filter=scipy.signal.firwin(N_filter, f_filter)

    return scipy.convolve(signal, lp_filter, convolution_type)

def high_pass_filter(signal, f_filter=1.0, N_filter=101, convolution_type="same"):
    """High pass filter the given signal. f_sample=1.0. The default is to apply
    a filter at the 1.0*f_sample frequency (so not filtering).
    
    signal: a signal array
    f_filter: normalised filter frequency (to f_sample=1.0) (default 1.0)
    N_filter: number of points for the filter.
    convolution_type: One of the types "full", "same" (default) or "valid". This
        determines the length of the returned filtered signal.

    returns: filtered signal    
    """
    bands=[0.0,f_filter-0.001,f_filter+0.001,1.0]
    gain=[0.0,1.0]
    lp_filter=scipy.signal.remez(N_filter, bands, gain, Hz=2.0)

    return scipy.convolve(signal, lp_filter, convolution_type)

def jump_correction(signal, correction, discriminator=0.75):
    """Correct jumps in signal that are larger than discriminator by correction.
    This can e.g. be used to correct phase jumps of 2pi in phase signals if the
    phase is expected to be nearly continuous.
    
    signal: array of signal values
    correction: value to correct jumps with
    discriminator: set the discriminator at a fraction of the correction value
    
    returns: corrected signal
    """
    corrections=[0.0]
    signal_correction=0.0
    for i in range(len(signal)-1):
        signal_step=signal[i+1]-signal[i]
        if signal_step > discriminator*correction:
            signal_correction-=correction
        elif signal_step < -discriminator*correction:
            signal_correction+=correction

        corrections.append(signal_correction)

    return signal+corrections

def nearest_maximum_index(signal, index):
    """
    Seek the maximum in signal closest to index. This will only work with
    signals that have local maxima. Searches extend through minima.
    
    signal -- 1D array with signal
    index -- index in signal from which the search will extend to left and right
    
    returns: index of nearest maximum
    """
    maxima=argrelmax(signal)[0]
    index=scipy.where(abs((maxima-index))==abs((maxima-index)).min())[0][0]
    return maxima[index]

def quadrature_amplitude_phase(signal, f_lo=None, f_lpf=1.0, f_pre_lpf=None, phase_jump_correction=0.75, lo_phase=0.0):
    """Determine the phase and amplitude of the given signal with a quadrature
    detector (IQ). Frequencies are normalised to f_sample=1.0 (This means that
    all frequencies in the signal should be <0.5)
    
    signal: an array with signal data points.
    f_lo: normalised local oscillator frequency zero_crossings/len(signal)
        if None, we try to determine the average signal frequency by counting
        the number of zero_crossings...
    f_lpf: low_pass_filter frequency normalised to f_lo
    f_pre_lpf: if set we filter the signal at this normalised frequency (<0.5)
        before IQ detection.
    phase_jump_correction: if set, we try to remove quirky phase jumps due to
        the arctan2 function which wraps the phase in between -pi, pi.
        The disciminator is placed at 0.75 * 2*pi.
    lo_phase: adjust the phase of the local oscillator values from 0.0 to 2*pi
        make sense (it is in radians). For a non phase shifted correction of the
        signal the lo_phase should match the start phase of the signal...
    
    returns: array([[amplitudes], [phases]])
    """
    #prefilter the signal    
    if f_pre_lpf:
        signal=low_pass_filter(signal, f_pre_lpf)
    
    #determine f_lo
    crossings=zero_crossings(signal)
    if f_lo==None:
        f_lo=float(len(crossings)-1)/(2.0*(crossings[-1]-crossings[0]))
        print "determined f_lo to be:", f_lo

    if f_lo > 0.25:
        print "f_lo > 0.25, Beware of aliasing problems that might arise since part\nof the signal ends up > 0.5*f_sample (= in the baseband)"

    #I and Q local oscilator signals
    #We name I and Q since the time domain arrays can be large and we would like
    #to save some memory
    I=scipy.sin(2.0*scipy.pi*f_lo*scipy.array(range(len(signal)))+lo_phase)
    Q=scipy.sin(2.0*scipy.pi*f_lo*scipy.array(range(len(signal)))+0.5*scipy.pi+lo_phase)

    I*=signal
    Q*=signal
    
    I=low_pass_filter(I, f_lpf*f_lo)
    Q=low_pass_filter(Q, f_lpf*f_lo)
    
    #the amplitude signal
    amplitude=scipy.sqrt(I**2+Q**2)
    #This signal can contain relatively many almost 2pi phase jumps.
    phase=scipy.arctan2(Q, I)
    if phase_jump_correction:
        phase=jump_correction(phase, 2*scipy.pi, phase_jump_correction)

    #For debug purposes, return I, Q
    #return scipy.array([I, Q])
    return scipy.array([amplitude, phase])



def hamming_window(signal, normalise_amplitude=True):
    """Apply the Hamming window function to the signal.
    
    See Soliman section 10.4
    
    normalise_amplitude: If True, the average amplitude of the window function
        will be 1.0 in order to maintain the calibration of power signals.
    
    returns: signal with window function applied
    """
    #Window coefficients
    a_0=0.54
    a_1=0.46
    
    length=len(signal)
    filt=scipy.arange(length)
    filt=a_0-a_1*scipy.cos(2.0*scipy.pi*filt/(length-1))
    if normalise_amplitude:
        filt=filt/filt.mean()
    
    return filt*signal



def hanning_window(signal, normalise_amplitude=True):
    """Apply the Hanning window function to the signal.
    
    See Soliman section 10.4
    
    normalise_amplitude: If True, the average amplitude of the window function
        will be 1.0 in order to maintain the calibration of power signals.
    
    returns: signal with window function applied
    """
    length=len(signal)
    filt=scipy.arange(length)
    filt=0.5*(1-scipy.cos(2.0*scipy.pi*filt/(length-1)))
    if normalise_amplitude:
        filt=filt/filt.mean()
    
    return filt*signal



def blackman_window(signal, normalise_amplitude=True):
    """Apply the Blackman window function to the signal.
    
    See Soliman section 10.4
    
    normalise_amplitude: If True, the average amplitude of the window function
        will be 1.0 in order to maintain the calibration of power signals.
    
    returns: signal with window function applied
    """
    #Filter coefficients
    a0=0.42
    a1=0.5
    a2=0.08
    
    length=len(signal)
    filt=scipy.arange(length)
    filt=a0 - a1*scipy.cos(2.0*scipy.pi*filt/(length-1)) + a2*scipy.cos(4.0*scipy.pi*filt/(length-1))
    if normalise_amplitude:
        filt=filt/filt.mean()
    
    return filt*signal



def bartlett_window(signal, normalise_amplitude=True):
    """Apply the Bartlet window function to the signal.
    
    See Soliman section 10.4
    
    normalise_amplitude: If True, the average amplitude of the window function
        will be 1.0 in order to maintain the calibration of power signals.
    
    returns: signal with window function applied
    """
    length=len(signal)
    filt=scipy.arange(length)
    filt_left=2.0*filt[:length]/(length-1)
    filt_right=(-2.0*filt[length:]/(length-1)+2)
    filt=scipy.concatenate((filt_left, filt_right))

    if normalise_amplitude:
        filt=filt/filt.mean()
    
    return filt*signal



def kaiser_window(signal, alpha=5.414, nu=0, normalise_amplitude=True):
    """Apply the Kaiser window function to the signal. By default this window
    function returns the Hamming window.
    
    See Soliman section 10.4, the claim that soliman puts that this filter
    gives the Hamming window is not true (or I chose the wrong version of the
    Bessel function.)
    
    alpha -- 0.0=rectangular, 5.414=hamming window, needs to be positive
    nu -- order of the modified bessel function of the first kind (0 for
        kaiser window)
    normalise_amplitude: If True, the average amplitude of the window function
        will be 1.0 in order to maintain the calibration of power signals.
    
    returns: signal with window function applied
    """
    if alpha < 0:
        Exception("alpha needs to be larger than zero")
    
    length=len(signal)
    #Modified Bessel function of the first kind
    #scipy.special.iv(0, x), it goes to very large number (it is an exponential
    #like function for larger x. we therefore normalise the x-range for this
    #filter function.
    filt=scipy.arange(0,1+1.0/length,1.0/(length-1))

    #Soliman equations...
    #teller=alpha*scipy.sqrt(((length-1)/2.0)**2 - (filt - (length-1)/2.0)**2)
    #noemer=alpha*(length-1)/2.0

    #Normalised X equations
    teller=alpha*scipy.sqrt(((1-1.0/length)/2.0)**2 - (filt - (1-1.0/length)/2.0)**2)
    noemer=alpha*(1-1.0/length)/2.0

    filt=scipy.special.iv(nu, teller)/scipy.special.iv(nu, noemer)
    if not len(filt)==length:
        Exception("ERROR in Kaiser")

    if normalise_amplitude:
        filt=filt/filt.mean()
    
    return filt*signal



def psd(signal, frequency_domain=False, window=True, zero_padding=True, absolute_power_scaling=True):
    """Calculate the power spectral density of a signal (Haykin 4.60, 4.61)
    signal: signal values to calculate the PSD on
    time_domain: if True, take the time domain approach to PSD
        else take S(f)=E[(X_T.X_T^*)/T] and X_T=F(x_T)
    window: True, applies hamming window to signal, this will underestimate
        the PSD when the frequency domain analysis is chosen.
    zero_padding: zero padd to signal length of 2**N for fast implementation
    absolute_power_scaling: if True normalise to len(signal) in stead of
        len(zero_padded_signal), see NOTE.
    
    For the scaling properties see Soliman 7.5.17 and 18, and fig. 7.5.1
    NOTE: the zero_padding makes the scaling unreliable for absolute (power)
        measurements because there is no power in the added part of the time
        domain signal, while we do correct for it by taking the zero's into
        account in the zero padded signal length.
        This change the power with a significant number, e.g. 2 to 3 dB or more.
        The absolute_power_scaling option corrects for this by taking the
        original signal length for scaling the FFT in stead of the length of the
        zero padded signal.
    
    returns: power_spectral_density signal
    """
    start=time.time()
    #frequency domain
    if frequency_domain:
#        print "PSD frequency domain analysis"
        if window:
            signal=hamming_window(signal)

        if zero_padding:
            N=1
            while 2**N <len(signal):
                N+=1
            length=2**N
        else:
            length=len(signal)

        fft=scipy.fftpack.fft(signal,n=length)
        fft_time=time.time()

#        print "fft time: %f seconds"%(fft_time-start)

        #discrete time scaling...
        if absolute_power_scaling:
            scaling=1.0/(len(signal))
        else:
            scaling=1.0/(length)

        psd=scipy.fftshift( scaling*abs(fft)**2 )

    #time domain
    else:
#        print "PSD time domain analysis"

        if window:
            signal=hamming_window(signal)

        corr=scipy.correlate(signal, signal, "full")
        corr_time=time.time()
#        print "correlation time: %f seconds"%(corr_time-start)

        if zero_padding:
            N=1
            while 2**N <len(corr):
                N+=1
            length=2**N
        else:
            length=len(corr)

        #discrete time scaling...
        if absolute_power_scaling:
            scaling=1.0/(len(signal))
        else:
            scaling=2.0/(length)

        psd=scipy.fftshift(scaling*abs(scipy.fftpack.fft(corr, n=length)))
        fft_time=time.time()
#        print "fft time: %f seconds"%(fft_time-corr_time)
        
    return psd

def power_spectral_density(axis, signal, time_domain=False, window=False):
    """Calculate the power spectral density of a signal (Haykin 4.60, 4.61) and
    the inverse of the axis matching the power spectral density
    
    axis: equidistant, monotone axis values of the signal values (e.g. time or frequency)
    signal: signal values to calculate the PSD on
    time_domain: if true take time domain implementation which becomes slow at
        large signal length because of the autocorrelation function.
    window: Apply a hamming window to the signal, this appears to underestimate
        the power signal by about 5.5dB, this is now fixed by the normalisation
        being adjusted by default.

    NOTE: since we go to 2**N for a fast fourier transform implementation, the
    length of the returned axis and signal are longer than the input.
    
    returns: axis, signal
    """
    axis_min=scipy.array(axis).min()
    axis_max=scipy.array(axis).max()
    axis_step=abs(axis[1]-axis[0])
    axis_span=(axis_max+axis_step)-axis_min
    
    if time_domain:
        psd_signal=psd(signal, window=window)
    else:
        psd_signal=psd(signal, frequency_domain=True, window=window)

    axis_step_new=float(len(psd_signal))*axis_step
    axis_new=scipy.arange(-1.0/(2.0*axis_step), 1.0/(2.0*axis_step), 1.0/axis_step_new)
 
#    print "new axis length: ", len(axis_new), " PSD signal length: ", len(psd_signal)

    #The factor of two corrects for the fact that we will look at the positive
    #frequency part only. Normally half of the power is in the negative part
    #of the spectrum...
    scaling=2.0*axis_step/axis_span

    return axis_new, scaling*psd_signal

def dB(signal):
    """Convert the linear scale of a signal to a 10*log10
    (=dB) scale.
    
    returns: signal in dB
    """
    return 10.0*scipy.log10(signal)

def S_V_to_S_dBm(V_psd, impedance=50.0):
    """Convert a Voltage spectral density of a voltage signal into a Power
    spectral density (power into an impedance) in dBm's.
    
    V_psd: Voltage power spectral density signal
    impedance: impedance into which the power is dissipated (default 50 Ohm).
    
    returns: Power spectral density in dBm
    """
    #S_V in (V**2/Hz), devide by the impedance (50 Ohm) to get
    #a power value. This value should then be referenced to the 0dBm (1 mW)
    return 10.0*scipy.log10((V_psd/float(impedance))/1e-3)

def S_fwhm(f_axis, S, f_center=None, f_span=None, dB_scaled=False):
    """Determine the full width half maximum of a peak in the spectrum.
    
    f_axis: frequency axis
    S: the spectral density signal
    f_center: center frequency to look around for a peak, if no f_span, we look
        for the peak nearest to f_center
    f_span: span around the center frequency we look for a peak
        in f_center +/- f_span, if no center frequency, we look around 0
    dB_scaled: if true we asume the signal is on a dB scale and we will look
        for the -3dB value
    
    returns: f_center, f_fwhm
    """
    f_axis=scipy.array(f_axis)
    S=scipy.array(S)
    
    # determine minimum and maximum frequencies to search between
    if f_center and f_span:
        f_min=f_center-f_span
        f_max=f_center+f_span
    elif f_center:
        f_min=0.0
        f_max=f_axis.max()
    elif f_span:
        f_min=-f_span
        f_max=f_span
    
    #TODO: fill in further...

def fwhm(spectrum, threshold=2.0):
    """Determine the full width half maximum of the spectrum.
       The input is an array of arrays [wavelength, intensity]
       
       Threshold is max/threshold (so threshold of 2 is half maximum, 4 is quarter maximum etc.)
       
       Returns an array with [lower_wavelength, center_wavelength, right_wavelength]
    """
    threshold=float(threshold)
    maximum=spectrum[:,1].max()
    
    print maximum, maximum/threshold
    
    for i in range(len(spectrum[:,1])):
        if spectrum[i,1]==maximum:
            maximum_position=i
            print "maximum position is ",maximum_position
            break
    
    break_loop=0
    # from peak position to 0 in array
    for i in range(maximum_position,0,-1):
        if spectrum[i,1]<=maximum/threshold:
            print "spectral value is ",spectrum[i,1]," wavelength is ",spectrum[i,0]
            di=spectrum[i+1,1]-spectrum[i,1] #height
            ds=spectrum[i+1,0]-spectrum[i,0] #wavelength
            stepi=maximum/threshold-spectrum[i,1]
            fractioni=stepi/di
            left_wavelength=spectrum[i,0]+fractioni*ds
            break_loop=1
            break

    if not break_loop:
        print "No half maxium value found on left side, taking minimum wavelength"
        left_wavelength=spectrum[0,0]

    break_loop=0
    # from peak position to maximum in array    
    for i in range(maximum_position,len(spectrum[:,1])):
        if spectrum[i,1]<=maximum/threshold:
            print "spectral value is ",spectrum[i,1]," wavelength is ",spectrum[i,0]
            di=spectrum[i,1]-spectrum[i-1,1] #height
            ds=spectrum[i,0]-spectrum[i-1,0] #wavelength
            stepi=maximum/threshold-spectrum[i,1]
            fractioni=stepi/di
            right_wavelength=spectrum[i,0]-fractioni*ds
            break_loop=1
            break

    if not break_loop:
        print "No half maximum value found on right side, taking maximum wavelength"
        right_wavelength=spectrum[len(spectrum[:,1])-1,0]
    
    # calculate central (=average) wavelength
    center_wavelength=(left_wavelength+right_wavelength)/2.0
        
    return [left_wavelength, center_wavelength, right_wavelength]

##
## Some generic fitting functions
##
def _fit_function_exponential(p,x):
    """Fit function for an exponential increase/decay, offset + amplitude * exp(alpha * x)
    
    p: [offset, amplitude, alpha]
    x: [x_axis_values]

    returns: [y_axis_values] (for p,x)
    """
    offset, amplitude, alpha = p
    return offset + amplitude * scipy.exp(alpha * x)
    
def _fit_function_gaussian(p, x):
    """Fit function for a Gaussian peak. To obtain the FWHM the fitted width needs
    to be multiplied by FWHM_multiplier=2.0*scipy.sqrt(2.0*scipy.log(2.0))
    
    p: [frequency, intensity, width, offset]
    x: [frequencies]
    
    returns: [intensities] (for p,x)
    """
    frequency, intensity, width, y_offset=p
    return intensity*scipy.e**(-(x-frequency)**2/(2.0*width**2)) + y_offset

def _fit_function_linear(p, x):
    """Fit function for a line (offset + slope*x)
    
    p: [offset, slope] (more traditional b,a)
    x: [x_axis_values]

    returns: [y_axis_values] (for p,x)
    """
    offset, slope = p
    return offset + slope * x

def _fit_function_lorentzian(p, x):
    """Fit function for a Lorentzian peak.
    
    p: [frequency, intensity, fwhm, offset]
    x: [frequencies]
    
    returns: [intensities] (for p,x)
    """
    frequency, intensity, fwhm, y_offset=p
    return intensity*(fwhm**2/((x-frequency)**2+fwhm**2)) + y_offset

def _fit_function_sine(p, x):
    """Fit function for a sine wave
    
    p: [offset, amplitude, phase, period]
    x: [x_axis_values] in units of period

    returns: [y_axis_values] (for p,x)
    """
    offset, amplitude, phase, period = p
    return offset + amplitude * scipy.sin(2*scipy.pi*x/period - phase)
    
def _fit_function_sine_fixed_period(p, x):
    """Fit function for a sine wave with a fixed 2*pi rad period...
    
    p: [offset, amplitude, phase]
    x: [x_axis_values] in radian

    returns: [y_axis_values] (for p,x)
    """
    offset, amplitude, phase = p
    return offset + amplitude * scipy.sin(x - phase)
    

#define a dict with fitfunctions to be able to quickly switch between them...
fit_functions={
    "exponential":_fit_function_exponential,
    "gaussian":_fit_function_gaussian,
    "linear":_fit_function_linear,
    "lorentzian":_fit_function_lorentzian,
    "sine":_fit_function_sine,
    "sine_fixed_period":_fit_function_sine_fixed_period,
}

#generic residuals function for a least squares fit
def fit_residuals(p, y, x, fit_function):
    """Generic residuals function for the scipy least squares fitting function.
    
    p: array of fitting parameters for fit_function
    y: scipy.array of y (data) values
    x: scipy.array of x (data/axis) values
    fit_function: function to fit on data, takes two arguments: function(p, x)
    
    The contraption is typically used as in:
    fit=scipy.optimize.leastsq(fit_residuals, p0, args=(y_values, x_values, fit_function))
    
    which will than return the fitting result (a fitted verion of the parameters
    p0) as the first member of the returned array (fit[0])
    """
    residuals = y - fit_function(p, x)
    return residuals



##
## Calculate properties of atomic transitions...
##
def recoil_shift_inclusive(f_observed, m_a):
    """Calculate the recoil shift from the observed transition frequency for a
    one photon transition, or a two photon transition excited from a single side.
    f_observed includes the recoil shift.

    In case of a transition excited with counter propagating (quasi) doppler
    free beams the recoil shift can be calculated using this equation entering
    the frequency difference of the photons with which the transition was
    observed, because partial cancellation of the impulses of the photons.
    
    f_observed: transition frequency (including shift) [Hz].
    m_a: mass of the atom [kg].
    
    returns: recoil shift [Hz]
    """
    return uc.h * decimal.Decimal(f_observed)**2/(2 * decimal.Decimal(m_a) * uc.c**2)
    
def recoil_shift_exclusive(f_transition, m_a):
    """Calculate the recoil shift for a tabulated transition frequency for a one
    photon transition, or a two photon transition excited from a single side.
    f_transition excludes the recoil shift.
    
    f_transition: transition frequency (excluding shift) [Hz].
    m_a: mass of the atom [kg].
    
    returns: recoil shift [hz]
    """
    #TODO: fix floating point "mistakes" in calculation, we will use decimal...

    const=uc.h/(decimal.Decimal(m_a)*(uc.c**2))
    a = const*decimal.Decimal(0.5)
    b = const*decimal.Decimal(f_transition) - decimal.Decimal("1")
    c = const*decimal.Decimal(f_transition)**2/decimal.Decimal("2")
    
    D=b**2-4*a*c
    
    #Especially in the f_rec_min, the subtraction of two very small numbers fails...
    f_rec_plus= (-b + D.sqrt()) / ( 2*a )
    f_rec_min= (-b - D.sqrt()) / ( 2*a )
    
#    return 2.0*m_a*uc.c**2/uc.h -2.0*f_transition + 2.0*m_a*uc.c**2/uc.h*scipy.sqrt(1.0 - (2.0*uc.h*f_transition/(m_a*uc.c**2)))

    return f_rec_plus, f_rec_min

def doppler_shift_2nd_order_exclusive(f_transition, v_atom):
    """Calculate the second order Doppler shift for an atom with a certain velocity v moving
    perpendicular to the line of sight from the observer to the object. The first order
    Doppler shift needs to be considered separately.

    In this case we take the transition frequency to be a tabulated frequency, which
    is first corrected to the frequency of the "received photon", before calculating
    the second order doppler shift
    
    f_transition: frequency of the atomic transition [Hz]
    v_atom: the (transverse) velocity of the atom [m/s]
    
    returns: 2nd order Doppler shift [Hz]
    """
    f_nominal = f_transition*1.0/(1.0 - (float(v_atom)**2)/(2.0*uc.c**2))
    
    f_doppler_2nd = f_nominal * (float(v_atom)**2/(2.0*uc.c**2))
    
    return f_doppler_2nd
    
def doppler_shift_2nd_order_inclusive(f_observed, v_atom):
    """Calculate the second order Doppler shift for an atom with a certain velocity v moving
    perpendicular to the line of sight from the observer to the object. The first order
    Doppler shift needs to be considered separately.

    In this case we take the transition frequency to be the measured and uncorrected
    light frequency. The here calculated frequency needs to be subtracted from the
    input frequency in order to correct the measured transition frequency for the
    second order Doppler shift.
    
    f_observed: observed frequency of the atomic transition [Hz]
    v_atom: the (transverse) velocity of the atom [m/s]
    
    returns: 2nd order Doppler shift [Hz]
    """
    f_doppler_2nd = f_observed * (float(v_atom)**2/(2.0*uc.c**2))
    
    return f_doppler_2nd

def lande_g_factor(L, S, J=None, g_L=1.0, g_S=2.0):
    """Calculate the Landé g-factor. According to the wikipedia article about
    this it is equal to: g_J=g_L*(J(J+1)-S(S+1)+L(L+1))/(2J(J+1)) + g_S*(J(J+1)+S(S+1)-L(L+1))/(2J(J+1))
    where J is calculated as J=L+S if J is not supplied (None).

    L: total orbital angular momentum (l1 + l2 + ...)
    S: total spin angular momentum (s1 + s2 + ...)
    g_L: electron orbital g-factor (exactly 1)
    g_S: electron spin g-factor (2.002319, see NIST database)
    
    returns: Landé g-factor
    """
    if J==None:
        J=L+S
        
    return g_L*(J*(J+1)-S*(S+1)+L*(L+1))/(2.0*J*(J+1)) + g_S*(J*(J+1)+S*(S+1)-L*(L+1))/(2.0*J*(J+1))





##
##
## NOT YET IN OUR SCIPY....
##
##
def _boolrelextrema(data, comparator, axis=0, order=1, mode='clip'):
    """
    Calculate the relative extrema of `data`.

    Relative extrema are calculated by finding locations where
    ``comparator(data[n], data[n+1:n+order+1])`` is True.

    Parameters
    ----------
    data : ndarray
    Array in which to find the relative extrema.
    comparator : callable
    Function to use to compare two data points.
    Should take 2 numbers as arguments.
    axis : int, optional
    Axis over which to select from `data`. Default is 0.
    order : int, optional
    How many points on each side to use for the comparison
    to consider ``comparator(n,n+x)`` to be True.
    mode : str, optional
    How the edges of the vector are treated. 'wrap' (wrap around) or
    'clip' (treat overflow as the same as the last (or first) element).
    Default 'clip'. See numpy.take

    Returns
    -------
    extrema : ndarray
    Indices of the extrema, as boolean array of same shape as data.
    True for an extrema, False else.

    See also
    --------
    argrelmax, argrelmin

    Examples
    --------
    >>> testdata = np.array([1,2,3,2,1])
    >>> argrelextrema(testdata, np.greater, axis=0)
    array([False, False, True, False, False], dtype=bool)

    """
    if((int(order) != order) or (order < 1)):
        raise ValueError('Order must be an int >= 1')

    datalen = data.shape[axis]
    locs = scipy.arange(0, datalen)

    results = scipy.ones(data.shape, dtype=bool)
    main = data.take(locs, axis=axis, mode=mode)
    for shift in xrange(1, order + 1):
        plus = data.take(locs + shift, axis=axis, mode=mode)
        minus = data.take(locs - shift, axis=axis, mode=mode)
        results &= comparator(main, plus)
        results &= comparator(main, minus)
        if(~results.any()):
            return results
    return results


def argrelmin(data, axis=0, order=1, mode='clip'):
    """
    Calculate the relative minima of `data`.

    .. versionadded:: 0.11.0

    Parameters
    ----------
    data : ndarray
    Array in which to find the relative minima.
    axis : int, optional
    Axis over which to select from `data`. Default is 0.
    order : int, optional
    How many points on each side to use for the comparison
    to consider ``comparator(n, n+x)`` to be True.
    mode : str, optional
    How the edges of the vector are treated.
    Available options are 'wrap' (wrap around) or 'clip' (treat overflow
    as the same as the last (or first) element).
    Default 'clip'. See numpy.take

    Returns
    -------
    extrema : ndarray
    Indices of the minima, as an array of integers.

    See also
    --------
    argrelextrema, argrelmax

    Notes
    -----
    This function uses `argrelextrema` with np.less as comparator.

    """
    return argrelextrema(data, scipy.less, axis, order, mode)


def argrelmax(data, axis=0, order=1, mode='clip'):
    """
    Calculate the relative maxima of `data`.

    .. versionadded:: 0.11.0

    Parameters
    ----------
    data : ndarray
    Array in which to find the relative maxima.
    axis : int, optional
    Axis over which to select from `data`. Default is 0.
    order : int, optional
    How many points on each side to use for the comparison
    to consider ``comparator(n, n+x)`` to be True.
    mode : str, optional
    How the edges of the vector are treated.
    Available options are 'wrap' (wrap around) or 'clip' (treat overflow
    as the same as the last (or first) element).
    Default 'clip'. See `numpy.take`.

    Returns
    -------
    extrema : ndarray
    Indices of the maxima, as an array of integers.

    See also
    --------
    argrelextrema, argrelmin

    Notes
    -----
    This function uses `argrelextrema` with np.greater as comparator.

    """
    return argrelextrema(data, scipy.greater, axis, order, mode)


def argrelextrema(data, comparator, axis=0, order=1, mode='clip'):
    """
    Calculate the relative extrema of `data`.

    .. versionadded:: 0.11.0

    Parameters
    ----------
    data : ndarray
    Array in which to find the relative extrema.
    comparator : callable
    Function to use to compare two data points.
    Should take 2 numbers as arguments.
    axis : int, optional
    Axis over which to select from `data`. Default is 0.
    order : int, optional
    How many points on each side to use for the comparison
    to consider ``comparator(n, n+x)`` to be True.
    mode : str, optional
    How the edges of the vector are treated. 'wrap' (wrap around) or
    'clip' (treat overflow as the same as the last (or first) element).
    Default is 'clip'. See `numpy.take`.

    Returns
    -------
    extrema : ndarray
    Indices of the extrema, as an array of integers (same format as
    np.argmin, np.argmax).

    See also
    --------
    argrelmin, argrelmax

    """
    results = _boolrelextrema(data, comparator,
                              axis, order, mode)
    if ~results.any():
        return (scipy.array([]),) * 2
    else:
        return scipy.where(results)
