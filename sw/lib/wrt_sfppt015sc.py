#!/usr/bin/python

"""
  Routines, specific for the WRT-SFPPT015SC tunable laser module

"""

############################################################################
def sfp_channel(itu_channel):
  """
  converts the ITU channel number to the channel number used by the
  WRT-SFPPT015SC Tunable module
  """
  return(int(itu_channel*2-21))

############################################################################
def get_parameters():
  """
  constant parameters for this particular tunable SFP module
  """
  params = {}
  params["vendor_id"] = "WRT-SFPPT015SC"
  params["itu_channel_start"] = 11
  params["itu_channel_stop"] = 61.5
  params["itu_channel_spacing"] = 0.5

  return (params)

