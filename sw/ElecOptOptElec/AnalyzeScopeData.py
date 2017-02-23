import sys
import delay_determination as dd
import vxi11
import scipy
import numpy
import matplotlib.pyplot as plt

# Add parent directory (containing 'lib') to the module search path
sys.path.insert(0,'..')

import lib.LeCroy8254 as DSO
import lib.delay_determination as dd

wf_data = DSO.file_to_waveform("/local/home/rabbit/eooe/data/170220_17_09_32_LeCroy8254_bin")
samples = DSO.check_waveforms(wf_data)
x1 = wf_data[1]["waveform"][0][:samples]
y1 = wf_data[1]["waveform"][1][:samples]
x3 = wf_data[3]["waveform"][0][:samples]
y3 = wf_data[3]["waveform"][1][:samples]

plt.figure("waveform")
plt.plot(x1,y1)
plt.plot(x3,y3)
plt.draw()
plt.show()

plt.figure("correlation")
cx,cy=dd.correlate_circular(y1, y3)
plt.plot(cx,cy)

plt.draw()
plt.show()

sample_period = 50e-12
delay = sample_period * dd.peak_position(cx,cy,x_estimate = -20)
print(delay)
