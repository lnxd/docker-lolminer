#!/bin/bash

docker stop phoenixminer
docker rm phoenixminer
docker build . -t phoenixminer
docker run -d -e TZ="Australia/Melbourne" -p 127.0.0.1:5450:5450/tcp --name="phoenixminer" phoenixminer
docker logs xmrig -f