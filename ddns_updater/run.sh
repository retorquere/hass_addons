#!/usr/bin/with-contenv bashio

CONFIG="/etc/ddclient/ddclient.conf"

DDCLIENT_FULL_CONFIG_CONTENT=$(bashio::config 'config')

DAEMON=$(bashio::config 'daemon')
TIMEOUT=$(bashio::config 'timeout')
SYSLOG=$(bashio::config 'syslog')
USE=$(bashio::config 'use')
PROTOCOL=$(bashio::config 'protocol')
LOGIN=$(bashio::config 'login')
PASSWORD=$(bashio::config 'password')
DOMAINS=$(bashio::config 'domains)

# Create the directory for ddclient config if it doesn't exist
mkdir -p "$(dirname "$CONFIG")"

echo "deamon=${DAEMON}" > "$CONFIG"
echo "timeout=${TIMEOUT}" >> "$CONFIG"
echo "syslog=${SYSLOG}" >> "$CONFIG"
echo "pid=/run/ddclient/ddclient.pid" >> "$CONFIG"
echo "use=${USE}" >> "$CONFIG"
echo "protocol=${PROTOCOL}, login=${LOGIN}, password=${PASSWORD} ${DOMAINS}" >> "$CONFIG"

# Set secure permissions for the config file
chmod 600 "$CONFIG"

bashio::log.info "ddclient.conf created with content:"
bashio::log.info "$(cat "$CONFIG")" # Log the content for verification/debugging

# Start ddclient in foreground mode.
# It will read its daemon interval from the config file itself if specified (e.g., daemon=300).
# The 'exec' command ensures ddclient becomes the main process of the container.
exec ddclient -foreground -verbose -debug
