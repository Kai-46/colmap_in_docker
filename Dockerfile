FROM nvidia/cuda:8.0-devel-ubuntu16.04

LABEL maintainer="Kai Zhang"

ARG DEBIAN_FRONTEND=non-interactive

# update sources.list
# RUN echo "deb http://mirror.math.princeton.edu/pub/ubuntu/ xenial main \ 
# deb-src http://mirror.math.princeton.edu/pub/ubuntu/ xenial main" > /etc/apt/sources.list 

# install general dependencies

# RUN apt-get update && apt-get install apt-transport-https
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential

RUN apt-get update && apt-get install -y \
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
    libglew-dev

RUN apt-get update && apt-get install -y \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev

RUN mkdir /tools

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

# RUN mkdir /home
RUN chmod -R 777 /home
ENV HOME /home
WORKDIR /home
