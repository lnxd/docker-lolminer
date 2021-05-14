#!/bin/bash
uninstall_amd_driver() {
	echo "Uninstalling driver"
	echo 'APT::Get::Assume-Yes "true";' >>/etc/apt/apt.conf.d/90assumeyes
	/usr/bin/amdgpu-uninstall
	rm /etc/apt/apt.conf.d/90assumeyes
	echo "Done!"
}

install_amd_driver() {
	AMD_DRIVER=$1
	AMD_DRIVER_URL=$2
	FLAGS=$3
	echo "Installing driver"
	echo "Downloading driver from "$AMD_DRIVER_URL/$AMD_DRIVER
	echo 'APT::Get::Assume-Yes "true";' >>/etc/apt/apt.conf.d/90assumeyes
	mkdir -p /tmp/opencl-driver-amd
	cd /tmp/opencl-driver-amd
	echo AMD_DRIVER is $AMD_DRIVER
	curl --referer $AMD_DRIVER_URL -O $AMD_DRIVER_URL/$AMD_DRIVER
	tar -Jxvf $AMD_DRIVER
	rm $AMD_DRIVER
	cd amdgpu-pro-*
	./amdgpu-install $FLAGS
	rm -rf /tmp/opencl-driver-amd
	echo ""
	echo "Driver installation finished."
	INSTALLED_DRIVERV=20.20
	rm /etc/apt/apt.conf.d/90assumeyes
}

INSTALLED_DRIVERV=20.20
if [[ "${INSTALLED_DRIVERV}" != "${DRIVERV}" ]]; then
	echo "Installed driver version (${INSTALLED_DRIVERV}) does not match wanted driver version (${DRIVERV})"
	echo "Installing AMD drivers v${DRIVERV}:"
	echo ""

	case $DRIVERV in

	0)
		uninstall_amd_driver
		echo "Skipping installation"
		;;

	18.20)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-18.20-621984.tar.xz" "https://drivers.amd.com/drivers/linux/ubuntu-18-04" "--opencl=legacy,pal --headless"
		;;

	19.50)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-19.50-967956-ubuntu-18.04.tar.xz" "https://drivers.amd.com/drivers/linux/19.50/" "--opencl=legacy,pal --headless"
		;;

	20.20)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-20.20-1098277-ubuntu-20.04.tar.xz" "https://drivers.amd.com/drivers/linux" "--opencl=legacy,pal --headless --no-dkms"
		;;

	20.40)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-20.40-1147286-ubuntu-20.04.tar.xz" "https://drivers.amd.com/drivers/linux" "--opencl=legacy,pal --headless --no-dkms"
		;;

	20.45)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz" "https://drivers.amd.com/drivers/linux" "--opencl=legacy,pal --headless --no-dkms"
		;;

	20.50)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-20.50-1234664-ubuntu-20.04.tar.xz" "https://drivers.amd.com/drivers/linux" "--opencl=legacy,rocr --headless --no-dkms"
		;;
	21.10)
		uninstall_amd_driver
		install_amd_driver "amdgpu-pro-21.10-1247438-ubuntu-20.04.tar.xz" "https://drivers.amd.com/drivers/linux" "--opencl=legacy,rocr --headless --no-dkms"
		;;
	esac

fi

echo "Project: lolMiner $MINERV"
echo "Author:  lnxd"
echo "Base:    $BASE"
echo "Driver:  $INSTALLED_DRIVERV"
echo "Target:  Unraid 6.9.0 - 6.9.2"
echo ""
echo "Wallet:  $WALLET"
echo "Pool:    $POOL"
echo ""
echo "Starting lolMiner $MINERV as $(id) with the following arguments:"
echo "--algo $ALGO --pool $POOL --user $WALLET --pass $PASSWORD $ADDITIONAL"
echo ""
cd /home/docker/lolminer
./lolMiner --algo $ALGO --pool $POOL --user $WALLET --pass $PASSWORD $ADDITIONAL
