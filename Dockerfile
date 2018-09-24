FROM ubuntu:18.04

LABEL maintainer="Kai Zhang"

ARG DEBIAN_FRONTEND=non-interactive

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
    libcgal-dev

RUN mkdir /tools

RUN apt-get update && apt-get install -y libatlas-base-dev libsuitesparse-dev
RUN cd /tools
RUN git clone https://ceres-solver.googlesource.com/ceres-solver
RUN cd ceres-solver
RUN git checkout $(git describe --tags)
RUN mkdir build && cd build
RUN cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
RUN make && make install

RUN cd /tools
RUN git clone https://github.com/colmap/colmap.git
RUN cd colmap
RUN git checkout dev
RUN mkdir build && cd build
RUN cmake ..
RUN make && make install

WORKDIR /tools
RUN chmod -R 777 /tools

