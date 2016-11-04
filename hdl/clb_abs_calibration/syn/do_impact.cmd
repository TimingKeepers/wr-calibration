rem impact.cmd,    30-Jun-2011.
@prompt $$$s

set DesName=fpga

set LogName=%DesName%-impact.log

impact -batch _.imp
move /Y _impactbatch.log %LogName%
