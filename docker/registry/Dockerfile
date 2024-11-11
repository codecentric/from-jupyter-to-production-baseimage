# syntax=docker/dockerfile:1

# Based on https://gist.githubusercontent.com/usr-ein/c42d98abca3cb4632ab0c2c6aff8c88a/raw/19dcc899f68d0b08c2c137d3fd01715b0c84bac9/Dockerfile

################################
# PYTHON-BASE
# Sets up all our shared environment variables
################################
FROM --platform=$TARGETPLATFORM registry
RUN apk --no-cache add apache2-utils

ENV SHELL="/bin/bash"
COPY ./docker/registry/init-registry.sh /entrypoint.sh

# Make entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
