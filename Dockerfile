FROM ubuntu:20.04

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y curl sudo libpci3 xz-utils wget

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
RUN wget "https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/5.5c/PhoenixMiner_5.5c_Linux.tar.gz"
RUN tar xvzf PhoenixMiner_5.5c_Linux.tar.gz -C /home/docker
RUN mv "/home/docker/PhoenixMiner_5.5c_Linux" "/home/docker/phoenixminer"
RUN sudo chmod +x /home/docker/phoenixminer/PhoenixMiner

# Download latest mine.sh
RUN wget "https://raw.githubusercontent.com/lnxd/docker-phoenixminer/1fb1e180e7d0821642992cbe9fa394473961b521/mine.sh" -O "/home/docker/mine.sh"
RUN sudo chmod +x /home/docker/mine.sh

# Clean up apt
RUN apt-get purge curl wget
RUN apt-get clean all

# Set environment variables.
ENV PATH=$PATH:/home/docker/phoenixminer
ENV HOME="/home/docker"
ENV POOL="asia1.ethermine.org:4444"
ENV WALLET="0xe037C6245910EbBbA720514835d31B385D76927f"
ENV PASSWORD="x"
ENV TT="56"
ENV TSTOP="85"
ENV TSTART="80"
ENV ADDITIONAL=" "

# Define working directory.
WORKDIR /home/docker/

# Define default command.
CMD ["./mine.sh"]