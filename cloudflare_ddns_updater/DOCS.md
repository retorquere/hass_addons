## Cloudflare DDNS Updater

This addon is used to update a DDNS record on Cloudflare.

## Requirements
* A Cloudflare account
* A domain name setup to use Cloudflare as the DNS provider

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

## Token

The token is an Account API token from Cloudflare.

The token is created under Manage Account -> Account API Tokens -> Create Token

It must have the permissions: 
 - Zone - DNS - Edit
 - Zone - Zone - Read
 - The Zone resources must be "Include - All" (or your specific account)

## How it works

The addon will check the current public IP address of the home network and update the DDNS record for the domains in the configuration.
