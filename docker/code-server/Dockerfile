# syntax=docker/dockerfile:1

# Based on https://gist.githubusercontent.com/usr-ein/c42d98abca3cb4632ab0c2c6aff8c88a/raw/19dcc899f68d0b08c2c137d3fd01715b0c84bac9/Dockerfile

################################
# PYTHON-BASE
# Sets up all our shared environment variables
################################
FROM --platform=$TARGETPLATFORM linuxserver/code-server:latest AS python-base

ARG TARGETPLATFORM

# python
ENV PYTHONUNBUFFERED=1 \
    # prevents python creating .pyc files
    PYTHONDONTWRITEBYTECODE=1 \
    \
    # pip
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    # paths
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"


################################
# BUILDER-BASE
# Used to build deps + create our virtual environment
################################
FROM python-base AS builder-base
RUN apt-get update && \
    apt-get install -y curl bash-completion \
    software-properties-common \
    build-essential && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.rye/bin:$PATH"
ENV RYE_INSTALL_OPTION="--yes"
ENV SHELL="/bin/bash"


# Download and install rye with proper link
RUN curl -sSf https://rye.astral.sh/get | bash

# Source rye environment
RUN echo 'source $HOME/.rye/env' >> /root/.profile
RUN echo 'source "$HOME/.rye/env"' >> ~/.bashrc

# Expose the port used by code-server
EXPOSE 8443

RUN /app/code-server/bin/code-server --install-extension ms-python.python
