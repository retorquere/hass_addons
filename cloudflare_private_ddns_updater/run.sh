#!/usr/bin/with-contenv bashio

CONFIG="/etc/ddclient/ddclient.conf"

cat > "$CONFIG" << EOL
daemon=300
syslog=yes
pid=/run/ddclient/ddclient.pid
use=cmd, cmd='ip -6 addr show scope global | sed -n "/inet6 [23]/ { s/.*inet6 \([^ ]*\)\/.*/\1/p; q }" '
EOL

DDCLIENT_CONFIG=$(bashio::config 'config')

# Process each JSON object in the config
echo "$DDCLIENT_CONFIG" | while IFS= read -r line; do
    # Skip empty lines
    [ -z "$line" ] && continue
    
    # Parse the JSON and create config section
    zone=$(echo "$line" | jq -r '.zone')
    token=$(echo "$line" | jq -r '.token')
    domains=$(echo "$line" | jq -r '.domains')
    
    # Append configuration section for this entry
    cat >> "$CONFIG" << EOL
protocol=cloudflare
zone=${zone}
ttl=1
login=token
password=${token}
${domains}
EOL
done

# Start ddclient
cat "$CONFIG"
ddclient -foreground -verbose -debug

