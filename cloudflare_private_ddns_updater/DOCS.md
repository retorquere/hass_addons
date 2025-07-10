## DDNS Updater

This addon is used to update a DDNS record using ddclient. You can use this to set up SSL inside your home network:

* Add an AAAA record in your cloudflare DNS config (ag `hass.your.domain`). **DO NOT** enter an A record for this hostname. Set it to non-proxied.
* Install this add-on and configure it (see below).
* Set up letsencrypt for cloudflare
* Add the certs to your `configuration.yaml` (see below)
* Add `hass.your.domain` to your modem DNS rebinding exceptions
* Set `https://hass.your.domain:8123` as your home assistant URL in the network settings

and you now have a proper SSL certificate, no self-sign warnings, no need to install trusted certs

## Configuration

```yaml
config:
  - zone: example.com
    token: <token from cloudflare>
    domains: my.example.com,www.example.com
  - zone: acme.com
    token: <token from cloudflare>
    domains: my.acme.com,www.acme.com
```

`configuration.yaml`:

```
http:
  ssl_certificate: /ssl/fullchain.pem
  ssl_key: /ssl/privkey.pem
```
