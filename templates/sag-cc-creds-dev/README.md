# Command Central credential keys configuration examples

This template demonstrates show to configure different types of credentials
for accessing repositories and remote hosts:

* Using basic username/password authentication type
* Using SSH private key authentication type
* Using encrypted passwords

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

## How to encrypt passwords

* Open Command Central Web UI
* Open CCE > Command Central > Configurations > Credentials
* Click + icon and select *Username and password* type from the menu
* Provide required fields, including password. Save configuration
* Click on newly created configuration and click *Export*
* Use the encrypted value of the `Password:` property

The value can be stored in .yaml or .properties file and placed in version control system.
