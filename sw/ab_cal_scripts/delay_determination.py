"""
Delay Determination Library with functions for delay estimation.

License GPL version 2:

Copyright (C) 2016  Tjeerd Pinkert
based on:
<...>


This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

-------------------------------------------------------------------------------

This library mainly holds closely inspected correlation functions which are
rigorously checked for one off errors etc.
"""

import sys
import copy
import os
import scipy
import scipy.signal
#import agilent_DSO80000_aux as DSO
#import wfm
import bz2

##
## Add some "missing" functions to older scipy modules 
##
#if scipy.__version__ < "0.11.0":
if scipy.__version__ < "0.14.0":
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

    setattr(scipy, "_boolrelextrema" ,_boolrelextrema)



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

    setattr(scipy, "argrelmin", argrelmin)



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

    setattr(scipy, "argrelmax", argrelmax)



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

    setattr(scipy, "argrelextrema", argrelextrema)



##
## Library functions.
##
analysis_methods= [
    "correlation_circular",
    "correlation_linear",
    "correlation_circular_interpolate",
    "correlation_linear_interpolate",
]



#TODO: finish this function....
def delay_from_waveform(waveform_data, analysis, channels=[2,4], length=0.0, refractive_index=1.5):
    """
    Analise the delay resulting from an oscilloscope trace using the cross
    correlation methods. The function returns a dictionary with delay values
    for each analysis method.
    
    waveform_data -- raw waveform data as read from oscilloscope or as read
        from a file.
    analysis -- dictionary with analysis methods to use and for each analysis
        method the non default parameters. Format described below.
    channels -- array of two channels to perform the delay analysis on
        (default [2,4])
    length -- estimated/measured length of the cable in meter (default: 0.0)
    refractive_index -- estimated/measured refractive index of the cable
        (default: n=1.5)
    
    The delay can be determined by various analysis methods. Currently the
    following methods have been implemented:
    - correlation_circular: circular correlation
    - correlation_linear: linear correlation
    - correlation_circular_interpolate: circular correlation followed by interpolation
    - correlation_linear_interpolate: linear correlation followed by interpolation
    It must be noted that some of the correlation methods depend on others in
    order to be efficiently performed. i.e. the linear interpolated method needs
    the linear correlation, while the linear correlation needs an estimation
    retrieved from the circular correlation on the complete dataset. The
    dependencies will be set accordingly.

    Analysis format: dictionary with keys determining the analysis methods to
    be used. Each dictionary entry holds a dictionary with **kwargs to be passed
    to the analysis functions.

    Return format: dictionary with a determined delay for each of the analysis
    methods. The analysis methods are the keys of this dictionary.

    returns: time delays of second channel with respect to first channel for
        each analysis method.
    """
    #TODO: remove this and make it an entity in the main library file
    __analysis_methods=[
        "correlation_linear",
        "correlation_circular",
        "correlation_linear_interpolate",
        "correlation_circular_interpolate",
        ]

    #set up dependencies for analysis methods...

    #interpret channels array
    if not type(channels)==list:
        raise delay_calibration_error("channels argument must be an array")
    if not len(channels)==2:
        raise delay_calibration_error("channels array must have two entries")
    if not type(channels[0])==int or not type(channels[1])==int:
        raise delay_calibration_error("channels must be of type int")
    channel_one=channels[0]
    channel_two=channels[1]

    #interpret the waveform data, the data is then ready for analysis
    waveform_data=DSO.interpret_raw_waveform_data(waveform_data)

    #make initial estimation of the delay
    delay_axis_estimate, correlation_estimate=correlate_circular(waveform_data[channel_one]["waveform"][1], waveform_data[channel_two]["waveform"][1])
    delay_axis_estimate_t=time_axis(delay_axis_estimate, waveform_data[channel_one]["preamble"]["x_increment"], waveform_data[channel_one]["preamble"]["x_origin"], waveform_data[channel_two]["preamble"]["x_origin"])
    delay_index_selector=(delay_axis_estimate_t+cable_delay_estimate<channel_1_dt/2.0)*(delay_axis_estimate_t+cable_delay_estimate>=-channel_1_dt/2.0)
    delay_index_estimate=scipy.arange(len(delay_axis_estimate_t))[delay_index_selector]
    correlation_max_index=nearest_maximum_index(correlation_estimate, delay_index_estimate)
    center_estimation=correlation_max_index-len(channel_1_y)/2

    
    return_values={}
    
    for analysis_method in analysis.keys():
        if not analysis_method in __analysis_methods:
            raise delay_calibration_error("Unknown analysis method: %s"%(str(analysis_method)))

        if analysis_method == "correlation_circular":
            pass
        elif analysis_method == "correlation_linear":
            pass
        elif analysis_method == "correlation_circular_interpolate":
            pass
        elif analysis_method == "correlation_linear_interpolate":
            pass
    #filter out unwanted correlation estimates



