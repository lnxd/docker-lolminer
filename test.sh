#!/bin/bash

docker stop lolminer
docker rm lolminer
#docker build -f amdgpu-pro-18.20.Dockerfile . -t lolminer
docker build -f amdgpu-pro-20.20.Dockerfile . -t lolminer
docker build -f amdgpu-pro-20.45.Dockerfile . -t lolminer
docker run -d -e TZ="Australia/Melbourne" -p 5450:5450/tcp --name="lolminer" lolminer
docker logs lolminer -f