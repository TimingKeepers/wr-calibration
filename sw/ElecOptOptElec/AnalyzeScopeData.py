#!/usr/bin/python

"""
AnalyzeScopeData 

-------------------------------------------------------------------------------
Copyright (C) 2017 Peter Jansweijer, Henk Peek

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
  AnalyzeScopeData.py <waveform_file>
  AnalyzeScopeData.py -h | --help

  <waveform_file>     <type 'str'> file name that contains the DSO traces

Options:
  -h --help            Show this screen.
  --version            Show version.

"""

import os
import sys
import vxi11
import scipy
import numpy
import matplotlib.pyplot as plt

# Add parent directory (containing 'lib') to the module search path
lib_path = (os.path.dirname(os.path.abspath(__file__)))
lib_path = os.path.join(lib_path,"..")
sys.path.insert(0,lib_path)

from lib.docopt import docopt
import lib.LeCroy8254 as DSO
import lib.delay_determination as dd


############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Analyze Scope Date version 01')

  wf_file = sys.argv[1]
  wf_data = DSO.file_to_waveform(wf_file)

  if len(wf_data) <= 1:
    print ("No, or only one oscilloscope trace in the data file")
    print ("Correlation is not possible!")
    sys.exit()
  else:
    print ("Oscilloscope data file contains "+str(len(wf_data))+" traces")

  # Take the first two available traces from the data
  trace1 = sorted(wf_data.keys())[0]
  trace2 = sorted(wf_data.keys())[1]
  print ("Correlate channels "+str(trace1)+" and "+str(trace2))

  samples = DSO.check_waveforms(wf_data)
  sample_period = wf_data[trace1]["preamble"]["x_increment"]

  # Make sure the buffer holds an even number of samples
  a , b = divmod(samples,2)
  samples = 2 * a
  # The correlation reference point is halfway the array of samples
  correlation_zero = int(samples/2)

  x1 = wf_data[trace1]["waveform"][0][:samples]
  y1 = wf_data[trace1]["waveform"][1][:samples]
  x2 = wf_data[trace2]["waveform"][0][:samples]
  y2 = wf_data[trace2]["waveform"][1][:samples]

  wf_fig = plt.figure("waveform")
  ax = wf_fig.add_subplot(111)
  ax.set_xlabel('time')
  ax.set_ylabel('volatge ch:'+str(trace1)+" and "+str(trace2))
  ax.plot(x1,y1)
  ax.plot(x2,y2)
  plt.draw()

  cx,cy=dd.correlate_circular(y1, y2)

  cor_ref = int(samples/2)
  estimated_max = numpy.argmax(cy) - correlation_zero
  
  delay = sample_period * dd.peak_position(cx,cy,x_estimate = estimated_max)
  print("delay, based on estimated max at sample "+str(estimated_max)+" is:"+str(delay))

  cor_fig = plt.figure("correlation")
  ax = cor_fig.add_subplot(111)
  ax.text(0.01,0.95,'correlation of ch: '+str(trace1)+' and '+str(trace2), transform=ax.transAxes)
  ax.text(0.01,0.90,'delay at estimated max {0:d} = {1:.6g}'.format(estimated_max,delay), transform=ax.transAxes)
  ax.set_xlabel('sample')
  ax.set_ylabel('correlation')
  ax.plot(cx,cy)
  plt.draw()

  plt.show()



  sys.exit()




