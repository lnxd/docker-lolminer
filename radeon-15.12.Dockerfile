
FROM ubuntu:14.04.4

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

# Install radeon drivers + hacky workaround to get PhoenixMiner running on Ubuntu 14.04.02
RUN apt-get update; \
    apt-get install -y curl wget;
RUN curl --referer $AMD_DRIVER_URL $AMD_DRIVER_URL/$AMD_DRIVER -o /home/docker/driver.deb
RUN wget -q -O libpci3_3.deb http://archive.ubuntu.com/ubuntu/pool/main/p/pciutils/libpci3_3.3.1-1.1ubuntu1_amd64.deb
RUN dpkg -i --force-confold "/home/docker/driver.deb"; exit 0
RUN apt-get -f install -y
RUN wget -q -O libpci3_3.deb http://archive.ubuntu.com/ubuntu/pool/main/p/pciutils/libpci3_3.3.1-1.1ubuntu1_amd64.deb
RUN dpkg -i --force-confold libpci3_3.deb
RUN apt-get -f install -y
RUN apt-get autoremove -y
RUN apt-get install -y build-essential software-properties-common; \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y; \
    apt-get update -y; \
    apt-get install gcc-7 g++-7 -y; \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7; \
    update-alternatives --config gcc;

RUN wget -q -O libstdc++6 http://launchpadlibrarian.net/375474836/libstdc++6_5.4.0-6ubuntu1~16.04.10_amd64.deb
RUN sudo dpkg --force-all -i libstdc++6


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
ENV BASE="Ubuntu 14.04.4"
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
