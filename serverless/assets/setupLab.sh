#!/bin/bash

export STAGE=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

SETUP_ENDPOINT="https://r8or7hfmbh.execute-api.us-east-1.amazonaws.com/366BBD238B78B97F92EAD8B529DA057FC6354B37/maxday-setup"
RESULT=$( curl -s "$SETUP_ENDPOINT" )

export AWS_DEFAULT_REGION=$( echo $RESULT | jq -r .region )
export AWS_ACCESS_KEY_ID=$( echo $RESULT | jq -r .key )
export AWS_SECRET_ACCESS_KEY=$( echo $RESULT | jq -r .secret )

# need to redirect err output tu null to avoid
# rm: cannot remove '/usr/local/bin/prepenvironment'
curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash 2> /dev/null

export DATADOG_API_KEY=$DD_API_KEY

echo "All good! The stage has been set up to >$STAGE<, you can go to the next step"

mkdir -p /root/workshop && cd /root/workshop
touch /tmp/step0OK