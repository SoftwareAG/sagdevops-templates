# Configuring Digital Event Services

Use this template to configure Software AG Digital Event Services 10.2 and higher.

## Requirements

### Supported Software AG releases

* Command Central 10.2 or higher
* Digital Event Services 10.2 or higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Configuration of:
  * Truststores
  * Keystores
  * Messaging Services
  * Service Groups

## Running as a composite template

Provision an instance and a configuration of a runtime that is enabled for Digital Event Services, for example an [Integration Server](../sag-is-server/) default instance on Windows.

Provision Digital Event Services into the default Integration Server instance, configure truststore and keystore locations, configure the default messaging service with a username and a password for Universal Messaging, point the messaging service to the [Universal Messaging realm server](../sag-um-server/) that listens at `nsp://umhost:9000`, configure the messaging sevice to use the specified keystore and truststore, add a predefined digital event type to a service group, and configure that service group to use the messaging service:

 ```bash
 sagcc exec templates composite apply sag-des-config nodes=dev1 \
    des.instance.id=OSGI-IS_default \ 
	des.um.url=nsp://umhost:9000 \
	des.truststore.location=C:\SoftwareAG\UniversalMessaging\server\default\bin\nirvanacacerts.jks \
	des.keystore.location=C:\SoftwareAG\UniversalMessaging\server\default\bin\server.jks \
	des.service.name=sampleService \ 
	des.servicegroup.name=sampleServiceGroup
```
Provision Digital Event Services into the default [Apama correlator instance](../sag-apama-correlator), configure truststore and keystore locations,  configure the default messaging service with a username and a password for Universal Messaging, point the messaging service to the [Universal Messaging realm server](../sag-um-server/) that listens at `nsp://umhost:9000`, configure the messaging service to use the specified keystore and truststore, add a predefined digital event type to a service group, and configure that service group to use the messaging service:

 ```bash
 sagcc exec templates composite apply sag-des-config nodes=dev1 \
    des.instance.id=Apama-Correlator-default \ 
	des.um.url=nsp://umhost:9000 \
	des.truststore.location=C:\SoftwareAG\UniversalMessaging\server\default\bin\nirvanacacerts.jks \
	des.keystore.location=C:\SoftwareAG\UniversalMessaging\server\default\bin\server.jks \
	des.service.name=sampleService \ 
	des.servicegroup.name=sampleServiceGroup
```
