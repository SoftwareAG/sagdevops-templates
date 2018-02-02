## Using templates as composite templates

You can use the templates as standalone composite templates.

> IMPORTANT: Make sure you provision SPM nodes first before applying any runtime templates.

To provision SPM nodes use any of the `sag-spm-*` templates first and wait until it's done, for example:

```bash
sagcc exec templates composite apply sag-spm-local \
  cc.installer=cc-def-10.1-fix5-osx.sh install.dir=$HOME/sag/dev8192
sagcc list jobmanager jobs -e "\!RUNNING" -w 600
```

Then provision any runtime template on top of the provisioned nodes:

```bash
sagcc exec templates composite apply sag-um-server nodes=dev8192 \
    repo.product=products-10.1 repo.fix=fixes-10.1 um.numrealmserver.license.key=0000028393_NUMWF_10.1_PROD_LNXAMD64
sagcc list jobmanager jobs -e "\!RUNNING" -w 600
```
