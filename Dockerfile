FROM ubuntu:16.04
MAINTAINER Shota Kawabuchi <shota.kawabuchi+git@gmail.com>

RUN set -x && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    bzip2 \
    git \
    language-pack-ja \
    language-pack-ja-base \
    libmecab-dev \
    mecab \
    mecab-ipadic-utf8 \
    vim \
    wget \
  apt-get clean && \
  wget https://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh && \
  bash Miniconda3-4.3.11-Linux-x86_64.sh -b && \
  rm Miniconda3-4.3.11-Linux-x86_64.sh

RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

ENV PATH /root/miniconda3/bin:$PATH
RUN set -x && \
  conda install \
    jupyter \
    numpy \
    scipy \
    seaborn \
    six -y && \
  pip install \
    mecab-python3 \
    "https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.1.0-cp36-cp36m-linux_x86_64.whl"

COPY jupyter_notebook_config.py /root/.jupyter/
COPY matplotlibrc /root/.config/matplotlib/

# TensorBoard
EXPOSE 6006

# Jupyter Notebook
EXPOSE 8888

RUN mkdir /workspace
VOLUME /workspace
VOLUME /mnt
WORKDIR /workspace
