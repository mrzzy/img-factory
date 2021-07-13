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
RUN SS_RELEASE_JSON=$(wget --quiet -O- "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases/v1.11.1" \
        | jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-musl\\.tar\\.xz$"))') \
    && SS_ARCHIVE=$(echo $SS_RELEASE_JSON | jq -r '.name') \
    && wget $(echo $SS_RELEASE_JSON | jq -r ".browser_download_url") -O $SS_ARCHIVE \
    # for some reason, the tar archive extraction fails if done immdiately after wget
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
