# Apama Correlator

This template can install Apama, create an Apama correlator instance and deploy
a simple Apama application.

This is a reference template that comprehensively demonstrates all possible
correlator configuration that can be applied using a composite template. It
exists for informational purposes only; it is not a well-rounded sample
application that you should build upon.

## Requirements

### Supported Software AG releases

* Apama 10.2 and higher
* Command Central 10.2 and higher

### Supported platforms

All supported Windows and UNIX platforms.

### Supported use cases

* Provisioning of new environments at 10.2 or higher
* Installing latest fixes
* Creating a correlator instance and deploying a simple EPL application to it
* Configuration of:
  * License
  * Ports
  * Logging
  * Persistence
  * All other supported correlator configuration items

## Running as a composite template

When importing the composite template to Command Central, you will have to
attach the simple 'HelloWorld' application. Encapsulate the `template.yaml` and
`HelloWorld.zip` into a single Zip file and import that using the `sagcc`
tooling:

```bash
sagcc exec templates composite import -i template.zip
```

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)
for general information about applying templates.

Provision `default` instance of an Apama 10.2 correlator with all the
latest fixes, listening on port 15904:

```bash
sagcc exec templates composite apply sag-apama-correlator nodes=sag1 \
  repo.product=webMethods-10.2 \
  repo.fix=Empower \
  os.platform=LNXAMD64 \
  --sync-job --wait 360
```

## Adding as a runtime layer to a stack

Once imported, this template can also be used as a runtime layer for stacks,
using either the CLI or the web UI.

Consult [Creating a stack using Command Central Web UI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#creating-a-new-stack-using-web-ui)
for additional information about using Stacks UI.
