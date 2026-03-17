# syntax=docker/dockerfile:1

################################
# PYTHON-BASE
# Sets up all our shared environment variables
################################
FROM python:3.11-slim AS python-base

ARG TARGETPLATFORM

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    UV_PROJECT_ENVIRONMENT="/opt/pysetup/.venv" \
    VIRTUAL_ENV="/opt/pysetup/.venv"

ENV PATH="$VIRTUAL_ENV/bin:$PATH"


################################
# BUILDER-BASE
# Used to build deps + create our virtual environment
################################
FROM python-base AS builder-base

COPY --from=ghcr.io/astral-sh/uv:0.9.15 /uv /usr/local/bin/uv

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    build-essential

WORKDIR /opt/pysetup
COPY uv.lock pyproject.toml ./

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --group dvc --group dagster-jupyter --group mlflow --group onnx --no-dev


################################
# PRODUCTION
# Final image used for runtime
################################
FROM python-base AS production
COPY --from=builder-base /opt/pysetup/.venv /opt/pysetup/.venv

RUN apt-get update && apt-get install -y git

COPY configs/jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py
COPY configs/jupytext.toml /root/.config/jupytext.toml

WORKDIR /workshop
EXPOSE 8888 4141
ENV SHELL="/bin/bash"

ENTRYPOINT ["jupyter", "lab"]
