#!/usr/bin/python

"""
  Routines, that convert itu channel to wavelength and frequency

"""

############################################################################
def itu_2_frequency(itu_channel):
  """
  converts the ITU channel number to frequency
  """
  c = 299792458	 # speed of light 
  itu_frequency = (190 + (itu_channel/10))*1e12

  return (itu_frequency)

############################################################################
def itu_2_wavelength(itu_channel):
  """
  converts the ITU channel number to wavelength
  """
  c = 299792458	 # speed of light 
  itu_wavelength = (c/itu_2_frequency(itu_channel))

  return (itu_wavelength)
