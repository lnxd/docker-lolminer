FROM ubuntu:16.04

# Build time variables
ARG MINERV=5.5c
ARG AMD_DRIVER=fglrx_15.302-0ubuntu1_amd64_ub_14.01.deb
ARG AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y apt-utils; \
    apt-get install -y sudo libpci3 xz-utils; \

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

# Install radeon drivers tip from john42 on https://community.amd.com/t5/drivers-software/fglrx-15-201-0ubuntu1-amd64-ub-14-01-deb-is-not-a-debian-format/td-p/292133
RUN apt-get update; \
    apt-get install -y curl wget libfontconfig1 libfreetype6 libice6 libqtcore4 libsm6 libx11-6 libxext6 libxfixes3 libxrandr2 libxrender1; \
    apt-get install -y execstack; \
    apt-get install -y debhelper; \
    apt-get install -y dkms; \
    apt-get install -y lib32gcc1; \
    apt-get install -y dh-modaliases; \
    curl --referer $AMD_DRIVER_URL $AMD_DRIVER_URL/$AMD_DRIVER -o /home/docker/driver.deb; \
    dpkg -i --force-confold "/home/docker/driver.deb"; exit 0; \
    apt-get -f install -y; \
    apt-get clean all;

# Get Phoenix Miner
RUN apt-get update ; \
    apt-get install -y curl; \
    curl "https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/${MINERV}/PhoenixMiner_${MINERV}_Linux.tar.gz" -L -o "PhoenixMiner_${MINERV}_Linux.tar.gz"; \
    tar xvzf PhoenixMiner_${MINERV}_Linux.tar.gz -C /home/docker; \
    mv "/home/docker/PhoenixMiner_${MINERV}_Linux" "/home/docker/phoenixminer"; \
    sudo chmod +x /home/docker/phoenixminer/PhoenixMiner; \
    apt-get purge -y curl; \
    apt-get clean all; 

# Copy latest mine.sh
COPY mine.sh /home/docker/mine.sh
RUN sudo chmod +x /home/docker/mine.sh

# Set environment variables.
ENV BASE="Ubuntu 15.04"
ENV DRIVER="fglrx_15.302 / AMD Radeon Software Crimson Edition 15.12 Proprietary"
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
