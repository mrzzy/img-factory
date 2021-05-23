#
# wireguard-boringtun
# boringtun - userspace rust wireguard in Docker
#
# NOTE: image requires NET_ADMIN capability in order to run

FROM rust:1.52-alpine3.13 AS base

# setup workdir & user for wireguard
RUN addgroup --gid 12820 wireguard \
    && adduser --uid 12820  \
        --ingroup wireguard \
        --home /home/wg \
        --disabled-password wireguard
WORKDIR /home/wg
# install wireguard tools
RUN apk add --no-cache wireguard-tools

# build & install boringtun
FROM base as build
RUN apk add --no-cache musl-dev wireguard-tools
RUN cargo install boringtun

# release image
FROM base as release
# drop root permissions
#USER wireguard
COPY --from=build /usr/local/cargo/bin/boringtun /usr/local/cargo/bin/boringtun
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
