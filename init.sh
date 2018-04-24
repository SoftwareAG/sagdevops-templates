#!/bin/sh

sagcc list inventory products --wait-for-cc && \
curl -o licenses.zip $LICENSES_URL && \
sagcc add license-tools keys -i licenses.zip && \
rm licenses.zip && \
sagcc exec templates composite apply sag-cc-creds-dev --sync-job -c 5 && \
sagcc exec templates composite apply sag-cc-builder-dev --sync-job -c 5
#repo.product=$REPO_PRODUCT repo.fix=$REPO_FIX repo.host=$REPO_HOST --sync-job
