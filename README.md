# PhoenixMiner Docker Container for Unraid

PhoenixMiner binary source for this container is currently version 5.5c from [Github](https://github.com/PhoenixMinerDevTeam/PhoenixMiner/).

It contains version 20.20 of the AMDGPU Pro Drivers direct from [AMD](https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-20)



## Non Unraid Users
Here is an example `docker run` command, please ensure you have your GPU fans manually controlled to prevent overheating, or add `--privileged` to the command and use PhoenixMiner arguments accordingly.
```
docker run -d --name='PhoenixMiner' --net='bridge' -e TZ="Australia/Sydney" --device='/dev/dri:/dev/dri' 'lnxd/phoenixminer' ./PhoenixMiner -pool asia1.ethermine.org:4444 -wal 0xe037C6245910EbBbA720514835d31B385D76927f.x
```



##  Unraid Users
This container was written to be run on Unraid, so the following instructions apply to that. Please ensure that you know what you're doing before setting this up, as excessively high temperatures are BAD for computers and could damage your hardware / eventuate in data loss.
 
### Instructions:
 
1. Ensure you are on Unraid 6.9.0 or later; otherwise, amdgpu drivers are not included.
2. Ensure your GPU is not bound to vfio at boot, on 6.9.0, and later you can do this by visiting `Tools` > `System Devices` and ensuring your card (and its audio device) is not checked. Also, ensure your GPU is not stubbed by checking its ID on the above page and cross-referencing with `pci-stub.ids=` (by visiting `Main` > `Flash`). If you made changes in this step, you need to safely shut down the array and reboot before proceeding.
3. Install ich777's `Radeon TOP` via CA (Easiest way to load AMD GPU drivers on Unraid host).
4. Install lnxd's `PhoenixMiner-AMD` via CA.
5. Make sure you update the pool & wallet address; otherwise, your 'rig' will generate income for me instead.
6. If you want to enable PhoenixMiner to control the fans / undervolt / overclock: leave privileged mode enabled for the container.
7. Run it, check the logs constantly for the first 20 mins or so to ensure it is working and your card doesn't overheat. If something looks incorrect, stop the container and double-check your config. I like to try and keep my 5500XT around 75c and my RX 580 around 55c (modded bios).
8. (Optional) If you want to monitor your miner from a web app rather than a representation of the logs, check out PhoenixStats in CA.
 
**Warning:** If you don't leave privileged mode enabled for the container, your GPU's default fan curve will be used, which is usually optimised for gaming. Make sure you have `Dynamix System Autofan` installed to prevent overheating (can be done via CA). I recommend enabling it and setting the high temperature to 25c at most. Low I set to 20c. I could not get the PWM min speed, but this didn't affect anything for me during testing.

If you notice any bugs, feel free to open an Issue or a pull request. For support, I'm best reached via the [support thread](https://forums.unraid.net/topic/104589-support-lnxd-phoenixminer-amd/) on the Unraid Community Forums.


​
##  Docker Hub Tags:
Different AMD GPUs require different driver versions, and those different driver versions often don't work very well on Operating Systems that they weren't built for. For this reason, I've gone ahead and changed to using multiple tags, each tag has it's own GPU compatibility table further down. If someone has success with a GPU on a specific tag please reply to this thread and let me know so I can update the table. I only have access to an RX 580 and a 5500XT for testing.

* **lnxd/phoenixminer:latest** (Same as latest-20.20 as this is the most compatible with current cards)
* **lnxd/phoenixminer:latest-20.45** (Only for RX6800 and RX6900)
* **lnxd/phoenixminer:latest-20.20**
* **lnxd/phoenixminer:latest-18.20**
 

​
## Compatibility:
These lists are very hopeful, they're sourced from the AMD website, and there's a real possibility your GPU might not work with a tag it's supposed to. Please do not make purchasing decisions based on these tables.
 
Also keep in mind you are unlikely to be able to profit from mining with a card with less than or equal to 4GB VRAM available to it. If you try this container you will probably get a DAG generation error or an extremely low hash rate.

### GPUs possibly compatible with lnxd/phoenixminer:latest-20.45:
* AMD Radeon™ RX 6900/6800 Series Graphics

### GPUs possibly compatible with lnxd/phoenixminer:latest-20.20:
* AMD Radeon™ RX 5700/5600/5500 Series Graphics.
**Confirmed working:** 5500XT by lnxd
* AMD Radeon™ Pro W-series
* AMD Radeon™ VII Series Graphics
* AMD Radeon™ Pro W 5700/5500 Series Graphics
* AMD Radeon™ RX Vega Series Graphics
* AMD Radeon™ Pro WX-series
* AMD Radeon™ Vega Frontier Edition
* AMD Radeon™ Pro WX 9100
* AMD Radeon™ RX 550/560/570/580/590 Series Graphics
**Confirmed working:** RX580 by lnxd, RX580 by SPOautos, RX570 by NixonInnes
* AMD Radeon™ Pro WX 8200
* AMD Radeon™ RX 460/470/480 Graphics
**Confirmed working:** RX480 by ich777
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

### GPUs possibly compatible with lnxd/phoenixminer:latest-18.20:
* Radeon™ RX Vega Series Graphics
* AMD Radeon™ Pro WX-series
* Radeon™ Vega Frontier Edition
* AMD FirePro™ W9100
* Radeon™ RX 550/560/570/580 Series Graphics
**Confirmed working:** RX580 by lnxd, RX580 by SPOautos, RX570 by NixonInnes
* AMD FirePro™ W8100
* AMD Radeon™ RX 460/470/480 Graphics
**Confirmed working:** RX480 by ich777
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
**A:** The output of ./Phoenixminer -help for 5.5c is available here.
 
#### **Q:** I have multiple GPUs, can I use this container?
**A:** Yes! If you have multiple GPUs, and they are all listed in one table, go for that version. If you have multiple GPUs and they are on different tables, you can have multiple containers on different tags and use the -gpus flag in PhoenixMiner to set which container uses which GPU.

#### **Q:** What are the mining fees?
**A:** There are none from me. The developer of PhoenixMiner charges 0.65%. This means that every 90 minutes the miner will mine for them for 35 seconds. The default pool, Ethermine, has a 1% fee and shares the transaction fees from the block. You can change to mine on any pool.

#### **Q:** Why is my card still heating up if I've set a target temperature (tt)?
**A:** PhoenixMiner seems to still rely on the default fan curve, so unless you've optimised that for mining it's probably best to set a fixed fan speed by setting the tt value to a negative, such as -70 (fixed at 70% fan speed while PhoenixMiner is running). The lower you can safely set this, the slightly less power your rig will use and the less the affect mining will have on your GPU fan's lifespan.
 
#### **Q:** Why am I getting such a low hash rate (eg. 2.5MH/s)?
**A:** Could be a lot of things, from the card having a very low power limit set, to trying to use a fake card. But the most likely issue is that you're using a card without enough VRAM. 4gb cards are not really suitable for Ethereum mining, please see the Compatibility section above.

#### **Q:** Is there an easier way to see the data from the Unraid WebUI Dashboard?
**A:** Yes! Users who have ich777's Radeon TOP installed can also install b3rs3rk's GPU Statistics plugin from CA. This will allow you to see things like the GPU temperature, load, fan RPM of one GPU at a time. Please note that it is expected for memory usage to be only around 4gb, as this is the current DAG limit.

#### **Q:** Does this also work with NVIDIA cards?
**A:** Shh! Yes it does. I don't know enough about the NVIDIA drivers in Ubuntu yet to list a compatibility chart, but thanks to some testing by ich777 I have confirmation that lnxd/phoenixminer:latest-20.45, lnxd/phoenixminer:latest-20.20 and lnxd/phoenixminer:latest work with a GTX1060 6GB. The same limitations with regards to VRAM apply as AMD cards, 4gb cards won't work.
​

​
## Additional PhoenixMiner Arguments
```
Phoenix Miner 5.5c Linux/gcc - Release build
--------------------------------------------

Usage: PhonixMiner [OPTIONS]
Options:

Pool options (normal mode):
  -pool <host:port> Ethash pool address
  -wal <wallet> Ethash wallet (some pools want user name and/or worker)
  -pass <password> Ethash password (most pools don't require it)
  -worker <name> Ethash worker name (most pools accept it as part of wallet)
  -proto <n> Selects the kind of stratum protocol for the ethash pool:
     1: miner-proxy stratum spec (e.g. coinotron)
     2: eth-proxy (e.g. ethermine, nanopool) - this is the default
     3: qtminer (e.g. ethpool)
     4: EthereumStratum/1.0.0 (e.g. nicehash)
     5: EthereumStratum/2.0.0
  -coin <coin> Ethash coin to use for devfee to avoid switching DAGs:
     auto: Try to determine from the pool address (default)
     eth: Ethereum
     etc: Ethereum Classic
     exp: Expanse
     music: Musicoin
     ubq: UBIQ
     pirl: Pirl
     etp: Metaverse ETP
     ella: Ellaism
     whale: WhaleCoin
     vic: Victorium
     nuko: Nekonium
     mix: MIX
     egem: EtherGem
     clo: Callisto
     dbix: DubaiCoin
     moac: MOAC
     etho: Ether-1
     yoc: Yocoin
     b2g: Bitcoiin2Gen
     esn: Ethersocial
     ath: Atheios
     reosc: REOSC
     qkc: QuarkChain
     bci: Bitcoin Interest
  -stales <n> Submit stales to ethash pool: 1 - yes (default), 0 - no
  -pool2 <host:port>  Failover ethash pool address
  -wal2 <wallet> Failover ethash wallet (if missing -wal will be used)
  -pass2 <password> Failover ethash password (if missing -pass will be used)
  -worker2 <name> Failover ethash worker name (if missing -worker will be used)
  -proto2 <n> Failover ethash stratum protocol (if missing -proto will be used)
  -coin2 <coin> Failover devfee Ethash coin (if missing -coin will be used)
  -stales2 <n> Submit stales to the failover pool: 1 - yes (default), 0 - no
  -dpool <host:port>  Dual mining pool address
  -dwal <wallet> Dual mining wallet
  -dpass <password> Dual mining pool password
  -dworker <name> Dual mining worker name
  -dcoin blake2s Dual mining algorithm (currently only blake2s)
  -dstales <n> Submit stales to dual mining pool: 1 - yes (default), 0 - no

General pool options:
  -fret <n> Switch to next pool afer N retries (default: 3)
  -ftimeout <n> Reconnect if no new ethash job is receved for n seconds
    (default: 600)
  -ptimeout <n> Switch back to primary pool after n minutes (30 by default;
    set to 0 to disable automatic switch back to primary pool)
  -retrydelay <n> Seconds before reconnecting (default: 5)
  -gwtime <n> Recheck period for Solo/GetWork mining (default: 200 ms)
  -rate <n> Report hashrate to the pool: 1 - yes, 0 - no (1 is the default)
Benchmark mode:
  -bench [<n>],-benchmark [<n>] Benchmark mode, optionally specify DAG epoch
Remote control options:
  -cdm <n> Selects the level of support of the CDM remote monitoring:
     0: disabled
     1: read-only - this is the default
     2: full (only use on secure connections)
  -cdmport <port> Set the CDM remote monitoring port or <ip_addr:port>
    (default 3333)
  -cdmpass <pass> Set the CDM remote monitoring password
  -cdmrs Reload the settings if config.txt is edited/uploaded remotely

Mining options:
  -amd  Use only AMD cards
  -acm  Turn on AMD compute mode (requires administrative rights)
  -nvidia  Use only Nvidia cards
  -gpus <123 ..n> Use only the specified GPUs (if more than 10, separate
    the indexes with comma)
  -mi <n> Set the mining intensity (0 to 14; 12 is the default)
  -gt <n> Set the GPU tuning parameter (6 to 400). The default is 15
  -sci <n> Dual mining intensity (1 to 1000). The default is 30
  -mode <n> Mining mode (0: dual mining; 1: ethash only). Use this option
            if you want only some of the GPUs to dual mine
  -clKernel <n> Type of AMD kernel: 0 generic, 1 optimized, 2 alterantive
    (1 is the default, 2 is only for RX470/570/480/580)
  -clGreen <n> Use power-efficient AMD kernels (0: no, 1: yes; default: 0)
  -clNew <n> Use new AMD kernels if supported (0: no, 1: yes; default: 1)
  -clf <n> AMD kernel sync (0: never, 1: periodic; 2: always; default: 1)
  -nvKernel <n> Type of Nvidia kernel: 0 - auto (the default),
    1 oldest (v1), 2 - newer (v2, since PM4.0), 3 - latest (v3)
  -nvdo <n> Use Nvidia driver-specific optimizations (0: no; default, 1: yes)
  -nvNew <n> Use new Nvidia kernels if supported (0: no, 1: yes; default: 1)
  -nvf <n> Nvidia kernel sync (0-3; default: 1)
  -list List the detected GPUs devices and exit
  -gbase <n> Set the index of the first GPU (0 or 1, default: 1)
  -minRigSpeed <n> Restart the miner if avg 5 min speed is below <n> MH/s
  -eres <n> Allocate DAG buffers big enough for n epochs ahead (default: 2)
  -dagrestart <n> Restart the miner when allocating buffer for new DAG epoch:
     0 - never, 1 - always, 2 - auto (default)
  -daglim <n> DAG size limit (0 - off, 1 - auto, >1000 - DAG size limit in MB)
  -lidag <n> Slow down DAG generation to avoid crash (0-3, default: 0 - fastest)
  -gser <n> Stagger DAG generation to avoid crash (0: no, 1: minimal; 2: full)
  -gpureset <n> Fully reset GPU when paused (0 - no, 1 - yes; default: 0)
  -rvram <n> Minimum free VRAM (-1: don't check; default: 128)
  -altinit Use alternative way to initialize AMD cards to prevent startup crashes
  -gpow <n> Lower the GPU usage to n% of maximum (default: 100)
  -wdog <n> Enable watchdog timer: 1 - yes, 0 - no (1 is the default)
  -wdtimeout <n> Watchdog timeout (30 - 300; default 45 seconds)
  -gswin <n> GPU stats time window (5-30 sec; default: 15; use 0 to
    revert to pre-2.8 way of showing momentary stats)
  -gsi <n> Speed stats interval (5-30 sec; default: 5; user 0 to disable)
  -astats <n> Show advanced stats from Web sources (0: no; 1: yes)
  -rmode <n> Selects the restart mode:
     0: disabled - miner will shut down instead of restarting
     1: restart with the same cmdline options - this is the default
     2: reboot (shut down miner and execute reboot.bat)
  -log <n> Selects the log file mode:
     0: disabled - no log file will be written
     1: write log file but don't show debug messages on screen
     2: write log file and show debug messages on screen
  -logfile <name> Set the name of the log file
  -logdir <path> Set a directory for the log file(s)
  -logsmaxsize <n> Max size of old log files in MB (default: 200)
  -timeout <n> Restart miner according to -rmode after n minutes
  -pauseat hh:mm Pause the miner at hh::mm (24 hours time)
  -resumeat hh::mm Resume the miner at hh::mm (24 hours time)

Hardware control options:
  -hwm <n> Hardware monitoring frequency (the default is 1):
      0 - no HW monitoring on all cards, 1 - normal monitoring,
      2 to 5 - less frequent monitoring
  -tt <n> Set fan control target temperature (special values:
      0 - no fan control, negative - fixed fan speed at n%)
  -fanmin <n> Set fan control min speed in % (-1 for default)
  -fanmax <n> Set fan control max speed in % (-1 for default)
  -fcm <n> Set fan control mode (0 - auto, 1 - normal, 2 - alt; default: 0)
  -fpwm <n> Fan PWM mode (0 - auto, 1 - direct, 2 - Polaris,
      3 - Vega, 4 - Radeon VII, Navi; default: 0)
  -fanidle <n> Set idle fan speed in % (-1 is auto, the default is 20)
  -tmax <n> Set fan control max temperature (0 for default)
  -powlim <n> Set GPU power limit in % (from -75 to 75, 0 for default)
  -cclock <n> Set GPU core clock in MHz (0 for default)
  -cvddc <n> Set GPU core voltage in mV (0 for default)
  -mclock <n> Set GPU memory clock in MHz (0 for default)
  -mvddc <n> Set GPU memory voltage in mV (0 for default)
  -straps <n> Memory strap level (0 - default)
  -vmt1 <n> Memory timing parameter 1 (0 to 100, default 0)
  -vmt2 <n> Memory timing parameter 2 (0 to 100, default 0)
  -vmt3 <n> Memory timing parameter 3 (0 to 100, default 0)
  -vmr <n> Memory refresh rate (0 to 100, default 0)
  -nvmem <n> Force using straps on unsupported Nvidia GPUs (0 - auto,
      1 - GDDR5, 2 - GDDR5X)
  -vmdag <n> Reset straps during DAG generation (default: 1)
  -mcdag <n> Reset mem clocks during DAG generation (default: 0; Nvidia only)
  -mt <n> Memory timing level (0 - VBIOS/default), AMD only
  -leavemt Do not reset memory timing level to 0 when closing
  -ttli <n> Lower GPU usage when temp is >= n deg C (0 for default)
  -hstats <n> HW stats mode (0: temp and fan speed only,
    1: temp, fan speed and power, 2: full; default: 1)
  -pidle <n> Idle power usage in W (will be added to GPU power)
  -prate <n> Power price in USD per kWh  -ppf <n> Power correction for GPU power usage in %.
    E.g. -ppf 105 means that reported GPU power will be multiplied by 1.05
  -tstop <n> Pause GPU when temp is >= n deg C (0 for default)
  -tstart <n> Resume GPU when temp is <= n deg C (0 for default)
  -resetoc Reset the overclocking settings on startup
  -leaveoc Do not reset overclocking setings when closing
  -config <filename> Load file with configuration options
  -openclLocalWork <n> Set the OpenCL local work size (advanced)
  -openclGlobalMultiplier <n> Set the OpenCL global work size (advanced; will
    be multiplied by the number of computing units)
  -cudaBlockSize <n> Set the CUDA block size (advanced)
  -cudaGridMultiplier <n> Set the CUDA grid size (advanced; will be multiplied
    by the number of computing units)

General Options:
  -v,-version  Show the version and exit
  -h,-help  Show this help message and exit
  ```