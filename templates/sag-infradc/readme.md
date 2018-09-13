# Infrastructure Data Collector
Use this template to provision or migrate Infrastructure Data Collector(10.1 or higher)
 
## Requirements and limitations 
None
 
### Supported Software AG releases
List the releases for which the template is tested and supported.
 
* Command Central 10.1 and higher
* Infrastructure Data Collector 10.1 or higher
 
### Supported platforms
All supported Windows and UNIX platforms.
  
### Supported use cases
* Provisioning of new 10.1, or 10.3 environments
* Migrate to 10.1 or 10.3 environments
* Installing latest fixes and support patches
* Configuration of:
Infrastructure Data Collector Metatdata
Infrastructure Data Collector Port Configuration
Infrastructure Data Collector Memory Configuration

   
## Running as a composite template 
Explain or show with examples how to run the sample template as a composite template.

To import the sag-designer-cloudstreams/template.yaml file in Command Central, use one of the methods described in "Importing templates library" (https://github.com/SoftwareAG/sagdevops-templates/wiki/Importing-templates-library)
To apply the template, follow the instructions in "Applying template using Command Central CLI" (https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)

Example:
To provision Infrastructure Data Collector on the installation with alias localhost:
sagcc exec templates composite apply sag-infradc node=localhost infradc.jms.host=localhost repo.product=SuiteInt repo.fix=GA_Fix_Repo --sync-job --wait 360
To migrate Infrastructure Data Collector on the installation with alias localhost:
sagcc exec templates composite apply sag-infradc-migrate node=localhost src.spm.host=localhost src.spm.alias=localhost spm.port=9400 spm.alias=localhost infradc.jms.host=localhost os.username=<username> os.password=<password> repo.product=products-10.2 repo.fix=fixes-10.2 environment.mode=migration --sync-job --wait 360
