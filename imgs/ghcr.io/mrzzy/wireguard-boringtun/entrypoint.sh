#!/bin/sh
#
# wireguard-boringtun
# entrypoint script
#

# bring up wireguard VPN
echo "[INFO] $(date -Iseconds): Bringing up Wireguard (Boringtun) VPN."
wg-quick up wg0
wg show
echo "[OK] $(date -Iseconds): Wireguard VPN Up."

exec "$@"
