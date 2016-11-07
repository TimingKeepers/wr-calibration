rem impact.cmd,    27-Oct-2014.
@prompt $$$s

set DesName=spec_top

set LogName=%DesName%-impact_gen_mcs.log

impact -batch _gen_mcs.imp
move /Y _impactbatch.log %LogName%
