FROM ubuntu:20.04

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget sudo

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

# Get Phoenix Miner
RUN wget "https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/5.4c/PhoenixMiner_5.4c_Linux.tar.gz"
RUN tar xvzf PhoenixMiner_5.4c_Linux.tar.gz -C /home/docker
RUN mv "/home/docker/PhoenixMiner_5.4c_Linux" "/home/docker/phoenixminer"
RUN sudo chmod +x /home/docker/phoenixminer/PhoenixMiner

# Clean up apt
RUN apt-get clean all

# Set environment variables.
ENV HOME /home/docker

# Define working directory.
WORKDIR /home/docker/phoenixminer

# Define default command.
CMD ["./PhoenixMiner -pool ${POOL} -wal ${WALLET_ADDRESS}.${PASSWORD}"]
