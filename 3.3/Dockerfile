FROM python:3.6
MAINTAINER Yo-An Lin <yoanlin93@gmail.com>

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ARG AVX=ON
ARG AVX2=ON
ARG SSE41=ON
ARG SSE42=ON
ARG CUDA=OFF
ARG OPENCL=OFF
ARG OPENCL_SVM=OFF
ARG OPENGL=ON

RUN apt-get update && \
        apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libeigen3-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libavformat-dev \
        libpq-dev \
        libboost-all-dev \
        && apt-get clean

WORKDIR /
RUN wget https://github.com/opencv/opencv/archive/3.3.0.zip \
&& unzip 3.3.0.zip \
&& mkdir /opencv-3.3.0/cmake_binary \
&& cd /opencv-3.3.0/cmake_binary \
&& cmake \
  -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=$CUDA \
  -DENABLE_AVX=$AVX \
  -DENABLE_AVX2=$AVX2 \
  -DENABLE_SSE41=$SSE41 \
  -DENABLE_SSE42=$SSE42 \
  -DENABLE_SSSE3=ON \
  -DWITH_OPENGL=$OPENGL \
  -DWITH_GTK=OFF \
  -DWITH_OPENCL=$OPENCL \
  -DWITH_OPENCL_SVM=$OPENCL_SVM \
  -DWITH_JPEG=ON \
  -DWITH_WEBP=ON \
  -DWITH_PNG=ON \
  -DWITH_QT=OFF \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DWITH_FFMPEG=ON \
  -DENABLE_PRECOMPILED_HEADERS=ON \
  -DBUILD_PERF_TESTS=OFF \
  -DBUILD_TESTS=ON \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
  -DINSTALL_PYTHON_EXAMPLES=ON \
  -DINSTALL_C_EXAMPLES=OFF \
    && make install \
    && rm /3.3.0.zip \
    && rm -r /opencv-3.3.0
