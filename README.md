# cycloneV-serial-flasher
A shell implementation of a bypass system to flash the FPGA on an Altera DE1-SoC running linux through its ttyUSB interface.

## Dependencies
### On the source:
- screen: if you wanna monitor the upload process, as it can take quite a long time.
Know that it will cancel the last session of screen in the hope of getting access to the tty,
this was not tested without screen installed.  
- echo  
- printf  
- cat  
- awk  
- base64  
- md5sum  
- dmesg  
- grep  
- gzip (with gunzip)  

### On the target:
- sh  
- echo  
- md5sum  
- awk  
- printf  
- gzip (with gunzip)  
- base64  
- dd  
- A reliable way to flash the FPGA  

## Use
`./flashfpga.sh <raw binary file>`

## Use Case
In case your version of quartus does not detect the USB-Blaster interface,
and you need a way to flash the FPGA without removing the SD-card from the SoC,
this is the right tool for you!

### BackGround
In my case, I needed for a project to use quartus version 17 on my machine,
I already had version 19 working on my machine but some custom IPs could not be upgraded between the 2 versions.
I did however have access to documentation on how the SoC could flash the FPGA on boot on a specific version of linux
(see http://csys.yonsei.ac.kr/lect/embed/Linux-DE1-SoC.pdf 2.2 & page 32 for more info).

## Notes
With some tweaking you can actually send any file to the target. See it as a "hacky" cp over ttyUSB.  
This is a very hacky implementation but it does the job for my use-case.
Here is a link to the related StackExchange thread:
https://unix.stackexchange.com/questions/548205/copy-a-file-over-serial-connection/
