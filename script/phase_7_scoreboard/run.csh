#!/bin/csh
source /CMC/scripts/mentor.questasim.2019.2.csh
if ($#argv == 0) then
    vsim -c -do script/phase_7_scoreboard/run_sanity_check.do
else if ($1 == 1) then
    vsim -c -do script/phase_7_scoreboard/run_sanity_check.do
else if ($1 == 2) then
    vsim -c -do script/phase_7_scoreboard/run_port_assignment.do
else if ($1 == 3) then
    vsim -c -do script/phase_7_scoreboard/run_overlapping_addresses.do
else
    vsim -c -do script/phase_7_scoreboard/run_sanity_check.do 1
endif
