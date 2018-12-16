#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   haproxy-systemd-wrapper -- "master-worker mode" (similar to the new "-W" flag; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- "$(which haproxy-systemd-wrapper)" -p /run/haproxy.pid -db "$@"
fi

export
# Available ENV VAR inside container
sed -i -e "s/@@HOST@@/$HOST/" /usr/local/etc/haproxy/haproxy.cfg
# DCOS named port definition 'BACKEND'
sed -i -e "s/@@PORT_frontend@@/$PORT_frontend/" /usr/local/etc/haproxy/haproxy.cfg

# Inject this as a EN VARs in the container definition
sed -i -e "s/@@HOST_BACKEND@@/$HOST_BACKEND/" /usr/local/etc/haproxy/haproxy.cfg
sed -i -e "s/@@PORT_BACKEND@@/$PORT_BACKEND/" /usr/local/etc/haproxy/haproxy.cfg

exec "$@"