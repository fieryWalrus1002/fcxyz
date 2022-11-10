FROM ubuntu:latest AS py3dox-dev

RUN apt update \
    && apt install -y \
    git \
    python3-dev \
    python3-pip \
    python-sphinx