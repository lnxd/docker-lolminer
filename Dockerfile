FROM ubuntu:20.04

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl sudo libpci3 xz-utils

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Prevent error messages when running sudo
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

# Create user account
RUN useradd docker
RUN echo 'docker:docker' | sudo chpasswd
RUN usermod -aG sudo docker
RUN mkdir /home/docker

# Install amdgpu drivers
ARG AMD_DRIVER=amdgpu-pro-20.20-1098277-ubuntu-20.04.tar.xz
ARG AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux/
RUN mkdir -p /tmp/opencl-driver-amd
WORKDIR /tmp/opencl-driver-amd
RUN echo AMD_DRIVER is $AMD_DRIVER; \
    curl --referer $AMD_DRIVER_URL -O $AMD_DRIVER_URL/$AMD_DRIVER; \
    tar -Jxvf $AMD_DRIVER; \
    cd amdgpu-pro-*; \
    ./amdgpu-install; \
    apt-get install opencl-amdgpu-pro -y; \
    rm -rf /tmp/opencl-driver-amd;

# Get Phoenix Miner
RUN curl "https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/5.5c/PhoenixMiner_5.5c_Linux.tar.gz" -O PhoenixMiner_5.5c_Linux.tar.gz
RUN tar xvzf PhoenixMiner_5.5c_Linux.tar.gz -C /home/docker
RUN mv "/home/docker/PhoenixMiner_5.5c_Linux" "/home/docker/phoenixminer"
RUN sudo chmod +x /home/docker/phoenixminer/PhoenixMiner

# Clean up apt
RUN apt-get clean all

# Set environment variables.
ENV PATH=$PATH:/home/docker/phoenixminer
ENV HOME /home/docker

# Define working directory.
WORKDIR /home/docker/phoenixminer

# Define default command.
CMD ["ls"]
#CMD ["./PhoenixMiner -pool ${POOL} -wal ${WALLET_ADDRESS}.${PASSWORD}"]