#!/usr/bin/with-contenv bashio

python3 makeconfig.py
cat /etc/ddclient/ddclient.conf
chown root:root /etc/ddclient/ddclient.conf
echo =====
ip -6 addr show scope global
echo =====
ddclient -foreground -verbose -debug