def correlate_linear(signal1, signal2, center=0, shift=100, length=None, correlation_type="DC", zero_padd=False):
    """
    Linear correlation as proposed in ITSP-jacovitti-1993. This is a linear
    correlation on a subset of the signal samples, such that no zero padding is
    applied.
    
    The problem with zero-padding is that cross correlation
    automatically favours the centre position of the signals because zero
    padding makes the correlation signal zero if the signals are maximally
    shifted and tend to introduce a triangular overall scaling. This is already
    much less pronounced with a circular correlation, but can still be present
    in certain situations. This is also typical for linear cross correlations
    in which two equal length signals are effectively zero padded.
    
    signal1,2 -- signals to correlate.
    center -- the expected center position of the cross correlation. If signal2
        if physically shifted by "n" positions compared to signal 1, the
        expected center of the correlation lies at "-n".
        This parameter is typically used to circumvent large calculation times
        by setting this to the approximate position of the peak, and correlating
        +-shift around the center, in stead of enlarging shift to include the
        main correlation peak
    shift -- size of the cross correlation shifts around the center. The
        returned signal is 2*length+1 (we shift from -shift to +shift).
    length -- size of the correlation window. If signals are expected to have
        different center positions, we have different lengths if length=None is
        set. Therefore the size of the correlations can in this case not be
        compared.
    correlation_type -- one of three types DC: direct correlation, ASDF: average
        square difference function, AMDF: average magnitude difference function.
        These types are proposed in ITSP-jacovitti-1993
        One must take care with the non direct correlation types and perform
        the correct interpolation to obtain valid results for the time delay
        estimate.
    zero_padd -- zero padd result such that it can directly be compared with
        the fft and circular methods.
    
    returns: delay_axis, correlation_signal
        delay_axis -- signal delay including center position shift. If positive
            then signal1 is delayed with respect to signal2, if negative then
            signal2 is delayed.
        correlation_signal -- correlation signal at corresponding delay. Signal
            length is 2*shift+1
    """
    #Turn signals into scipy arrays
    if not type(signal1)==scipy.array:
        signal1=scipy.array(signal1)
    if not type(signal1)==scipy.array:
        signal2=scipy.array(signal2)

    correlation_types=["DC", "ASDF", "AMDF"]
    #check for valid correlation_type variable
    if not correlation_type in correlation_types:
        raise Exception("correlation_type not valid. Choose one of: %s"%(str(correlation_types)))

    #print signal1.shape, signal2.shape
    
    #The maximum correlation window length is always the shortest of the two
    #signals - abs(center) - 2*shift
    window_length=min(len(signal1),len(signal2))-abs(center)-2*shift
    if length==None:
        length=window_length

    #Raise exception that we cannot reach the length of the correlation the user
    #had thought to reach.
    #print window_length
    if window_length < length:
        raise Exception("Signal truncated too much (due to center and shift) to reach length of correlation window.")
    else:
        window_length=length
    #print "window length:", window_length

    correlation=scipy.zeros(2*shift+1)
    #print len(correlation)
    
    #perform actual correlation for shift "k" around "center"
    delay_axis=scipy.arange(-shift,shift+1)
    for k in delay_axis:
        index=k+shift
        index_inverted=shift-k
        
        if shift+center < 0:
        #cut signal1 non-shifted, shift signal2 by an aditional abs(shift+center) so that we don't need wrap arounds.
            signal1_lower_index=0
            signal1_upper_index=int(window_length)
            signal2_boundary=index+abs(shift+center)
        else:
        #we cut signal1, shifted by shift+center so that we don't need wrap arounds.
            signal1_lower_index=shift+center
            signal1_upper_index=shift+center+int(window_length)
            signal2_boundary=index
        
        signal1_cut=signal1[signal1_lower_index:signal1_upper_index]
        #print signal1_lower_index, signal1_upper_index
        
        #which signal indices? we must never wrap around...
        shifted_indices=scipy.concatenate((scipy.arange(signal2_boundary,len(signal2),dtype=int),scipy.arange(signal2_boundary, dtype=int)))[:len(signal2)]
        signal2_shift=signal2.take(shifted_indices)[:window_length] #cut it here, little less copy work
        #print index, shifted_indices[:window_length], shifted_indices
        
        #check for correlation_type validity is done at beginning of function
        #correlate...
        if correlation_type=="DC":
            correlation[index_inverted]=(signal1_cut*signal2_shift).sum()
        elif correlation_type=="ASDF":
            correlation[index_inverted]=((signal1_cut-signal2_shift)**2).sum()
        elif correlation_type=="AMDF":
            correlation[index_inverted]=(signal1_cut-signal2_shift).sum()

        #print result for debugging
        #print index, correlation[index_inverted]

    delay_axis=delay_axis+center

    if zero_padd:
        zero_length=int(length)/2 - len(correlation)/2

        if zero_length > 1:
            zeros_before=scipy.zeros(zero_length-1)
            axis_before=scipy.arange(delay_axis[0]-zero_length+1, delay_axis[0])
        else:
            zeros_before=[]
            axis_before=[]

        if zero_length > 0:
            zeros_after=scipy.zeros(zero_length)
            axis_after=scipy.arange(delay_axis[-1]+1,delay_axis[-1]+zero_length+1)
        else:
            zeros_after=[]
            axis_after=[]

        correlation=scipy.concatenate((zeros_before,correlation,zeros_after))
        delay_axis=scipy.concatenate((axis_before,delay_axis,axis_after))
        #check lengths before on zero's and axis
        #print "length padding before (zeros, axis):", len(zeros_before), len(axis_before)
        #print "length padding after (zeros, axis):", len(zeros_after), len(axis_after)
        #print "length padded signals (signal, axis):", len(correlation), len(delay_axis)

    return delay_axis, correlation



