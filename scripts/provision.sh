#!/bin/sh
set -e

echo "Configuring Command Central ..."
echo com.softwareag.platform.management.client.template.composite.skip.restart.runtimes=true>>$CC_HOME/profiles/CCE/configuration/config.ini

echo "Starting up Command Central ..."
$CC_HOME/profiles/SPM/bin/startup.sh
$CC_HOME/profiles/CCE/bin/startup.sh

# just in case
export CC_CLI_HOME=$CC_HOME/CommandCentral/client
export PATH=$PATH:$CC_CLI_HOME/bin

sagcc get monitoring runtimestatus local OSGI-CCE-ENGINE -e ONLINE -c 15 --wait-for-cc 300 -w 240

echo "Command Central is ONLINE"

echo "List of installed products:"
sagcc list inventory products nodeAlias=local properties=product.displayName,product.version.string
echo "List of installed fixes:"
sagcc list inventory fixes nodeAlias=local properties=fix.displayName,fix.version

# globals
MAIN_TEMPLATE_ALIAS=${1}
NODES=${NODES:-node}

echo "Provisioning template alias '$MAIN_TEMPLATE_ALIAS' into nodes '$NODES'"

INIT_TEMPLATE_ALIAS=${INIT_TEMPLATE_ALIAS:-init}
CC_CLEANUP=${CC_CLEANUP:-0}
CC_WAIT=${CC_WAIT:-3600}

propfile=/tmp/.env.properties
rm -f $propfile

ADD_PROPERTIES=""
if [ -f build.properties ]; then
    echo "Found build.properties. Resolving envrionment variables ..."
    envsubst<build.properties>$propfile
    ADD_PROPERTIES=" -i $propfile "
fi

# Extract all environment variables those having the prefix "__" 
# and appends them to the .properties after converting _ to .
env | while IFS='=' read -r name value; do
	if [[ $name == '__'* ]]; then
        ADD_PROPERTIES=" -i $propfile "
		#echo "name=$name"
		#echo "value=$value"
		#remove "__" from the environment variable name and use the remainder as the key... 
		key=${name:2}
        #echo "key=$key"
        #...but only after converting the keys to the regular parameter names by replacing  the bash-acceptable "_" with "."
        echo "${key//_/.}: ${value}" >> $propfile
	fi
done

if [ "$ADD_PROPERTIES" != "" ]; then
    echo "=================================="
    echo "Resolved template .properties file"
    echo "=================================="
    cat $propfile
    echo "=================================="
else
    echo "WARNING: No .properties or environment variables are defined! Provisioning will use template defaults."
fi

tail -f $CC_HOME/profiles/CCE/logs/default.log &
tail1PID=$!

# if [ -f init.yaml ]; then
#     echo "Found init.yaml. Importing ..."
#     # replacing template alias as 'container'
#     templatefile=/tmp/i.yaml
#     templatealias=init
#     echo alias: $INIT_TEMPLATE_ALIAS>$templatefile && tail -n +2 init.yaml>>$templatefile
#     cat $templatefile    
#     sagcc exec templates composite import -i $templatefile overwrite=true

#     echo "Validating ..."
#     sagcc exec templates composite validate $INIT_TEMPLATE_ALIAS $ADD_PROPERTIES --sync-job -e DONE -c 3 -w 60
#     echo "Applying init template $INIT_TEMPLATE_ALIAS..."
#     sagcc exec templates composite apply $INIT_TEMPLATE_ALIAS $ADD_PROPERTIES --sync-job -e DONE -c 3 -w 60
#     echo "Initialization SUCCESSFULL"
# else
#     echo "SKIP: Initialization. No init.yaml found"
# fi

if [ -f "$SAG_HOME/profiles/SPM/bin/startup.sh" ]; then
    echo "Found managed node in '$SAG_HOME'. SKIP: bootstrapping"
    echo "Starting SPM ..."
    $SAG_HOME/profiles/SPM/bin/startup.sh
    echo "Waiting for SPM to come up ..."
    sagcc get landscape nodes $NODES -e ONLINE -w 240

    echo "Infrastructure SUCCESSFULL"
else
    echo "NO managed node in '$SAG_HOME' found"

    if [ -z $CC_INSTALLER ]; then
        echo "SKIP: No bootstrapper. Cannot bootstrap '$SAG_HOME'!"
    else
        sagcc_installer="${CC_INSTALLER}.sh"

        if [ -f $CC_HOME/profiles/CCE/data/installers/$sagcc_installer ]; then
            echo "Found '$sagcc_installer'. SKIP: downloading installer."
        else
            echo "Downloading '$sagcc_installer' ..."
            mkdir -p $CC_HOME/profiles/CCE/data/installers
            curl -o $CC_HOME/profiles/CCE/data/installers/$sagcc_installer "${CC_INSTALLER_URL}/${sagcc_installer}"
            chmod +x $CC_HOME/profiles/CCE/data/installers/$sagcc_installer
        fi
        echo "Bootstrapping '$SAG_HOME' using '$sagcc_installer' ..."
        sh $CC_HOME/profiles/CCE/data/installers/$sagcc_installer -D SPM -d $SAG_HOME -H localhost -p manage -s 8092 -S 8093

        echo "Deleting '$sagcc_installer' ..."
        rm -f $CC_HOME/profiles/CCE/data/installers/$sagcc_installer
        
        echo "Registering managed installation as '$NODES' ..."
        sagcc add landscape nodes alias=$NODES url=http://localhost:8092 -e OK

        echo "Waiting for SPM to come up ..."
        sagcc get landscape nodes $NODES -e ONLINE

        echo "Infrastructure SUCCESSFULL"
    fi
fi

if [ -z $MAIN_TEMPLATE_ALIAS ] ; then 
    if [ -f template.yaml ]; then
        echo "Found template.yaml. Importing ..."
        # replacing template alias as 'container'
        templatefile=/tmp/t.yaml
        MAIN_TEMPLATE_ALIAS=container
        echo alias: $MAIN_TEMPLATE_ALIAS>$templatefile && tail -n +2 template.yaml>>$templatefile
        cat $templatefile
        echo "Importing template ..."
        sagcc exec templates composite import -i $templatefile overwrite=true
    else
        echo "ERROR: No template.yaml found nor template alias is provided!"
        exit 1
    fi
fi

# additional parameters
ADD_PROPERTIES="$ADD_PROPERTIES node=$NODES nodes=$NODES repo.product=$REPO_PRODUCT repo.fix=$REPO_FIX release=$RELEASE os.platform=lnxamd64 "

# echo "Validating template ..."
# sagcc exec templates composite validate $MAIN_TEMPLATE_ALIAS $ADD_PROPERTIES --sync-job -e DONE -c 3 -w 60

tail -f $SAG_HOME/profiles/SPM/logs/default.log &
tail2PID=$!

echo "Applying template $MAIN_TEMPLATE_ALIAS and waiting up to $CC_WAIT seconds ..."
sagcc exec templates composite apply $MAIN_TEMPLATE_ALIAS $ADD_PROPERTIES --sync-job -c 20 -e DONE --wait-for-cc 300 --retry 1
echo "Provisioning SUCCESSFULL"

echo "Stop tailing logs ..."
kill -9 $tail1PID $tail2PID

echo "Removing logs ..."
rm -rf $SAG_HOME/profiles/SPM/logs/*
rm -rf $SAG_HOME/common/conf/nodeId.txt

echo "BUILD SUCCESSFULL"
