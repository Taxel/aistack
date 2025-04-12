#!/bin/bash

CERT_PATH="/etc/nginx/certs/selfsigned.crt"
KEY_PATH="/etc/nginx/certs/selfsigned.key"

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
  echo "Generating self-signed certs..."
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout "$KEY_PATH" \
    -out "$CERT_PATH" \
    -subj "/CN=openwebui.localhost"
else
  echo "Certificates already exist. Skipping generation."
fi

echo "Starting Nginx..."
nginx -g "daemon off;"