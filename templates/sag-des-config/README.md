# Configuring Digital Event Services

Use this template to configure Digital Event Services 10.1 and higher.

## Requirements

### Supported Software AG releases

List the releases for which the template is tested and supported.

* Command Central 10.1 and higher
* Digital Event Services 10.1 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

	* Configuration of:
  * Truststores
  * Keystores
  * Messaging Services
  * Service Groups

## Running as a composite template

Provision an instance and configuration of a Digital Event Services enabled runime,
for example [Integration Server](../sag-is-server/) default instance
on Windows.

Provision Digital Event Services into the default Integration Server
instance, configure truststore and keystore locations, configure default messaging service to point to the
[Universal Messaging realm server](../sag-um-server/) with a username and password, 
listening at `nsp://umhost:9000`, point it to use the configured keystore and truststore, 
add a predefined Event Type to a Service Group and configure that group to work with the messaging service:

 ```bash
 sagcc exec templates composite apply sag-des-config nodes=dev1 \
    des.instance.id=OSGI-IS_default \ 
	des.um.url=nsp://umhost:9000 \
	des.truststore.location=C:\SoftwareAG\UniversalMessaging\server\umserver\bin\nirvanacacerts.jks \
	des.keystore.location=C:\SoftwareAG\UniversalMessaging\server\umserver\bin\server.jks \
	des.service.name=sampleService \ 
	des.servicegroup.name=sampleServiceGroup
```