def correlate_circular(signal1, signal2, time_domain=False):
    """
    Circular correlation, from standard utility functions library.
    This function adds a delay_axis to the output for easy comparison with the
    linear correlation signals.

    signal1,2 -- signals to correlate.
    time_domain -- use true time domain method.

    returns: delay_axis, correlation_signal
        delay_axis -- signal delay of signal2 with regard to signal1. If
            positive then signal1 is delayed with respec to signal2, if negative
            then signal2 is delayed.
        correlation_signal -- signal of length 2*shift+1
    """
    #correlation=correlate(signal1, signal2, cyclic=True, zero_padding=False, shift_signal=True, time_domain=time_domain)
    signal1=scipy.array(signal1)
    signal2=scipy.array(signal2)

    if time_domain:
        correlation=scipy.signal.correlate(signal1, signal2, "full")
    else:
        correlation=scipy.signal.fftconvolve(signal1, signal2[::-1], "full")

        #create cyclic signal from non-cyclic correlation...
        n1=len(signal1)
        n2=len(signal2)
        nmax=max(n1,n2)
        correlation=scipy.concatenate((scipy.zeros(nmax-n1), correlation[-n1:])) + scipy.concatenate((scipy.zeros(nmax-n2+1), correlation[:(n2-1)]))

    correlation=scipy.fftpack.fftshift(correlation)
    delay_axis=scipy.arange(-len(correlation)/2, len(correlation)/2)
    #check length of axis added, this is no off-by-one check.
    #print "length (correlation, delay_axis):",len(correlation), len(delay_axis)
    
    return delay_axis, correlation



def interpolation_function(axis, signal, smoothing_factor=3):
    """
    Interpolation with univariate spline.
    
    axis -- signal axis (array of length n)
    signal -- signal (array of length n)
    smoothing_factor -- k value of UnivariateSpline interpolation method.
    
    returns: interpolation function
    """
    return scipy.interpolate.InterpolatedUnivariateSpline(axis, signal, k=smoothing_factor)



def interpolate_axis(axis, index=None, width=3, interpolation_factor=1e5):
    """
    Interpolate a signal axis. This interpolated axis can then be used to feed
    into the interpolation function of a signal to obtain an interpolated
    signal.
    
    axis -- original axis values (array, linearly increasing)
    index -- index around which to interpolate the axis. If None, interpolate
        the full axis.
    width -- width in axis points around which to interpolate. If this width
        extends the original axis lenth, the axis is not extended. Extending an
        interpolation beyond it's original axis typically does not yield a
        sensible result.
    interpolation_factor -- amount of points (-1) to fill in between two
        original points. It's inverse times the time step of the original axis
        yields the new time step.
    """
    if index==None:
        #select the whole axis
        index_min=0
        index_max=len(axis)-1
    else:
        #select part of axis
        index_min=index-width/2
        index_max=index+width/2

        if not width%2:
            index_min+=1
        if index_min < 0:
            index_min=0
        if index_max > len(axis)-1:
            index_max=len(axis)-1

    axis_step=(axis[1]-axis[0])/interpolation_factor
    axis_min=axis[index_min]
    axis_max=axis[index_max]
    
    return scipy.arange(axis_min, axis_max+axis_step, axis_step)



