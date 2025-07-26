#!/usr/bin/with-contenv bashio

python3 makeconfig.py
echo ===== ddclient.conf ===== 
cat /etc/ddclient/ddclient.conf
echo ===== ddclient.conf ===== 
chown root:root /etc/ddclient/ddclient.conf
ddclient -foreground -verbose -debug

