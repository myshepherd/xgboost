# Start with NVidia CUDA base image
FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Yeseong Kim <yek048@ucsd.edu>

# Install dependent packages
RUN apt-get -y update && apt-get install -y wget nano python-pip libboost-all-dev python-numpy build-essential python-dev python-setuptools libboost-python-dev libboost-thread-dev

# Install useful python libraries and tools
RUN pip install pandas matplotlib sklearn scipy
RUN apt-get install -y vim python-tk
RUN apt-get install -y git
RUN apt-get install -y cmake

# Install xgboost
RUN cd /root && git clone --recursive https://github.com/dmlc/xgboost
RUN mkdir /root/xgboost/build
RUN cd /root/xgboost/build && cmake .. -DUSE_CUDA=ON && make -j
RUN cd /root/xgboost/python-package && python setup.py install

CMD nvidia-smi -q
