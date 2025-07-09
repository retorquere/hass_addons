#!/usr/bin/with-contenv bashio

CONFIG="/etc/ddclient/ddclient.conf"

# Get the entire free-form content of the 'config' option.
# This will now contain the full ddclient.conf text.
DDCLIENT_FULL_CONFIG_CONTENT=$(bashio::config 'config')

# Create the directory for ddclient config if it doesn't exist
mkdir -p "$(dirname "$CONFIG")"

# Write the content directly to the ddclient.conf file
echo "${DDCLIENT_FULL_CONFIG_CONTENT}" > "$CONFIG"

# Set secure permissions for the config file
chmod 600 "$CONFIG"

bashio::log.info "ddclient.conf created with content:"
bashio::log.info "$(cat "$CONFIG")" # Log the content for verification/debugging

# Start ddclient in foreground mode.
# It will read its daemon interval from the config file itself if specified (e.g., daemon=300).
# The 'exec' command ensures ddclient becomes the main process of the container.
exec ddclient -foreground -verbose -debug
