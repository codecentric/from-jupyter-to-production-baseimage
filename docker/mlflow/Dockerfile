# syntax=docker/dockerfile:1

################################
# PYTHON-BASE
# Sets up all our shared environment variables
################################
FROM --platform=$TARGETPLATFORM python:3.11-slim AS python-base

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
    build-essential \
    gcc

WORKDIR /opt/pysetup
COPY uv.lock pyproject.toml ./

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --only-group mlflow


################################
# PRODUCTION
# Final image used for runtime
################################
FROM python-base AS production
COPY --from=builder-base /opt/pysetup/.venv /opt/pysetup/.venv

COPY ./docker/mlflow/init-mlflow.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


WORKDIR /ml_data
EXPOSE 5000 5001
ENV SHELL="/bin/bash"


ENTRYPOINT ["/entrypoint.sh"]
