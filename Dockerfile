ARG RUST_VERSION=1.86.0

FROM rust:${RUST_VERSION}-alpine3.21 AS ferium
ARG PROFILE_NAME=minecraft-server
ARG MINECRAFT_VERSION=1.21.5
ARG PROFILE_MOD_LOADER=fabric
VOLUME /opt/mods
RUN apk add --latest --update-cache \
        git \
        build-base \
    && git clone https://github.com/gorilla-devs/ferium.git /tmp/ferium \
    && cargo install --no-default-features --path /tmp/ferium \
    && mkdir -p /opt/mods
