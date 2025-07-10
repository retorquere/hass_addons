#!/usr/bin/with-contenv bashio

python makeconfig.py
cat etc/ddclient/ddclient.conf
ddclient -foreground -verbose -debug

