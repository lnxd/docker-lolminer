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
echo "--algo $ALGO --pool $POOL --user $WALLET --pass $PASSWORD $ADDITIONAL"

cd /home/docker/lolminer
./lolMiner --algo $ALGO --pool $POOL --user $WALLET --pass $PASSWORD $ADDITIONAL
