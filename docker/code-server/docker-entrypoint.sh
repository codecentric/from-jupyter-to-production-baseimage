#!/bin/bash
set -e

echo "Starting Docker daemon (without TCP exposure)..."

# Launch dockerd in the background. Docker will listen on its default Unix socket (/var/run/docker.sock).
dockerd > /var/log/dockerd.log 2>&1 &

# Wait until the Docker daemon is ready.
until docker info > /dev/null 2>&1; do
    echo "Waiting for Docker daemon..."
    sleep 1
done

echo "Docker daemon is running."




# Execute the default command (typically code-server via linuxserver's /init script).
exec "$@"