def interpolate_signal(axis, interpolation_function):
    """
    Evaluate the signal function with an (interpolated) axis.
    
    axis -- array with axis values
    interpolation_function -- scipy.interpolate.InterpolatedUnivariateSpline
        function of signal which returns signal value at axis values. If axis
        is interpolated the returned signal is an interpolated signal.
    
    """
    return interpolation_function(axis)



def time_axis(axis, delta_t, signal1_t0, signal2_t0):
    """
    Create a time axis from the correlation signal axis.
    
    integers of axis are multiplied with delta_t to get time values. The
    signal1,2_t0 values are used to correct for time offsets on e.g.
    oscilloscope traces. We add signal1_t0-signal2_t0 to the time values array.
    
    axis -- (delay_)axis, typically integer indices with step size 1. This is
        supposed to be a scipy array or a single value (in which case we
        retrieve a single time value).
    delta_t -- time interval per step on the axis.
    signal1_t0 -- time shift of signal 1 used in cross correlation 
    signal2_t0 -- time shift of signal 2 used in cross correlation
    
    return: time_axis
    """
    return axis*float(delta_t)+signal1_t0-signal2_t0



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



def peak_position(axis, signal, delta_x=None, signal1_x0=None, signal2_x0=None, x_estimate=0):
    """
    Find correlation maximum nearest to the delay time estimate, perform
    interpolation of a certain kind and return answer.
    
    axis -- signal axis (scipy array) this is typically an integer axis
    signal -- signal (scipy array)
    delta_x -- if axis is an integer axis, we can recalculate it to "true" values
        to make estimation of the peak position possible in true user units.
        default (None) will not recalculate axis.
    signal1,2_x0 -- offsets of axis of signal1 and signal2 in correlation.
    x_estimate -- estimated position, if axis was recalculated, then in
        recalculated values.
    interpolation_type -- algorithm used to interpolate, depends on type of
        signal and possibly calculational speed. Valid types:
            "interpolate" -- use spline interpolation
            "quadratic" -- use quadratic equation

    returns: peak_position
    """
    #create real time axis, not only indices
    if not delta_x==None:
        alternate_axis=time_axis(axis, delta_x, signal1_x0, signal2_x0)
    else:
        alternate_axis=axis
        delta_x=axis[1]-axis[0]

    #create x0 positions if none, then choose 0
    if signal1_x0==None:
        signal1_x0=0        
    if signal2_x0==None:
        signal2_x0=0        

    #boolean array with True only at closest value to x_estimate
    index_selector=(alternate_axis-x_estimate<delta_x/2.0)*(alternate_axis-x_estimate>=-delta_x/2.0)
    index_estimate=scipy.arange(len(axis))[index_selector]
    print "estimated delay (index) on axis:", index_estimate
    print "time:", alternate_axis[index_estimate]

    max_index=nearest_maximum_index(signal, index_estimate)
    print "estimated index of maximum correlation:", max_index
    print "time:", alternate_axis[max_index]

    #select small part of correlation peak, create interpolation function,
    # interpolate and find maximum
    axis_interpolated=interpolate_axis(axis, index=max_index)
    signal_interpolated=interpolate_signal(axis_interpolated, interpolation_function(axis, signal))

    interpolation_max_index=scipy.where(signal_interpolated==signal_interpolated.max())[0][0]
    index_interpolated=axis_interpolated[interpolation_max_index]

    if not delta_x==None:
        peak_position=time_axis(index_interpolated, delta_x, signal1_x0, signal2_x0)

    print "delay (index) from interpolation:", index_interpolated
    print "delay time from interpolation:", time_axis(index_interpolated, delta_x, signal1_x0, signal2_x0)

    return -peak_position



#TODO: finish working this out in classes...
#TODO: add exception classes for each base class specified.
##
## Exceptions / Errors
##
class DelayDeterminationError(Exception):
    def __init__(self, value):
        self.value=value
    def __str__(self):
        return repr(self.value)

class DataConfigurationError(Exception):
    def __init__(self, value):
        self.value=value
    def __str__(self):
        return repr(self.value)

