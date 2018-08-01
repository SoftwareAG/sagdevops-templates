# Digital Event Services
 
Use this template to provision Digital Event Services 10.1 and higher.
 
 
## Requirements
 
### Supported Software AG releases
 
List the releases for which the template is tested and supported.
 
* Command Central 10.1 and higher
* Digital Event Services and higher
 
### Supported platforms
 
All supported Windows and UNIX platforms.
 
### Supported use cases
 
* Provisioning of new 10.1 or higher environments
* Installing latest fixes
* In-place upgrades and new host migration to 10.2
* Configuration of:
  * Event Types
  * Keystores
  * Messaging Services
  * Runtime Configuration
  * Service Groups
  * Truststores 
 
## Running as a composite template
Provision Digital Event Services on default IS instance on Windows
 ```bash
 sagcc exec templates composite apply sag-des nodes=dev1 \ 
  repo.product=webMethods-10.2 \
  repo.fix=Empower \
  des.fixes=ALL \
  release.major=10 os.platform=w64 \
  des.instance.id=OSGI-IS_default \
  um.url=nsp://localhost:9000
  ```
