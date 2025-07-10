## DDNS Updater

This addon is used to update a DDNS record using ddclient

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

