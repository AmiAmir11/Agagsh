#!/bin/sh

set -e

mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

echo "Starting tailscaled..."

./tailscaled \
  --state=/var/lib/tailscale/tailscaled.state \
  --socket=/var/run/tailscale/tailscaled.sock \
  --tun=userspace-networking \
  --socks5-server=localhost:1055 \
  --outbound-http-proxy-listen=localhost:1055 &

sleep 3

echo "Connecting to Tailscale..."

until ./tailscale up \
  --authkey=${TAILSCALE_AUTHKEY} \
  --hostname=${TAILSCALE_HOSTNAME} \
  --advertise-exit-node \
  ${TAILSCALE_ADDITIONAL_ARGS}
do
  echo "Retrying connection..."
  sleep 2
done

echo "Exit Node is UP"

tail -f /dev/null
