#!/bin/sh -e

if [ -d $SAG_HOME/profiles/SPM/bin ]; then
    # start SPM in the background
    $SAG_HOME/profiles/SPM/bin/console.sh &
    # Ensure that 'docker stop' performs a clean server shutdown
    export SPM_PID=$!

    # self-register alias
    ALIAS=${CC_NODE_ALIAS:-`hostname`}

    if [[ "$CC_AUTO_REGISTER" -eq 1 && ! "$CC_SERVER" == "localhost" ]]; then
        echo "Registering '$ALIAS' with Command Central server '$CC_SERVER' ..."
        sagcc list landscape nodes --wait-for-cc
        sagcc add landscape nodes alias=$ALIAS url="https://`hostname`:8093" description="Auto registered docker node" -e OK -w 180 -c 20
        sagcc list landscape nodes

        # Ensure that 'docker stop' performs a clean SPM node unregistration
        trap "{ echo 'Unregistering node ...'; sagcc delete landscape nodes $ALIAS --force } " SIGTERM
        # wait $SPM_PID
    else
        echo "SKIP: Registration of '$ALIAS' with Command Central server '$CC_SERVER'"
        trap "echo 'Stopping SPM ...'; wait $SPM_PID" SIGTERM
    fi

else
    echo "WARNING: management agent (SPM) is not found"
fi
