  
## Changes
| what      |            | ver  |
| ------------- |:-------------:| -----:|
| updated iw version     | [iw](https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/) 		| 4.14  |
| updated libnl version  | [libnl](https://github.com/thom311/libnl/releases/)   			| 3.4.0 |
| added   elf-cleaner 	 | [elf-cleaner](https://github.com/cloned2k16/elf-cleaner.git "Elf Cleaner")   | 0.0.1 |



[elf-cleaner](https://github.com/cloned2k16/elf-cleaner.git "Elf Cleaner")
( so you'll get clean executables directly ) 

easier version handling ...  
you just need to drop the 2 required URL to the sources and it should work  
assuming they both are .tar* files   
  
  
  
#### Compile iw (the wireless LAN utility) for android.


Usage:  
	./make_all.sh  
	  , it will fetch and compile libnl and iw.   

 
Assumes the android SDK in /usr/opt/android-ndk-r10e-linux-x86_64/.   
Output binary will be iw-4.14/iw,   
 copy it somewhere to your mobile phone.  
   
Tested on a Samsung Galaxy S4 Mini, running Cyanogenmod 12.1 (Android 5.0).

	root@serranoltexx:/ # /data/_bin/iw --version
	iw version 4.1
	root@serranoltexx:/ # /data/_bin/iw dev
	phy#0
		Interface p2p0
			ifindex 24
			type managed
		Interface wlan0
			ifindex 23
			type managed
	root@serranoltexx:/ # /data/_bin/iw phy
	Wiphy phy0
		max # scan SSIDs: 9
		max scan IEs length: 255 bytes
		max # sched scan SSIDs: 16
		max # match sets: 16
		Retry short limit: 7
		Retry long limit: 4
		Coverage class: 0 (up to 0m)
		Device supports roaming.
		Device supports T-DLS.
		Supported Ciphers:
			* WEP40 (00-0f-ac:1)
			* WEP104 (00-0f-ac:5)
			* TKIP (00-0f-ac:2)
			* CCMP (00-0f-ac:4)
			* WPI-SMS4 (00-14-72:1)
		Available Antennas: TX 0 RX 0
		Supported interface modes:
			 * IBSS
			 * managed
			 * AP
			 * P2P-client
			 * P2P-GO
		Band 1:
			Capabilities: 0x9030
	(...)
	