#TODO: update classes to adhere to the specification and API document
##
## Library classes, preferebly use these classes to work with the library.
##
class DataConfiguration(object):
    """
    Class that holds the configuration for data files loaded into Data objects.
    Loading in all data before performing the calculations can place a too high
    demand on system memory, but each file to be treated might have a different
    topology. We therefore gather all data needed to load a file into a Data
    object into this class, which can be used by e.g. GUI applications to
    summarise the properties of a data file.
    """
    @property
    def variable_defaults(self):
        """
        Return a dictionary with all class variables as keys and their default
        value as values.
        """
        return {
            #<name>:<default_value>
            "file_name":None,
            "file_type":None,
            "waveform_1":1,
            "waveform_2":2,
        }

    @property
    def variable_types(self):
        """
        Return a dictionary with allowed types for the variables.
        """
        return {
            #<name>:(<type_1>, ...)
            "file_name":(str, list),
            "file_type":(str, ),
            "waveform_1":(int, ),
            "waveform_2":(int, ),
        }

    def __init__(self, **kwargs):
        """
        Initialise the object. Raise a TypeError if an argument is of the wrong
        type. If an argument is not specified it is set to the default value.
        
        file_name -- name (or list of names) of the data file(s). Default: None.
        file_type -- type of data file, if None we auto-detect on file name
            extension. Default: None
        waveform_1 -- oscilloscope channel to use for waveform 1. Special
            channels -1 and -2 are used to indicate the first and second file in
            a list of files. Default:1
        waveform_2 -- oscilloscope channel to use for waveform 2. Special
            channels -1 and -2 are used to indicate the first and second file in
            a list of files. Default:2

        returns: object of class.
        """
        for variable_name in self.variable_types:
            #check type and set value from kwargs or raise TypeError.
            if variable_name in kwargs:
                if isinstance(kwargs[variable_name], self.variable_types[variable_name]):
                    setattr(self, variable_name, kwargs[variable_name])
                else:
                    raise TypeError("Type for %s must be one of %s"%(variable_name, self.variable_types[variable_name]))
            else:
                setattr(self, variable_name, self.variable_defaults[variable_name])

        #Check integrity
        self.check_configuration()

    def check_configuration(self):
        """
        Check if valid data is set into configuration. This checks among others:
        - if file_name points to a file.
        - if file_type is valid and file is of file_type.
        - if waveform channels are present in file.
        """
        if not isinstance(self.file_name, self.variable_types["file_name"]):
            raise TypeError("file_name must be string or list of strings")
        if isinstance(self.file_name, list) and not len(file_names) == 2:
            raise ValueError("list of file names must hold 2 file names only.")
        
        #Don't change self.file_name
        if isinstance(self.file_name, str):
            file_name=[self.file_name]
        else:
            file_name=self.file_name

        #can we open the files.
        for file_n in file_name:
            try:
                data_properties=DataProperties(self)
                print data_properties
            except: 
                raise DataConfigurationError("Could not open file to read data properties")



class DataProperties(object):
    """
    Try a quick read of the data properties, without reading all the data, this
    is meant to read header information like channels, x/y ranges zeros etc.
    
    NOTE: this will need an upgrade in data storage format, v0.1 will only work
        by reading the whole file.
    """
    def __init__(self, data_configuration):
        """
        Read the properties from the file pointed to in data_configuration.
        
        data_configuration -- configuration for a certain data file.

        returns: DataProperties object
        """
        file_names=data_configuration.file_name
        file_type=data_configuration.file_type
        
        file_properties=[]
        if isinstance(file_names, list):
            for file_name in file_names:
                file_properties.append(self._split_file_name(file_name))
        elif isinstance(file_names, str):
            file_properties.append(self._split_file_name(file_names))

        self._data=None

        for data_file in file_properties:
            # determine the file_type from the split file_name
            if file_type == None:
                file_type=data_file[-1]
            if not file_type in self._file_types:
                raise ValueError("file type unknown")

            # interpret the data file
            try:
                self._data=self._file_types[file_type][1](data_file[0], file_type)
            except:
                raise RuntimeError("could not parse data from file")

    def _split_file_name(self, file_name):
        """
        Split file_name in a path and at the "."s in order to determine the
        file's suffixes.

        file_name -- file name to split up

        returns: array [<file_name>, <path>, <prefix>, [<suffixes>]]
        """
        path, base_name=os.path.split(file_name)
        prefix, suffix=os.path.splitext(base_name)

        return [file_name, path, prefix, suffix]

    #All parsers have arguments: file_name, file_format
    #parsed data comes back as a dictionary:
    # return_value={
    #     <channel_nr>:{
    #         "preamble": {<preamble_dict>}
    #       },
    #     ...,
    #     ...,
    # }
    def _dso_parser(self, file_name, file_format):
        """
        Parse data from .dso files into standard structure.
        
        file_name -- full path and name of the file to use.
        file_format -- NOT USED, this is known
        
        returns: data in standard structure
        """
        preamble=DSO.read_preamble_from_file(file_name)

        return_value={}
        for channel in preamble:
            return_value[channel]={}
            return_value["preamble"]=preamble[channel]["preamble"]

        return return_value

    def _wfm_parser(self, file_name, file_format):
        """
        Parse data from .wfm files into standard structure.

        file_name -- full path and name of the file to use.
        file_format -- NOT USED, this is known
        
        returns: data in standard structure
        """
        #print(file_name, file_format, channels)
        raise NotImplementedError("WFM files not yet implemented")

    def _bzip2_parser(self, file_name, file_format):
        """
        Parse data from a bzip2 file into standard structure. This parser uses
        a secondary parser to interpret the file structure and can do so only
        by passing of the correct file_format

        file_name -- full path and name of the file to use.
        file_format -- file format of the unzipped file. If None it is deduced
            from the file_name by stripping off the extention and interpreting
            the foregoing extention. If that is not present a ValueError will be
            raised.
        
        returns: data in standard structure
        """
        #print(file_name, file_format, channels)
        file_name_unzipped=os.path.splitext(file_name)[0]
        
        #if we have no file format or if the file format is auto_determined...
        if file_format==None or file_format in [".bz2", ".bzip2"]:
            file_format=os.path.splitext(file_name_unzipped)[1]

        return self._file_types[file_format][1](file_name_unzipped, file_format, channels)

    #File types as read only class property
    @property
    def _file_types(self):
        return {
            #file_type:[<generic_type>, <number_of_files_needed>]
            "DSO80000":["DSO80000", self._dso_parser],
            "wfm":["wfm", self._wfm_parser],
            "bzip2":["bzip2", self._bzip2_parser],
            ".dso":["DSO80000", self._dso_parser],
            ".bz2":["bzip2", self._bzip2_parser],
            ".bzip2":["bzip2", self._bzip2_parser],
            ".wfm":["wfm", self._wfm_parser],
        }

    #Data as read only file property
    @property
    def data(self):
        """
        Returns a data structure fit for correlation.
        """
        return self._data



