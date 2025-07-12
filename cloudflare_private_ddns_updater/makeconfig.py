import json
import os
import sys
import netifaces
import ipaddress
from types import SimpleNamespace

def get_ips():
  ipv4 = None
  ipv6 = None

  for interface_name in netifaces.interfaces():
    if ipv4 and ipv6: break

    try:
      addresses = netifaces.ifaddresses(interface_name)
    except ValueError:
      # netifaces.ifaddresses can raise ValueError for non-existent interfaces
      continue

    if not ipv4 and netifaces.AF_INET in addresses:
      for link in addresses[netifaces.AF_INET]:
        ip_str = link.get('addr')
        if not ip_str: continue

        if not ip_str.startswith('127.') and ip_str != '0.0.0.0':
          ipv4 = ip_str
          break

    if not ipv6 and netifaces.AF_INET6 in addresses:
      for link in addresses[netifaces.AF_INET6]:
        ip_str = link.get('addr')
        if not ip_str: continue

        # Clean up any scope ID suffix (e.g., %eth0)
        ip_str = ip_str.split('%')[0]

        try:
          ip_obj = ipaddress.ip_address(ip_str)
          if ip_obj.is_global:
            ipv6 = str(ip_obj)
            break
        except ipaddress.AddressValueError:
          # Not a valid IP address string, skip
          continue

  return (ipv4, ipv6)

with open('/etc/ddclient/ddclient.conf', 'w') as f:
  ipv4, ipv6 = get_ips()

  f.write('daemon=300\n')
  f.write('syslog=yes\n')
  f.write('ssl=yes\n')
  f.write('pid=/run/ddclient/ddclient.pid\n')

  for config in json.load(open('/data/options.json'), object_hook=lambda x: SimpleNamespace(**x)).config:
    f.write('\nprotocol=cloudflare\n')
    f.write(f'zone={config.zone}\n')
    f.write('ttl=1\n')
    f.write('login=token\n')
    f.write(f'password={config.token}\n')
    f.write(f'ip={ipv4}\n' if ipv4 else 'usev4=no\n')
    f.write(f'ip6={ipv6}\n' if ipv6 else 'usev6=no\n')
    f.write(f'{config.domains}\n')
