# Start from the linuxserver/code-server image.
FROM --platform=$TARGETPLATFORM linuxserver/code-server:latest
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV PUID=0
ENV PGID=0
ENV DEFAULT_WORKSPACE=/workspace

# Switch to root to install additional packages.
USER root

# Install Docker engine (docker.io).
RUN apt-get update && \
    apt-get install -y docker.io \
    build-essential \
    gcc \
    g++ \
    clang \
    make \
    meson \
    ninja-build && \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Create the Docker daemon socket directory, if needed.
RUN mkdir -p /var/run

# Expose only the code-server port (adjust based on your configuration).
EXPOSE 8443

# Copy the custom entrypoint script.
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

SHELL ["/bin/bash", "-c"]
WORKDIR /workspace
ENV PATH="/app/code-server/bin:${PATH}"

RUN code-server --install-extension ms-python.python


ADD pyproject.toml .
ADD settings.json .vscode/settings.json

RUN uv venv .venv
RUN source .venv/bin/activate
RUN uv sync --active --all-extras


# Use our entrypoint script to launch Docker daemon and then code-server.
ENTRYPOINT ["/docker-entrypoint.sh"]

# The default command provided by linuxserver initiates code-server.
CMD ["/init"]
