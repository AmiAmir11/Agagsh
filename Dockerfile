FROM alpine:3.18.3

WORKDIR /app

ENV TAILSCALE_VERSION="latest"
ENV TAILSCALE_HOSTNAME="northflank-vpn"
ENV TAILSCALE_ADDITIONAL_ARGS=""

RUN apk add --no-cache \
    ca-certificates \
    wget \
    iptables \
    ip6tables \
    bash \
    tar

# install tailscale
RUN wget https://pkgs.tailscale.com/stable/tailscale_${TAILSCALE_VERSION}_amd64.tgz && \
    tar xzf tailscale_${TAILSCALE_VERSION}_amd64.tgz --strip-components=1

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
