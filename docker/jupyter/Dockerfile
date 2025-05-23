# syntax=docker/dockerfile:1

# Based on https://gist.githubusercontent.com/usr-ein/c42d98abca3cb4632ab0c2c6aff8c88a/raw/19dcc899f68d0b08c2c137d3fd01715b0c84bac9/Dockerfile

################################
# PYTHON-BASE
# Sets up all our shared environment variables
################################
FROM --platform=$TARGETPLATFORM python:3.11-slim AS python-base

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
    # poetry
    # https://python-poetry.org/docs/configuration/#using-environment-variables
    POETRY_VERSION=1.8.4 \
    # make poetry install to this location
    POETRY_HOME="/opt/poetry" \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    \
    # paths
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"


# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"


################################
# BUILDER-BASE
# Used to build deps + create our virtual environment
################################
FROM python-base AS builder-base
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    # deps for installing poetry
    curl \
    # deps for building python deps
    build-essential

# install poetry - respects $POETRY_VERSION & $POETRY_HOME
# The --mount will mount the buildx cache directory to where
# Poetry and Pip store their cache so that they can re-use it
RUN --mount=type=cache,target=/root/.cache \
    curl -sSL https://install.python-poetry.org | python3 -

# copy project requirement files here to ensure they will be cached.
WORKDIR $PYSETUP_PATH
COPY poetry.lock pyproject.toml ./

# install runtime deps - uses $POETRY_VIRTUALENVS_IN_PROJECT internally
RUN --mount=type=cache,target=/root/.cache \
    poetry install --without dev


################################
# PRODUCTION
# Final image used for runtime
################################
FROM python-base AS production
COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH

RUN apt-get update && apt-get install -y git

COPY configs/jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py
COPY configs/jupytext.toml /root/.config/jupytext.toml

WORKDIR /workshop
EXPOSE 8888 4141
ENV SHELL="/bin/bash"

ENTRYPOINT ["jupyter", "lab"]
