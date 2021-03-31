#!/bin/bash

echo "Project: lolminer $MINERV"
echo "Author:  lnxd"
echo "Base:    $BASE"
echo "Driver:  $DRIVER"
echo "Target:  Unraid 6.9.0 - 6.9.1"
echo ""
echo "Wallet:  $WALLET"
echo "Pool:    $POOL"
echo ""
echo "Starting lolminer $MINERV with the following arguments:"
echo "-pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL"

cd /home/docker/lolminer
./lolMiner --coin ethereum -pool $POOL --port $PORT -user $WALLET --pass $PASSWORD $ADDITIONAL