FROM ubuntu:14.04

LABEL maintainer="Kai Zhang"

ARG DEBIAN_FRONTEND=non-interactive

# install general dependencies

RUN apt-get update && apt-get install -y \
    git \
    cmake3 \
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
    libcgal-dev

RUN apt-get update && apt-get install -y dpkg wget

RUN mkdir /tools

# qtbase5-dev on ubuntu14.04 is not compatible
# we download qtbase5-dev from ubuntu16.04 repo

WORKDIR /tools
RUN wget -nv -O qt5.5.deb http://mirrors.kernel.org/ubuntu/pool/main/q/qtbase-opensource-src/qtbase5-dev_5.5.1+dfsg-16ubuntu7_amd64.deb
RUN dpkg -i qt5.5.deb
RUN apt-get update && apt-get install -y qtbase5-dev

RUN wget -nv -O qt5opengl5.5.deb http://mirrors.kernel.org/ubuntu/pool/main/q/qtbase-opensource-src/libqt5opengl5-dev_5.5.1+dfsg-16ubuntu7_amd64.deb
RUN dpkg -i qt5opengl5.5.deb
RUN apt-get update && apt-get install -y libqt5opengl5-dev


# install cuda 8.0

WORKDIR /tools
RUN wget -nv -O cuda8.0.deb https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64-deb
RUN dpkg -i cuda8.0.deb
RUN apt-get update && apt-get install -y --no-install-recommends cuda

# install cuda update patch
RUN wget -nv -O cuda8.0_patch.deb https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb
RUN dpkg -i cuda8.0_patch.deb
RUN apt-get update && apt-get install -y --no-install-recommends cuda

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
