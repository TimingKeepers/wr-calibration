#!/usr/bin/python

"""
  Routines, specific for the WRT-SFPPT015SC tunable laser module

"""

############################################################################
def conv_ch(itu_channel):
  """
  converts the ITU channel number to the channel number used by the
  WRT-SFPPT015SC Tunable module
  """
  return(int(itu_channel*2-21))

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

###############################################
def fill_channel_wavelength_dict():

  c = 299792458	 # speed of light 
  # WRT-SFPPT015SC channel, ITU Channel, ITU Frequency, ITU Wavelength
  ch_wl = {}
  for ch in range(1,103):	# selectable channel numbers WRT-SFPPT015SC (1..102)
    ITU_ch = float((ch + 21)/2.0)
    ITU_freq = (190 + (ITU_ch/10))*1e12
    ITU_wl = (c/ITU_freq)
    ch_wl_item = [ITU_ch,ITU_freq,ITU_wl]
    ch_wl[ch]=ch_wl_item

  return (ch_wl)

