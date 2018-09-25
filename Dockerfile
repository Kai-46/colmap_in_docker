FROM ubuntu:16.04

LABEL maintainer="Kai Zhang"

ARG DEBIAN_FRONTEND=non-interactive

# install general dependencies

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev


RUN apt-get update && apt-get install -y dpkg wget

RUN mkdir /tools

# install cuda 8.0

WORKDIR /tools
RUN wget -nv -O cuda8.0.deb https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
RUN dpkg -i cuda8.0.deb && apt-get update && apt-get install -y --no-install-recommends cuda

# install cuda update patch
RUN wget -nv -O cuda8.0_patch.deb https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb
RUN dpkg -i cuda8.0_patch.deb && apt-get update && apt-get install -y --no-install-recommends cuda

# install ceres-solver

WORKDIR /tools
RUN apt-get update && apt-get install -y libatlas-base-dev libsuitesparse-dev
RUN git clone https://ceres-solver.googlesource.com/ceres-solver
WORKDIR /tools/ceres-solver
RUN git checkout $(git describe --tags)
RUN mkdir build
WORKDIR /tools/ceres-solver/build
RUN cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
RUN make -j4 && make install

# install colmap

WORKDIR /tools
RUN git clone https://github.com/colmap/colmap.git
WORKDIR /tools/colmap
RUN git checkout dev
RUN mkdir build
WORKDIR /tools/colmap/build
RUN cmake ..
RUN make -j4 && make install

# WORKDIR /tools
# RUN chmod -R 777 /tools

# remove unneeded files
RUN rm -rf /tools

ENV HOSTNAME colmap-in-docker
# RUN mkdir /home
RUN chmod -R 777 /home
ENV HOME /home
WORKDIR /home
