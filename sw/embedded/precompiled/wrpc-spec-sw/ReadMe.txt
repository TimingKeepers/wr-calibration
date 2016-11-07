These files are copied from the "~/spec_cal/wrpc-spec-sw" directory on UNSTRUD (Ubuntu Linux machine).
The wrpc software can onlu be compiled on Ubunu and it refuses to compile fromUbuntu using Beuk as
a network drive. Hench copying is needed unfortunaltely.

build:
wrpc-sw detached branch 0e8b222
ppsi detached branch da4979d

make menuconfig => UNCHECK "Use SDB to manage storage" so use legacy eeprom code


This build ought to work but fails...:
git checkout proposed_master
git submodule init
git submodule update
wrpc-sw proposed_master 70b42d0
ppsi HEAD detached at b8ebe5f

make menuconfig => UNCHECK "Use SDB to manage storage" so use legacy eeprom code


