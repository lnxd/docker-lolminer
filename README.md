# docker-phoenixminer
 
This project is very much in an alpha stage. Please do not use it in a stability critical environment.

```
[97m*** 0:35 *** 3/17 21:59 **************************************
[96mEth: Mining ETH on asia1.ethermine.org:4444 for 0:35
Eth speed: 54.864 MH/s, shares: 28/0/0, time: 0:35
GPUs: 1: 25.336 MH/s (10) 2: 29.528 MH/s (18)
[0mEth: Accepted shares 28 (0 stales), rejected shares 0 (0 stales)
Eth: Incorrect shares 0 (0.00%), est. stales percentage 0.00%
[96mEth: Maximum difficulty of found share: 418.6 GH (!)
Eth: Average speed (5 min): 54.862 MH/s
Eth: Effective speed: 52.93 MH/s; at pool: 52.93 MH/s

[96mGPU1: 76C 57% 105W, GPU2: 56C 100% 112W
GPUs power: 217.2 W
```

For non unraid users, an example docker run command for this container would be:
```
docker run -d --name='PhoenixMiner' --net='bridge' -e TZ="Australia/Sydney" --device='/dev/dri:/dev/dri' 'lnxd/phoenixminer' ./PhoenixMiner -pool asia1.ethermine.org:4444 -wal 0xe037C6245910EbBbA720514835d31B385D76927f.x
```

This container was written to be run on Unraid, so the following instructions apply to that. Please ensure that you know what you're doing before setting this up, as excessively high temperatures are BAD for computers and could damage your drives / lead to data loss. I personally have my drives in an external enclosure.

1. Like always, download a backup of your Unraid flash drive just in case. 
2. Ensure you are on on Unraid 6.9.0 or later, otherwise amdgpu drivers are not included
3. Ensure your GPU is not bound to vfio at boot, on 6.9.0 and later this can be done by visiting `Tools` > `System devices` and ensuring your card (and its audio device) is not checked.
4. Ensure your GPU is not stubbed by checking its ID on the above page, and cross referencing with `pci-stub.ids=` (`Main` > `Flash`). This is not something that is done by default, so unless you have done it to attach the card to a VM it likely won't be stubbed.
5. SSH into your Unraid server or open a terminal session from the Unraid UI and run `wget "https://raw.githubusercontent.com/lnxd/docker-phoenixminer/main/PhoenixMiner.xml" -O "/boot/config/plugins/dockerMan/templates-user/my-PhoenixMiner-lnxd.xml"`
6. Visit the Docker tab via the Unraid UI and press "Add Container", select "PhoenixMiner-lnxd" from the list and customise it. Make sure you update the variables otherwise your server will be mining for me instead.
7. If you want to enable PhoenixMiner to control the fans / undervolt / overclock: leave priveledged mode enabled for the container. If not, make sure you have `Dynamix System Autofan` installed (can be done via CA). I recommend enabling it and setting the high temperature to 25c at most. Low I set to 20. It was not able to get the PWM min speed but this didn't affect anything for me during testing.
8. Run it, check the logs constantly for the first 20 mins or so to ensure it is working and your card doesn't overheat. If something looks bad, stop the container and double check your config. I like to ensure my 5500XT stays around 75c, and my RX 580 stays around 55c (modded bios)

Lots of steps for now, this might get easier in the future if it gets accepted for CA, but for now if you don't feel confident completing the above steps it's probably best if you don't try, otherwise you might damage your system (with heat).