class Data(object):
    """
    Class that holds data to use in the DelayDetermination object. This class
    can import several data formats and present them in a unified way to the
    DelayDetermination class.

    The DataConfiguration object holds:
        file_name -- (list of) file name(s) of the datafiles to read in. This
            usually is a single file with multiple data traces from an
            oscilloscope. In this case certain **kwargs are needed in addition.
            In case of two files, the delay of the second file's data with
            respect to the first file's data will be calculated. In case the
            length of the list is other than two, a ValueError will be raised
        file_type -- file type to use on import of the data. Currently the
            following file types are supported:
                DSO80000 -- file type as specified by the agilent_DSO80000_aux
                    library of T. J. Pinkert usually with extention .dso or
                    .dso.bz2.
                wfm -- .wfm files as produced by Tektronix oscilloscopes.
                None -- determine file type by file extention.
            if it is not possible to interpret the data a ValueError is raised.
        waveform_1 -- channel from oscilloscope holding waveform 1. -1 and -2
            are used to represent first and second file in a file list.
        waveform_2 -- channel from oscilloscope holding waveform 2. -1 and -2
            are used to represent first and second file in a file list.

    Data.data will present the data to the user as a dictionary with two
    waveforms. The dictionary is structured as follows:
    {
        1:{
            waveform: scipy.array([[<x_data>], [<y_data>]]),
          },
        2:{
            waveform: scipy.array([[<x_data>], [<y_data>]]),
          },
    }
    
    Data files are assumed to present x_data on an equally spaced axis for both
    waveforms. In the future other information might be added, e.g. value and
    spread of the x_increment.
    """
    def __init__(self, data_configuration):
        """
        Initialise the DelayData class.
        
        data_configuration -- DataConfiguration object.
        
        returns: DelayData object.
        """
        data_configuration.check_configuration()
        

        #add items to kwargs dict if not given when calling the function
        if not "channels" in kwargs:        
            kwargs["channels"]=None

        file_properties=[]
        if isinstance(file_names, list):
            for file_name in file_names:
                file_properties.append(self._split_file_name(file_name))
        elif isinstance(file_names, str):
            file_properties.append(self._split_file_name(file_names))

        self._data=None

        for data_file in file_properties:
            # determine the file_type from the split file_name
            if file_type == None:
                file_type=data_file[-1]
            if not file_type in self._file_types:
                raise ValueError("file type unknown")

            # interpret the data file
            try:
                self._data=self._file_types[file_type][1](data_file[0], file_type, kwargs["channels"])
            except:
                raise RuntimeError("could not parse data from file")

    def _split_file_name(self, file_name):
        """
        Split file_name in a path and at the "."s in order to determine the
        file's suffixes.

        file_name -- file name to split up

        returns: array [<file_name>, <path>, <prefix>, [<suffixes>]]
        """
        path, base_name=os.path.split(file_name)
        prefix, suffix=os.path.splitext(base_name)

        return [file_name, path, prefix, suffix]

    #All parsers have arguments: file_name, file_format, channels
    #Some arguments may not be usefull when parsing the data.
    #parsed data comes back as a dictionary:
    # return_value={
    #     1:{
    #         waveform: scipy.array([[<x_data>], [<y_data>]]),
    #       },
    #     2:{
    #         waveform: scipy.array([[<x_data>], [<y_data>]]),
    #       },
    # }
    def _dso_parser(self, file_name, file_format, channels):
        """
        Parse data from .dso files into standard structure.
        
        file_name -- full path and name of the file to use.
        channels -- tuple with two channels to use when reading in the data.
        
        returns: data in standard structure
        """
        #print(file_name, file_format, channels)
        
        file_contents=DSO.interpret_raw_waveform_data(DSO.read_waveform_from_file(file_name))

        try:        
            return_value={}
            return_value[1]={}
            return_value[2]={}
            return_value[1]["waveform"]=file_contents[channels[0]]["waveform"]
            return_value[2]["waveform"]=file_contents[channels[1]]["waveform"]
        except:
            raise ValueError("Could not read data from .dso file. Check file format and channels")

        return return_value

    def _wfm_parser(self, file_name, file_format, channels):
        """
        Parse data from .wfm files into standard structure.

        file_name -- full path and name of the file to use.
        file_format -- NOT USED, this is known
        channels -- tuple with two channels to use when reading in the data.
        
        returns: data in standard structure
        """
        #print(file_name, file_format, channels)
        raise NotImplementedError("WFM files not yet implemented")

    def _bzip2_parser(self, file_name, file_format, channels):
        """
        Parse data from a bzip2 file into standard structure. This parser uses
        a secondary parser to interpret the file structure and can do so only
        by passing of the correct file_format

        file_name -- full path and name of the file to use.
        file_format -- file format of the unzipped file. If None it is deduced
            from the file_name by stripping off the extention and interpreting
            the foregoing extention. If that is not present a ValueError will be
            raised.
        channels -- tuple with two channels to use when reading in the data.
        
        returns: data in standard structure
        """
        #print(file_name, file_format, channels)
        file_name_unzipped=os.path.splitext(file_name)[0]
        
        #if we have no file format or if the file format is auto_determined...
        if file_format==None or file_format in [".bz2", ".bzip2"]:
            file_format=os.path.splitext(file_name_unzipped)[1]

        return self._file_types[file_format][1](file_name_unzipped, file_format, channels)

    #File types as read only class property
    @property
    def _file_types(self):
        return {
            #file_type:[<generic_type>, <number_of_files_needed>]
            "DSO80000":["DSO80000", self._dso_parser],
            "wfm":["wfm", self._wfm_parser],
            "bzip2":["bzip2", self._bzip2_parser],
            ".dso":["DSO80000", self._dso_parser],
            ".bz2":["bzip2", self._bzip2_parser],
            ".bzip2":["bzip2", self._bzip2_parser],
            ".wfm":["wfm", self._wfm_parser],
        }

    #Data as read only file property
    @property
    def data(self):
        """
        Returns a data structure fit for correlation.
        """
        return self._data



