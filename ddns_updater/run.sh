#!/usr/bin/with-contenv bashio

CONFIG=$(bashio::config 'config')

bashio::log.info "ddclient started with content:"
bashio::log.info "$(cat "$CONFIG")" # Log the content for verification/debugging

# Start ddclient in foreground mode.
# It will read its daemon interval from the config file itself if specified (e.g., daemon=300).
# The 'exec' command ensures ddclient becomes the main process of the container.
exec ddclient -foreground -verbose -debug -file "$CONFIG"
