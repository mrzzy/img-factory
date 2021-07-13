#
# wireguard-boringtun
# boringtun - userspace rust wireguard in Docker
#
# NOTE: image requires NET_ADMIN capability in order to run

FROM rust:1.52-alpine3.13 AS base

# build & install boringtun
FROM base as build
RUN apk add --no-cache musl-dev wireguard-tools=1.0.20200827-r1
RUN cargo install boringtun

# release image
FROM alpine:3.13 as release

# setup workdir & user for wireguard
RUN addgroup --gid 12820 wireguard \
    && adduser --uid 12820  \
        --ingroup wireguard \
        --home /home/wg \
        --disabled-password wireguard
WORKDIR /home/wg

# install wireguard tools
RUN apk add --no-cache wireguard-tools=1.0.20200827-r1
# copy built boringtun binary
COPY --from=build /usr/local/cargo/bin/boringtun /usr/local/bin/boringtun

# drop root permissions
#USER wireguard
# copy & configure entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod u+x entrypoint.sh
ENTRYPOINT ["/home/wg/entrypoint.sh"]

# copy configuration file
COPY wg0.conf /etc/wireguard/wg0.conf

# configure wg tools to use boringtun userspace wireguard implementation
ENV WG_QUICK_USERSPACE_IMPLEMENTATION=boringtun
ENV WG_SUDO=1
# sleep to prevent image from exiting
CMD ["/bin/sleep", "9999d"]
