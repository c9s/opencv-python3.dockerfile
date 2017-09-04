FROM python:3.6
MAINTAINER Yo-An Lin <yoanlin93@gmail.com>

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Intel CPU Options
ARG AVX=ON
ARG AVX2=ON
ARG SSE41=ON
ARG SSE42=ON
ARG SSSE3=ON
ARG TBB=ON

# Include Intel IPP support
ARG IPP=ON

# Include NVidia Cuda Runtime support
ARG CUDA=OFF

# Include NVidia Cuda Fast Fourier Transform (FFT) library support
ARG CUFFT=OFF

# Include NVidia Cuda Basic Linear Algebra Subprograms (BLAS) library support
ARG CUBLAS=OFF

# Include OpenCL Runtime support
ARG OPENCL=OFF

# Include OpenCL Shared Virtual Memory support" OFF ) experimental
ARG OPENCL_SVM=OFF

ARG OPENGL=ON

ARG FFMPEG=ON
ARG GTK=OFF
ARG QT=OFF
ARG NONFREE=OFF

# Include Intel Perceptual Computing SDK
ARG INTELPERC=OFF

ARG PREFIX=/usr/local
ARG VERSION=3.2.0

ARG PYTHON_BIN=/usr/local/bin/python
ARG PYTHON_LIB=/usr/local/lib/libpython3.so

RUN apt-get update -q -y && apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
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

RUN wget -qc https://github.com/opencv/opencv/archive/$VERSION.tar.gz \
    && tar xf $VERSION.tar.gz -C /

RUN pip install --no-use-wheel numpy
RUN pip install --no-use-wheel scipy

RUN mkdir /opencv-$VERSION/cmake_binary \
    && cd /opencv-$VERSION/cmake_binary \
    && cmake \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DOPENCV_ENABLE_NONFREE=$NONFREE \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=$CUDA \
    -DWITH_CUBLAS=$CUBLAS \
    -DWITH_CUFFT=$CUFFT \
    -DENABLE_AVX=$AVX \
    -DENABLE_AVX2=$AVX2 \
    -DENABLE_SSE41=$SSE41 \
    -DENABLE_SSE42=$SSE42 \
    -DENABLE_SSSE3=$SSSE3 \
    -DWITH_OPENGL=$OPENGL \
    -DWITH_GTK=$GTK \
    -DWITH_OPENCL=$OPENCL \
    -DWITH_OPENCL_SVM=$OPENCL_SVM \
    -DWITH_TBB=$TBB \
    -DWITH_JPEG=ON \
    -DWITH_WEBP=ON \
    -DWITH_TIFF=ON \
    -DWITH_PNG=ON \
    -DWITH_QT=$QT \
    -DWITH_IPP=$IPP \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DWITH_INTELPERC=$INTELPERC \
    -DWITH_FFMPEG=$FFMPEG \
    -DENABLE_PRECOMPILED_HEADERS=ON \
    -DPYTHON3_EXECUTABLE=$PYTHON_BIN \
    -DPYTHON3_LIBRARIES=$PYTHON_LIB \
    -DPYTHON3_INCLUDE_DIR=$($PYTHON_BIN -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON3_PACKAGES_PATH=$($PYTHON_BIN -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DINSTALL_PYTHON_EXAMPLES=OFF \
    -DINSTALL_C_EXAMPLES=OFF \
        && make install \
        && rm -rf /$VERSION.tar.gz /opencv-$VERSION

