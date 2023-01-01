# syntax=docker/dockerfile:1

FROM python:3.10-slim

SHELL ["/bin/bash", "-ceuxo", "pipefail"]

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1 PIP_NO_CACHE_DIR=1

RUN pip install torch==1.12.1+cu116 torchvision==0.13.1+cu116 --extra-index-url https://download.pytorch.org/whl/cu116

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential \
    less \
    curl \
    fonts-dejavu-core \
    rsync \
    git \
    jq \
    moreutils \
    libgl1-mesa-dev

RUN pip install opencv-python-headless pyngrok

ARG XFORMERS_WHL_NAME=xformers-0.0.15.dev0+4e3631d.d20221125-cp310-cp310-linux_x86_64.whl
COPY wheels/${XFORMERS_WHL_NAME} $XFORMERS_WHL_NAME
RUN pip install $XFORMERS_WHL_NAME && rm $XFORMERS_WHL_NAME

ARG USER_NAME=vscode
RUN apt-get install -y --no-install-recommends sudo \
  && useradd -m -s /bin/bash $USER_NAME \
  && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
USER $USER_NAME
WORKDIR /home/$USER_NAME