#!/usr/bin/with-contenv bashio

python3 makeconfig.py
cat etc/ddclient/ddclient.conf
ip -6 addr show scope global
ddclient -foreground -verbose -debug

