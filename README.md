# docker-phoenixminer
 
This project is very much in an alpha stage. Please do not use it in a stability critical environment.

For non unraid users, an example docker run command for this container would be:
```
docker run -d --name='PhoenixMiner' --net='bridge' -e TZ="Australia/Sydney" --device='/dev/dri:/dev/dri' 'lnxd/phoenixminer' ./PhoenixMiner -pool asia1.ethermine.org:4444 -wal 0xe037C6245910EbBbA720514835d31B385D76927f.x
```

This container was written to be run on Unraid, so the following instructions apply to that. Please ensure that you know what you're doing before setting this up, as excessively high temperatures are BAD for computers and could damage your drives / lead to data loss. I personally have my drives in an external enclosure.

1. Like always, download a backup of your Unraid flash drive just in case. 
2. Ensure you are on on Unraid 6.9.0 or later, otherwise amdgpu drivers are not included
3. Ensure your GPU is not bound to vfio at boot, on 6.9.0 and later this can be done by visiting `Tools` > `System devices` and ensuring your card (and its audio device) is not checked.
4. Ensure your GPU is not stubbed by checking its ID on the above page, and cross referencing with `pci-stub.ids=` (`Main` > `Flash`). This is not something that is done by default, so unless you have done it to attach the card to a VM it likely won't be stubbed. 
5. Make sure you have `Dynamix System Autofan` installed (can be done via CA). I recommend enabling it and setting the high temperature to 25c at most. Low I set to 20. It was not able to get the PWM min speed but this didn't affect anything for me. This step is necessary as the containerized application is not able to overclock or set fan speeds, which leads to cards to (perpetually?) increase in temperature. I don't know what happens, I didn't risk it.
6. Open Community Applications, visit settings and ensure `Enable additional search results from dockerHub` is set to `Yes`
7. Search for `lnxd/phoenixminer`, and add it, customisation comes next
8. Add a device, set it to `/dev/dri:/dev/dri`
9. Change to advanced, enter post arguments `./PhoenixMiner -pool asia1.ethermine.org:4444 -wal 0xe037C6245910EbBbA720514835d31B385D76927f.x` updated to your own details
10. Run it, check the logs constantly for the first 20 mins or so to ensure it is working and your card doesn't overheat. If something looks bad, stop the container and double check your config. I like to ensure my 5500XT stays around 75c, and my RX 580 stays around 70 (modded bios)

Lots of steps for now, this might get easier in the future if it gets accepted for CA, but for now if you don't know how to complete the above steps it's probably best if you don't try, otherwise you might damage your system.