#!/usr/bin/with-contenv bashio

python3 makeconfig.py
cat etc/ddclient/ddclient.conf
ddclient -foreground -verbose -debug

