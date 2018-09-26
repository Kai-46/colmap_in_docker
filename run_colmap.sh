#!/usr/bin/env bash

# usage: docker_run.sh [options] <image_name> <command inside the container>
# some of the popular options are
	# to run container in background, use -d
	# to run container interactively, use -ti
	# to autoremove the container after it exits, use --rm

# example: docker_run.sh -ti --rm ubuntu:18.04 bash
#		   docker_run.sh -ti ubuntu:18.04 bash

USER_ID=$(id -u)
# CONTAINER_NAME=${USER}_$(date +%m%d_%H%m%S)

# echo "starting container with uid: ${USER_ID}..."
# echo "host volume '/phoenix' has been mounted..."
# echo "this container has the same permission access to the mounted host volumes as ${USER} (uid: ${USER_ID})"
docker run \
    -ti --rm \
	-u ${USER_ID} \
	--userns="host" \
	--hostname="colmap-in-docker" \
    --runtime=nvidia \
	-v /phoenix:/phoenix \
	-v /etc/localtime:/etc/localtime:ro \
	kai46/colmap:latest \
    bash
