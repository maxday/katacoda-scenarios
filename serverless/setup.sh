#!/bin/bash
echo "IN SETUP"
touch toto
# SETUP_ENDPOINT="https://r8or7hfmbh.execute-api.us-east-1.amazonaws.com/366BBD238B78B97F92EAD8B529DA057FC6354B37/maxday-setup"
# RESULT=$( curl -s "$SETUP_ENDPOINT" )

# export AWS_DEFAULT_REGION=$( echo $RESULT | jq -r .region )
# export AWS_ACCESS_KEY_ID=$( echo $RESULT | jq -r .key )
# export AWS_SECRET_ACCESS_KEY=$( echo $RESULT | jq -r .secret )
# export DATADOG_API_KEY=$( echo $RESULT | jq -r .apiKey )
