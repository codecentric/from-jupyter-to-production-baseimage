#!/bin/sh

  if [ ! -f /auth/htpasswd ]; then
    echo "Erstelle htpasswd Datei und Benutzer"
    mkdir /auth/htpasswd
    htpasswd -c -B -b /auth/htpasswd/users.htpasswd $REGISTRY_USERNAME $REGISTRY_PASSWORD
  fi

# Starte die Registry
registry serve /etc/docker/registry/config.yml
