# colmap in docker

This github repo aims to help you build a docker image with colmap residing in.

**Prerequites:** make sure [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) and [nvidia-docker2](https://github.com/NVIDIA/nvidia-docker) are installed on your system. In addition, make sure that the nvidia driver installed on your system is compatible with cuda-8.0; otherwise you need to modify the base image in the Dockerfile (see [this page](https://hub.docker.com/r/nvidia/cuda/) for available nvidia images).

**Workflow**:
* switch to the directory 'colmap_in_docker' after you git-clone the repo.
* run './build_colmap.sh'; this build a docker image called 'kai46/colmap:latest' on your local machine.
* run './run_colmap.sh'; this will launch a container and lead you to an interactive bash; the script takes care of mapping host user id, and mounting host volume into the newly launched container; this script is tailored to the phoenix cluster at Cornell, and by default, it mounts the '/phoenix' directory into the launched container; feel free to modify it for your own purposes. 
* enjoy!
