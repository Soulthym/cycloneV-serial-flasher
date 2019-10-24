#! /bin/sh
src="$1"
screen -X quit
echo "detecting interfaces"
dest="/dev/$(dmesg | grep "now attached to ttyUSB" | awk '{print$NF}' | tail -1)"
echo "connecting to /dev/$dest"
echo "compressing $src ($(du -h "$src" | awk '{print $1;}'))"
cat "$src" | gzip | base64 > rbf.64.gz
echo "compressed size: $(du -h rbf.64.gz | awk '{print $1;}')"
md5=$(md5sum "$src" | awk '{print $1}')
echo "sending the flashing script with md5 cheacksum"
printf "\necho \"[ \\\$(md5sum /home/root/default.rbf | awk '{print \\\$1}') == %s ] &&\\ 
echo 0 > /sys/class/fpga-bridge/fpga2hps/enable && echo 0 > /sys/class/fpga-bridge/hps2fpga/enable && echo 0 > /sys/class/fpga-bridge/lwhps2fpga/enable && dd if=/home/root/default.rbf of=/dev/fpga0 bs=1M
echo 1 > /sys/class/fpga-bridge/fpga2hps/enable
echo 1 > /sys/class/fpga-bridge/hps2fpga/enable
echo 1 > /sys/class/fpga-bridge/lwhps2fpga/enable\" > /home/root/prog.sh\n" \
    "$md5" \
    > "$dest"
echo "sending compressed file, this may take a long time..."
time printf " echo \"%s\" | base64 -d | gunzip > /home/root/default.rbf &&\\
/bin/sh /home/root/prog.sh
" "$(cat rbf.64.gz)" \
    > "$dest" &&\
echo "Done Flashing"
