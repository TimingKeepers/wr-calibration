#!/usr/bin/python

"""
Pattern generator routines for emulated IEEE 802.3 physical layer signals

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
"""

import scipy

############################################################################
def scipy_array_from_pattern(pattern, output_length, bit_rate = 1.25e+009, sample_period = 5.00e-011,val_one = 1.0, val_zero = -1.0, val_pad = 0.0 ):
  """
    This function returns an x, y scipy array (<type 'numpy.ndarray'>) that corresponds to
    a NRZ signal (+1.0,-1.0) with a c
ertain pattern and bit_rate as it would have been sampled
    by an oscilloscope with a certain sample_period (i.e. HORIZ_INTERVAL in LeCroy
    nomenclature)

    pattern       -- <type 'str'> bit pattern ('0' and '1') to be converted to a signal
    output_length -- the size of the output array in number of samples
    bit_rate      -- default 1.25 Gbps
    sample_period -- default 50 ps (which corresponds to 20 Gsps)
    val_one       -- the float value to be used if the pattern is '1', default +1.0
    val_zero      -- the float value to be used if the pattern is '0', default -1.0
    val_pad       -- the float value to be used for padding
        
    returns: <type 'numpy.ndarray'> array([[x1,x2,x3,...,xn],[y1,y2,y3,...,yn]])
  """
  samples_per_bit = int(1 / (bit_rate * sample_period))
  num_of_samples = len(pattern) * samples_per_bit

  #print("num_of_samples", num_of_samples)
  #print("output_length", output_length)

  if num_of_samples > output_length:
    print("### WARNING! Number of samples needed is bigger than the array output length specified")
    Exception("Number of samples needed is bigger than the array output length specified")
    return

  if samples_per_bit < 4:
    print("### WARNING! Number of samples per bit is", samples_per_bit, ". Try to increase the sample rate of the oscilloscope")

  half_samples = int(num_of_samples/2)
  half_output  = int(output_length/2)

  #print("half samples", half_samples,"half_outout", half_output)

  y_lst = []

  for sample in range(-half_output,-half_samples):
    #print("pad before", sample)
    y_lst.append(scipy.float64(val_pad))

  for sample in range(-half_samples,+half_samples):
    current_bit = int ((sample + num_of_samples/2) / samples_per_bit)
    #print("pattern", sample)
    if pattern[current_bit] == '0':
      y_lst.append(scipy.float64(val_zero))
    else:
      y_lst.append(scipy.float64(val_one))

  for sample in range(+half_samples,+half_output):
    #print("pad after", sample)
    y_lst.append(scipy.float64(val_pad))

#  x_data = scipy.arange(-num_of_samples*sample_period/2, +num_of_samples*sample_period/2, sample_period, dtype=scipy.float64)
  x_data = scipy.arange(-half_output * sample_period, +half_output * sample_period, sample_period, dtype=scipy.float64)

  y_data=scipy.array(y_lst)
  waveform_pattern = scipy.array([x_data,y_data])
  
  return waveform_pattern

