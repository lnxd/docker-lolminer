#!/bin/bash

term_handler() {
	kill -SIGTERM "$killpid"
	wait "$killpid" -f 2>/dev/null

	exit 143
}

trap 'kill ${!}; term_handler' SIGTERM
if [ "${CUSTOM}" == "true" ]; then
	/home/docker/custom-mine.sh &
else
	/home/docker/mine.sh &
fi
killpid="$!"

while true; do
	wait $killpid
	exit 0
done
