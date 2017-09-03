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
ARG TBB=ON
ARG FFMPEG=ON

ARG VERSION=3.2.0

RUN apt-get update -y && apt-get install -y \
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
        libgphoto2-dev libgphoto2-6 \
        libgstreamer0.10-dev libgstreamer0.10-0 \
        libopenblas-dev libopenblas-base \
        libatlas3-base libatlas-dev \
        liblapacke-dev liblapacke \
        liblapack-dev liblapack3 \
        python-numpy \
        && apt-get clean

WORKDIR /

RUN wget https://github.com/opencv/opencv/archive/$VERSION.tar.gz \
    && tar xvf $VERSION.tar.gz -C /

RUN pip install numpy
RUN pip install scipy
RUN pip install tensorflow

RUN mkdir /opencv-$VERSION/cmake_binary \
    && cd /opencv-$VERSION/cmake_binary \
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
    -DWITH_TBB=$TBB \
    -DWITH_JPEG=ON \
    -DWITH_WEBP=ON \
    -DWITH_PNG=ON \
    -DWITH_QT=OFF \
    -DWITH_IPP=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DWITH_FFMPEG=$FFMPEG \
    -DENABLE_PRECOMPILED_HEADERS=ON \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DPYTHON3_EXECUTABLE=/usr/local/bin/python \
    -DPYTHON3_LIBRARIES=/usr/local/lib/libpython3.so \
    -DPYTHON3_INCLUDE_DIR=$(/usr/local/bin/python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON3_PACKAGES_PATH=$(/usr/local/bin/python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    -DINSTALL_PYTHON_EXAMPLES=OFF \
    -DINSTALL_C_EXAMPLES=OFF \
        && make install \
        && rm -rf /$VERSION.tar.gz /opencv-$VERSION
