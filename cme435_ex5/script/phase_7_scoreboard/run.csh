#!/bin/csh
source /CMC/scripts/mentor.questasim.2019.2.csh
set rootdir = `dirname $0`
cd rootdir
if ($#argv == 0) then
    vsim -c -do run_sanity_check.do
else if ($1 == 1) then
    vsim -c -do run_sanity_check.do
else if ($1 == 2) then
    vsim -c -do run_port_assignment.do
else if ($1 == 3) then
    vsim -c -do run_overlapping_addresses.do
else
    vsim -c -do run_sanity_check.do
endif
rm -r work
rm transcript
rm modelsim.ini
rm dumpfile.vcd
