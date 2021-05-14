FROM ubuntu:20.04

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y apt-utils; \
    apt-get install -y curl sudo libpci3 xz-utils; \
# Clean up apt
    apt-get clean all; \
# Set timezone
    ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
# Prevent error messages when running sudo
    echo "Set disable_coredump false" >> /etc/sudo.conf; \
# Create user account
    useradd docker; \
    echo 'docker:docker' | sudo chpasswd; \
    usermod -aG sudo docker; \
    mkdir /home/docker;

# Install default AMD Drivers
ARG AMD_DRIVER=amdgpu-pro-20.40-1147286-ubuntu-20.04.tar.xz
ARG AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux
RUN mkdir -p /tmp/opencl-driver-amd
WORKDIR /tmp/opencl-driver-amd
RUN echo 'APT::Get::Assume-Yes "true";'>> /etc/apt/apt.conf.d/90assumeyes; \
    echo AMD_DRIVER is $AMD_DRIVER; \
    curl --referer $AMD_DRIVER_URL -O $AMD_DRIVER_URL/$AMD_DRIVER; \
    tar -Jxvf $AMD_DRIVER; \
    rm $AMD_DRIVER; \
    cd amdgpu-pro-*; \
    ./amdgpu-install --opencl=legacy,pal --headless --no-dkms; \
    rm -rf /tmp/opencl-driver-amd; \
    rm /etc/apt/apt.conf.d/90assumeyes;

# Get lolMiner
ENV MINERV=1.24a
ENV MINERV=$MINERV
RUN curl "https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.24/lolMiner_v1.24a_Lin64.tar.gz" -L -o "lolMiner_v1.24a_Lin64.tar.gz"; \
    tar xvzf lolMiner_v1.24a_Lin64.tar.gz -C /home/docker; \
    mv "/home/docker/1.24a/" "/home/docker/lolminer"; \
    sudo chmod +x /home/docker/lolminer/lolMiner;

# Copy latest scripts
COPY start.sh mine.sh custom-mine.sh /home/docker/
RUN sudo chmod +x /home/docker/start.sh; \
    sudo chmod +x /home/docker/mine.sh; \
    sudo chmod +x /home/docker/custom-mine.sh;

# Set environment variables.
ENV BASE="Ubuntu 20.04"
ENV DRIVERV="20.20"
ENV PATH=$PATH:/home/docker/lolminer
ENV HOME="/home/docker"
ENV POOL="asia1.ethermine.org:4444"
ENV WALLET="0xe037C6245910EbBbA720514835d31B385D76927f"
ENV PASSWORD="x"
ENV TT="56"
ENV TSTOP="85"
ENV TSTART="80"
ENV ADDITIONAL=" "
ENV CUSTOM=""

# Define working directory.
WORKDIR /home/docker/

# Define default command.
CMD ["./start.sh"]