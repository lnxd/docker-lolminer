#!/bin/bash

echo "Project: PhoenixMiner 5.5c"
echo "Author:  lnxd"
echo "Base:    Ubuntu 20.04"
echo "Target:  Unraid 6.9.0 - 6.9.1"
echo ""
echo "Wallet:  $WALLET"
echo "Pool:    $POOL"
echo ""
if test -f "/dev/dri"; then
    echo "Card presence test passed."
else 
	echo "Card presence test failed. Please ensure you have passed your GPU to this container correctly."
	echo ""
	echo "Exiting due to error."
	exit
fi
echo ""
echo "Starting PhoenixMiner 5.5c with the following arguments:"
echo "-pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL"

cd /home/docker/phoenixminer
./PhoenixMiner -pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL