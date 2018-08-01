#!/bin/sh

$SAG_HOME/register.sh

# TODO: replace this with actual EXX Broker from $EXXDIR/bin !
tail -f $SAG_HOME/profiles/SPM/logs/wrapper.log