class DelayDeterminationConfiguration(object):
    """
    Class that hold the configuration for the determination of delays. An object
    of this class can be given to a DelayDetermination object together with a
    list of DataConfiguration objects holding information about the recordings
    for which the delay needs to be determined, with the parameters as defined
    in this class.
    
    This class defines the following parameters for the DelayDetermination:

    algorithm -- correlation algorithm.
    overlap_n_min -- correlate data with a minimum overlap of n data points.
        This ensures enough data for a good correlation, but long lengths may
        limit the maximum delay for which a correlation can be performed when
        linear correlation algorithms are used. 
    overlap_n_max -- correlate data with a maximum overlap of n data points.
        This value limits the overlap and can thus speed up the correlation time
        for linear algorithms. If overlap_n_min=>overlap_n_max we will set a
        fixed overlap to the value of overlap_n_min.
    delay_values -- list of delay values (in x_axis units) around which to
        correlate with a certain delay_span. These values are not used when FFT
        based correlations are performed.
    delay_span -- span (in x_axis units) to use for correlation around
        delay_values. Correlation is done from delay_value-delay_span/2 to
        delay_value+delay_span/2. This value is not used when FFT based
        correlations are performed.
    """
    @property
    def variable_defaults(self):
        """
        Return a dictionary with all class variables as keys and their default
        value as values.
        """
        return {
            #<name>:<default_value>
            "algorithm":analysis_methods[0],
            "overlap_n_min":None,
            "overlap_n_max":None,
            "delay_values":None,
            "delay_span":None,
        }

    @property
    def variable_types(self):
        """
        Return a dictionary with allowed types for the variables.
        """
        return {
            #<name>:[<type_1>, ...]
            "algorithm":[str],
            "overlap_n_min":[int, float],
            "overlap_n_max":[int, float],
            "delay_values":[int, float],
            "delay_span":[int, float],
        }

    def __init__(self, **kwargs):
        """
        Set up the DelayConfiguration class. See class description for a more
        extensive explanation of the arguments that can be given.
        
        algorithm -- correlation algorithm.
        overlap_n_min -- correlate data with a minimum overlap of n data points.
        overlap_n_max -- correlate data with a maximum overlap of n data points.
        delay_values -- list of delay values.
        delay_span -- span to use for correlation around delay_values.
        
        returns: DelayConfiguration object.
        """
        for variable_name in self.variable_types:
            #check type and set value from kwargs or raise TypeError.
            if variable_name in kwargs:
                if type(kwargs[variable_name]) in self.variable_types[variable_name]:
                    setattr(self, variable_name, kwargs[variable_name])
                else:
                    raise TypeError("Type for %s must be one of %s"%(variable_name, self.variable_types[variable_name]))
            else:
                setattr(self, variable_name, self.variable_defaults[variable_name])

    def check_configuration(self):
        """
        Check if valid data is set into configuration. This checks among others:
        - if algorithm exists.
        - if overlap_n_min and overlap_n_max make sense.
        - if delay_values make sense.
        - if delay_span makes sense.
        """
        raise NotImplementedError("check_configuration not implemented")
            


