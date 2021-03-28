#!/bin/bash

docker stop phoenixminer
docker rm phoenixminer
#docker build -f radeon-15.12.Dockerfile . -t phoenixminer
#docker build -f amdgpu-pro-18.20.Dockerfile . -t phoenixminer
docker build -f amdgpu-pro-20.20.Dockerfile . -t phoenixminer
docker run -d -e TZ="Australia/Melbourne" -p 127.0.0.1:5450:5450/tcp --name="phoenixminer" phoenixminer
docker logs phoenixminer -f