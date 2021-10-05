#!/bin/bash

echo "Please type the first name of your first name + last name"
echo "For instance my name is Maxime David so I'll type : mdavid"
read -p  "Input : " stageName

export STAGE=$stageName

SETUP_ENDPOINT="https://r8or7hfmbh.execute-api.us-east-1.amazonaws.com/366BBD238B78B97F92EAD8B529DA057FC6354B37/maxday-setup"
RESULT=$( curl -s "$SETUP_ENDPOINT" )

export AWS_DEFAULT_REGION=$( echo $RESULT | jq -r .region )
export AWS_ACCESS_KEY_ID=$( echo $RESULT | jq -r .key )
export AWS_SECRET_ACCESS_KEY=$( echo $RESULT | jq -r .secret )
export DATADOG_API_KEY=$( echo $RESULT | jq -r .apiKey )

echo "All good! The stage has been set up to $STAGE, you can go to the next step"

mkdir -p /root/workshop && cd /root/workshop
touch /tmp/step0OK