class DelayDetermination(object):
    """
    Class that is used to determine the delay of a Data object with parameters
    specified in a DelayConfiguration object.
    
    Userland can modify the configuration but must then also call
    Delay.calculate() in order to keep data in the object consistent.
    
    After the calculations various results of the calculation are present in
    this class as a dictionary. This dictionary holds the following data per
    DataConfiguration object in the input list.
        data_configuration -- DataConfiguration object.
        waveforms -- list of waveform data (scipy.array([[x_data],[y_data]]) for
            each delay_value in the DelayConfiguration.
        extrema -- list of extreme values [x, y] for each minimum and maximum
            present in the output data.
    """
    def __init__(self, configuration, data_configurations, calculate=True):
        """
        Initialise the DelayDetermination class.
        
        configuration -- DelayConfiguration object determining the settings to
            use in the delay determination on the files in the data_list
        data_configurations -- list of DataConfiguration objects holding the
            configuration to create the Data objects to process according to the
            DelayConfiguration settings.
        calculate -- if True (default) immediately start calculating results, if
            False, the user has to call Delay.calculate() in order to start the
            calculation.

        returns: Delay object.
        """
        if not isinstance(configuration, DelayConfiguration):
            raise TypeError("configuration must be of type <delay_determination.DelayConfiguration>")
        else:
            self.configuration=copy.deepcopy(configuration)

        if not isinstance(data_configurations, list):
            raise TypeError("data_configurations must be of type <list>")

        # create initial dictionary with results and store the
        # DataConfigurations in it.
        self._results={}
        for i in range(len(data_configurations)):
            self._results[i]={}
            if isinstance(data_configurations[i], DataConfiguration):
                self._results[i]["data_configuration"]=copy.deepcopy(data_configurations[i])
            else:
                raise TypeError("configuration must be of type <delay_determination.DataConfiguration>")

        if calculate:
            self.calculate()

    def calculate(self):
        """
        Perform the delay calculation according to the configuration. Usually
        this function is called upon Delay object creation, but in some cases
        the user might want to wait until some later point and call this
        function from another point in userland.

        if delay_values is None, we calculate the full autocorrelation according
        to overlap_n_min, overlap_n_max. If delay_span is specified the output
        data is restricted to the given delay_span.
        """
        data_keys=self._results.keys()
        data_keys.sort()

        for key in data_keys:
            data=Data(self._results[key]["data_configuration"])

    @property
    def results(self):
        """
        Returns the dictionary with results, after haveing added the
        configuration dictionary with the key "configuration".
        
        returns: modified self._results dictionary
        """
        #make deepcopies, realy separate output from object data.
        return_value=copy.deepcopy(self._results)
        return_value["configuration"]=copy.deepcopy(self.configuration)
        
        return return_value
