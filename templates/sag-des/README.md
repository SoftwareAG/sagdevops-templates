# Digital Event Services

Use this template to provision Digital Event Services 10.1 and higher.

## Requirements

### Supported Software AG releases

List the releases for which the template is tested and supported.

* Command Central 10.1 and higher
* Digital Event Services 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new 10.1 or higher environments
* Installing latest fixes
* Configuration of:
  * Messaging Services

## Running as a composite template

Provision an instance of a Digital Event Services enabled runime,
for example [Integration Server](../sag-is-server/) default instance
on Windows.

Provision Digital Event Services into the default Integration Server
instance and configure default messaging service to point to the
[Universal Messaging realm server](../sag-um-server/) listening at `nsp://umhost:9000`:

 ```bash
 sagcc exec templates composite apply sag-des nodes=dev1 \
    repo.product=webMethods-10.1 \
    repo.fix=Empower \
    des.fixes=ALL \
    release.major=10 os.platform=w64 \
    des.instance.id=OSGI-IS_default \
    des.um.url=nsp://umhost:9000
```
