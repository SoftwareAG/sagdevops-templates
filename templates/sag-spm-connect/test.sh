#!/bin/sh -e

echo "Verifying connected node ..."
sagcc get landscape nodes -e localhost --wait-for-cc
