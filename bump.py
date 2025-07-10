#!/usr/bin/env python3

import yaml
import os
import sys
from packaging.version import Version

addon_config_path = 'cloudflare_private_ddns_updater/config.yaml'

with open(addon_config_path, 'r') as f:
  config = yaml.safe_load(f)

version = Version(config['version'])

config['version'] = f'{version.major}.{version.minor}.{version.micro + 1}'

with open(addon_config_path, 'w') as f:
  yaml.safe_dump(config, f, default_flow_style=False, sort_keys=False)

