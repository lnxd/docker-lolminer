# lolMiner Docker Container for Unraid

lolMiner binary source for this container is currently version 1.24a from [Github](https://github.com/lolminerDevTeam/lolminer/).

It contains version 20.20 of the AMDGPU Pro Drivers direct from [AMD](https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-20)



## Non Unraid Users
Here is an example `docker run` command, please ensure you have your GPU fans manually controlled to prevent overheating, or add `--privileged` to the command and use lolminer arguments accordingly.
```
docker run -d --name='lolminer' --net='bridge' -e TZ="Australia/Sydney" --device='/dev/dri:/dev/dri' 'lnxd/lolminer' ./lolminer -pool asia1.ethermine.org:4444 -wal 0xe037C6245910EbBbA720514835d31B385D76927f.x
```



##  Unraid Users
This container was written to be run on Unraid, so the following instructions apply to that. Please ensure that you know what you're doing before setting this up, as excessively high temperatures are BAD for computers and could damage your hardware / eventuate in data loss.

### Instructions:

1. Ensure you are on Unraid 6.9.0 or later; otherwise, amdgpu drivers are not included.
2. Ensure your GPU is not bound to vfio at boot, on 6.9.0, and later you can do this by visiting `Tools` > `System Devices` and ensuring your card (and its audio device) is not checked. Also, ensure your GPU is not stubbed by checking its ID on the above page and cross-referencing with `pci-stub.ids=` (by visiting `Main` > `Flash`). If you made changes in this step, you need to safely shut down the array and reboot before proceeding.
3. Install ich777's `Radeon TOP` via CA (Easiest way to load AMD GPU drivers on Unraid host).
4. Install lnxd's `lolminer-AMD` via CA.
5. Make sure you update the pool & wallet address; otherwise, your 'rig' will generate income for me instead.
6. If you want to enable lolminer to control the fans / undervolt / overclock: leave privileged mode enabled for the container.
7. Run it, check the logs constantly for the first 20 mins or so to ensure it is working and your card doesn't overheat. If something looks incorrect, stop the container and double-check your config. I like to try and keep my 5500XT around 75c and my RX 580 around 55c (modded bios).
8. (Optional) If you want to monitor your miner from a web app rather than a representation of the logs, check out PhoenixStats in CA.

**Warning:** If you don't leave privileged mode enabled for the container, your GPU's default fan curve will be used, which is usually optimised for gaming. Make sure you have `Dynamix System Autofan` installed to prevent overheating (can be done via CA). I recommend enabling it and setting the high temperature to 25c at most. Low I set to 20c. I could not get the PWM min speed, but this didn't affect anything for me during testing.

If you notice any bugs, feel free to open an Issue or a pull request. For support, I'm best reached via the [support thread](https://forums.unraid.net/topic/104589-support-lnxd-lolminer-amd/) on the Unraid Community Forums.


​
##  Docker Hub Tags:
Different AMD GPUs require different driver versions, and those different driver versions often don't work very well on Operating Systems that they weren't built for. For this reason, I've gone ahead and changed to using multiple tags, each tag has it's own GPU compatibility table further down.

* `lnxd/lolminer:latest` (Same as `latest-20.20` as this is the most compatible with current cards)
* `lnxd/lolminer:latest-20.45` (Only for RX6800 and RX6900)
* `lnxd/lolminer:latest-20.20`
* `lnxd/lolminer:latest-18.20`


​
## Compatibility:
These lists are very hopeful, they're sourced from the AMD website, and there's a real possibility your GPU might not work with a tag it's supposed to. Please do not make purchasing decisions based on these tables.
 
Also keep in mind you are unlikely to be able to profit from mining with a card with less than or equal to 4GB VRAM available to it. If you try this container you will probably get a DAG generation error or an extremely low hash rate.

### GPUs possibly compatible with **lnxd/lolminer:latest-20.45**:
* AMD Radeon™ RX 6900/6800 Series Graphics


### GPUs possibly compatible with **lnxd/lolminer:latest-20.20**:
* AMD Radeon™ RX 5700/5600/5500 Series Graphics.
  - ```Confirmed working: 5500XT by lnxd```
* AMD Radeon™ Pro W-series
* AMD Radeon™ VII Series Graphics
* AMD Radeon™ Pro W 5700/5500 Series Graphics
* AMD Radeon™ RX Vega Series Graphics
* AMD Radeon™ Pro WX-series
* AMD Radeon™ Vega Frontier Edition
* AMD Radeon™ Pro WX 9100
* AMD Radeon™ RX 550/560/570/580/590 Series Graphics
  - ```Confirmed working: RX580 8GB by lnxd, RX580 8GB by SPOautos, RX570 8GB by NixonInnes```
* AMD Radeon™ Pro WX 8200
* AMD Radeon™ RX 460/470/480 Graphics
  - ```Confirmed working: RX480 8GB by ich777```
* AMD FirePro™ W9100
* AMD Radeon™ Pro Duo
* AMD FirePro™ W8100
* AMD Radeon™ R9 Fury/Fury X/Nano Graphics
* AMD FirePro™ W7100
* AMD Radeon™ R9 380/380X/390/390X Graphics
* AMD FirePro™ W5100
* AMD Radeon™ R9 285/290/290X Graphics
* AMD FirePro™ W4300
* AMD Radeon™ R9 360 Graphics


### GPUs possibly compatible with **lnxd/lolminer:latest-18.20**:
* Radeon™ RX Vega Series Graphics
* AMD Radeon™ Pro WX-series
* Radeon™ Vega Frontier Edition
* AMD FirePro™ W9100
* Radeon™ RX 550/560/570/580 Series Graphics
  - ```Confirmed working: RX580 8GB by lnxd, RX580 8GB by SPOautos, RX570 8GB by NixonInnes```
* AMD FirePro™ W8100
* AMD Radeon™ RX 460/470/480 Graphics
  - ```Confirmed working: RX480 8GB by ich777```
* AMD FirePro™ W7100
* AMD Radeon™ Pro Duo
* AMD FirePro™ W5100
* AMD Radeon™ R9 Fury/Fury X/Nano Graphics
* AMD FirePro™ W4300
* AMD Radeon™ R9 380/380X/390/390X Graphics
* AMD FirePro™ W4100
* AMD Radeon™ R9 285/290/290X Graphics
* AMD FirePro™ W2100
* AMD Radeon™ R7 240/250/250X/260/260X/350
* AMD FirePro™ W600
* AMD Radeon™ HD7700/7800/8500/8600
* AMD FirePro™ S-Series
* AMD Radeon™ R9 360 Graphics
* AMD Radeon™ Pro WX 9100
* AMD Radeon™ R5 340


​
## FAQ:
#### **Q:** Where can I find more arguments to use in additional?
**A:** The output of ./lolMiner `--help` for 1.24a is available below.


#### **Q:** I have multiple GPUs, can I use this container?
**A:** Yes! If you have multiple GPUs, and they are all listed in one table, go for that version. If you have multiple GPUs and they are on different tables, you can have multiple containers on different tags and use the `-gpus` flag in lolminer to set which container uses which GPU.


#### **Q:** What are the mining fees?
**A:** There are none from me. The developer of lolminer charges 0.65%. This means that every 90 minutes the miner will mine for them for 35 seconds. The default pool, Ethermine, has a 1% fee and shares the transaction fees from the block. You can change to mine on any pool.


#### **Q:** Why is my card still heating up if I've set a target temperature (`-tt`)?
**A:** lolminer seems to still rely on the default fan curve, so unless you've optimised that for mining it's probably best to set a fixed fan speed by setting the `-tt` value to a negative, such as `-70` (fixed at 70% fan speed while lolminer is running). The lower you can safely set this, the slightly less power your rig will use and the less the affect mining will have on your GPU fan's lifespan.


#### **Q:** Why am I getting such a low hash rate (eg. 2.5MH/s)?
**A:** Could be a lot of things, from the card having a very low power limit set, to trying to use a fake card. But the most likely issue is that you're using a card without enough VRAM. 4gb cards are not really suitable for Ethereum mining, please see the Compatibility section above.


#### **Q:** Is there an easier way to see the data from the Unraid WebUI Dashboard?
**A:** Yes! Users who have ich777's `Radeon TOP` installed can also install b3rs3rk's `GPU Statistics` plugin from CA. This will allow you to see things like the GPU temperature, load, fan RPM of one GPU at a time. Please note that it is expected for memory usage to be only around 4gb, as this is the current DAG limit.


#### **Q:** Does this also work with NVIDIA cards?
**A:** Shh! Yes it does. I don't know enough about the NVIDIA drivers in Ubuntu yet to list a compatibility chart, but thanks to some testing by ich777 I have confirmation that **lnxd/lolminer:latest-20.45**, **lnxd/lolminer:latest-20.20** and **lnxd/lolminer:latest** work with a GTX1060 6GB. The same limitations with regards to VRAM apply as AMD cards, 4gb cards won't work.
​

​
## Additional lolminer Arguments
```
+---------------------------------------------------------+
| _ _ __ __ _ _ ____ _ _ |
| | | ___ | | \/ (_)_ __ ___ _ __ / | |___ \| || | |
| | |/ _ \| | |\/| | | '_ \ / _ \ '__| | | __) | || |_ |
| | | (_) | | | | | | | | | __/ | | |_ / __/|__ _| |
| |_|\___/|_|_| |_|_|_| |_|\___|_| |_(_)_____| |_| |
| |
| This software is for mining |
| Ethash, Etchash |
| Equihash 144/5, 192/7, 210/9 |
| BeamHash I, II, III |
| ZelHash (EquihashR 125/4/0) |
| Cuck(ar)oo 29 |
| Cuckaroo 30 CTX |
| Cuckatoo 31/32 |
| |
| |
| Made by Lolliedieb, February 2021 |
+---------------------------------------------------------+
Allowed options:

General:
-h [ --help ] Help screen
--config arg (=./lolMiner.cfg) Config file
--json arg (=./user_config.json) Config file in Json format
--profile arg Profile to load from Json file
--nocolor [=arg(=on)] (=off) Disable colors in output
--basecolor [=arg(=on)] (=off) Use 16 colors scheme for non-rgb
terminals
--list-coins List all supported coin profiles
--list-algos List all supported algorithms
--list-devices List all supported & detected GPUs in
your system
-v [ --version ] Print lolMiner version number


Mining:
-c [ --coin ] arg The coin to mine
-a [ --algo ] arg The algorithm to mine.
This is an alternative to --coin.
-p [ --pool ] arg Mining pool to mine on
Format: <pool>:<port>
-u [ --user ] arg Wallet or pool user account to mine on
--pass arg Pool user account password (Optional)
--tls arg Toggle TLS ("on" / "off")
--devices arg The devices to mine on
Values: ALL / AMD / NVIDIA or a comma
separated list of indexces.
--devicesbypcie [=arg(=on)] (=off) Interpret --devices as list of PCIE
BUS:SLOT pair
--pers arg The personalization string.
Required when using --algo for Equihash
algorithms
--keepfree arg (=5) Set the number of MBytes of GPU memory
that should be left free by the miner.
--benchmark arg The algorithm to benchmark

Managing Options:
--watchdog arg (=script) Specify which action to take when a
card is detected to be crashed.
"off": Continue working on remaining
cards. No action.
"exit": Exit the miner with exit code
42 to ask for a restart. Recommended
for Nvidia cards.
"script": Call an external script.
Default and recommended for AMD cards.
--watchdogscript arg Specify which script to be executed
when a hung GPU is detected
--singlethread [=arg(=-1)] (=-2) Enable single mining thread mode for
all GPUs (-1) or for a specific GPU id.
--tstart arg (=0) Minimal temperature for a GPU to start
in degree C. If set to 0 disables
restart below a fixed temperature.
--tstop arg (=0) Temperature to pause or stop a GPU from
mining in degree C. If set to 0
disables stop above a fixed
temperature.
--tmode arg (=edge) Mode for temperature management.
Use "edge" (default), "junction" or
"memory" to set the mode for
temperature management.

Statistics:
--apiport arg (=0) The port the API will use
--apihost arg (=0.0.0.0) The host binding the API will use
--longstats arg (=150) Long statistics interval
--shortstats arg (=30) Short statistics interval
--digits arg Number of digits in hash speed after
delimiter
--timeprint [=arg(=on)] (=off) Enables time stamp on short statistics
("on" / "off")
--compactaccept [=arg(=on)] (=off) Enables compact accept notification
--log [=arg(=on)] Enables printing a log file ("on" /
"off")
--logfile arg Path to a custom log file location

Ethash Options:
--ethstratum arg (=ETHPROXY) Ethash stratum mode. Available options:
ETHV1: EthereumStratum/1.0.0 (Nicehash)
ETHPROXY: Ethereum Proxy
--worker arg (=eth1.0) Separate worker name for Ethereum Proxy
stratum mode.
--4g-alloc-size arg (=0) Sets the DAG size (in MByte) the miner
is allowed to use on 4G cards. Can be a
comma separated list of values for each
card. Suggested values:
Linux: 4080 Windows: 4024
--zombie-tune arg (=auto) Sets the Zomie tune mode (auto or 0-3)
for Polaris GPUs. Can be a comma
separated list of values to set for
each card individually.
--dagdelay [=arg(=0)] (=-1) Delay between creating the DAG buffers
for the GPUs. Negative values enable
parallel generation (default).
--enablezilcache [=arg(=1)] (=0) Allows 8G+ GPUs to store the DAG for
mining Zilliqa. It will generated only
once and offers a faster switching.
--benchepoch arg (=350) The DAG epoch the denchmark mode will
use

Ethash Expert Options:
--workmulti arg (=180) Modifys the amount of Ethash work a GPU
does per batch.
--rebuild-defect arg (=3) Triggers a DAG rebuild if a card
produced <param> defect shares. Default
is 3, use 0 to deactivate the rebuild.
--enable-ecip1099 [=arg(=on)] (=off) Enable reduced DAG size for mining ETC
from block 11.730.000 and higher.
--disableLinux56fix [=arg(=on)] (=off)
Disables the startup workaround for
Polaris GPUs on Linux kernel 5.6.
--win4galloc [=arg(=1)] (=0) Enables (1) / Disables (0) experimental
4G DAG allocation mode on Windows.

Algorith Split Options:
--dualmode arg (=none) Dual mode used. Allowed options:
none, zil, etc
--dualstratum arg Stratum connection and wallet for the
extra connection. Format:
<wallet>.<worker>@<pool>:<port>
--dualdevices arg Split rule for etc and beam split mode.
Use a comma separated list of indexes
or "4G" (default).
  ```