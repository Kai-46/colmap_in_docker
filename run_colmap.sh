#!/usr/bin/env bash

USER_ID=$(id -u)

docker run \
    -ti --rm \
	-u ${USER_ID} \
	--userns="host" \
	--hostname="colmap-in-docker" \
    --runtime=nvidia \
	-v /phoenix:/phoenix \
	kai46/colmap:latest \
    bash
