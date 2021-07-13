#
# shadowsocks-rust
# Shadowsocks - Rust implementation on Alpine
#

FROM alpine:3.12 AS base

# Setup workdir & user for shadowsocks
RUN addgroup --gid 8388 shadowsocks \
    && adduser --uid 8388  \
        --ingroup shadowsocks \
        --home /home/shadowsocks \
        --disabled-password shadowsocks
WORKDIR /home/shadowsocks

# Download prebuilt shadowsocks-rust binaries
FROM base AS build
RUN apk add --no-cache --virtual .build-deps jq git curl
ENV SS_VERSION=v1.11.1 SS_ARCHIVE=shadowsocks.tar.xz
RUN wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SS_VERSION}/shadowsocks-${SS_VERSION}.aarch64-unknown-linux-musl.tar.xz -O $SS_ARCHIVE \
    && echo $SS_ARCHIVE \
    && tar -C /usr/bin/ -xf $SS_ARCHIVE

FROM base as release
# drop root permissions when running shadowsocks
USER shadowsocks
# copy shadowsocks binaries
COPY --from=build /usr/bin/ssserver /usr/bin/ssserver
# copy default configuration file
COPY config.json /etc/shadowsocks-rust/config.json
# run shadowsocks
CMD [ "/usr/bin/ssserver", "--config", "/etc/shadowsocks-rust/config.json" ]
