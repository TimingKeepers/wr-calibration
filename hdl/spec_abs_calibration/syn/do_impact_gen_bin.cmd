rem impact.cmd,    27-Oct-2014.
@prompt $$$s

set DesName=spec_top

set LogName=%DesName%-impact_gen_bin.log

impact -batch _gen_bin.imp
move /Y _impactbatch.log %LogName%
