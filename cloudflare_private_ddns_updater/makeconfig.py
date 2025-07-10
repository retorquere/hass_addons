import json
import os
import sys
import netifaces
import ipaddress
from types import SimpleNamespace

def get_gua():
  for interface_name in netifaces.interfaces():
    try:
      addresses = netifaces.ifaddresses(interface_name)
      if netifaces.AF_INET6 not in addresses: continue

      for addr_info in addresses[netifaces.AF_INET6]:
        ip_str = addr_info.get('addr')
        if not ip_str: continue

        # Clean up any scope ID suffix (e.g., %eth0)
        ip_str = ip_str.split('%')[0]

        try:
          ip_obj = ipaddress.ip_address(ip_str)
          if ip_obj.is_global:
            return str(ip_obj)
        except ipaddress.AddressValueError:
          # Not a valid IP address string, skip
          continue
    except ValueError:
      # netifaces.ifaddresses can raise ValueError for non-existent interfaces
      pass

with open('/etc/ddclient/ddclient.conf', 'w') as f:
  f.write(f'''
daemon=300
syslog=yes
pid=/run/ddclient/ddclient.pid
ip={get_gua()}
''')
  for config in json.load(open('/data/options.json'), object_hook=lambda x: SimpleNamespace(**x)).config:

    f.write(f'''
protocol=cloudflare
zone={config.zone}
ttl=1
login=token
password={config.token}
{config.domains}
''')
