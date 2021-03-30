#!/bin/bash

echo "Project: PhoenixMiner $MINERV"
echo "Author:  lnxd"
echo "Base:    $BASE"
echo "Driver:  $DRIVER"
echo "Target:  Unraid 6.9.0 - 6.9.1"
echo ""
echo "Wallet:  $WALLET"
echo "Pool:    $POOL"
echo ""
echo "Starting PhoenixMiner $MINERV with the following arguments:"
echo "-pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL"

if [ DRIVER == "NVIDIA" ]
then
   echo "First run on NVIDIA detected!"
   echo "Installing NVIDIA drivers"
   ubuntu-drivers autoinstall
   DRIVER="NVIDIA ${nvidia-smi --query-gpu=driver_version --format=csv,noheader}"
fi


cd /home/docker/phoenixminer
./PhoenixMiner -pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL