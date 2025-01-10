vlib work
vlog -f FIFO_src_files.list -mfcu +cover
vsim -voptargs=+acc work.FIFO_top -classdebug -uvmcontrol=all -coverage
add wave /FIFO_top/fifo_if/*
add wave /FIFO_top/DUT/*
coverage save FIFO_test.ucdb -onexit
run -all
vcover report FIFO_test.ucdb -details -all -annotate -output FIFO_cvr2.txt
