# Command Central credential keys configuration examples

This template demonstrates show to configure different types of credentials
for accessing repositories and remote hosts:

* Using basic username/password authentication type
* Using SSH private key authentication type

## Requirements

### Supported Software AG releases

* Command Central 10.1 or later

### Supported platforms

* All support platforms

## Running as a standalone Composite Template

Configure credentials

```bash
sagcc exec templates composite apply sag-cc-creds-dev cc.password=mycustompass --sync-job --wait 20 -c 5
```
