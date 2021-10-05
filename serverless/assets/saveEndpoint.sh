sls info --stage=$STAGE | grep -o "\S*images\/uploads\b" > /tmp/endpoint
export ENDPOINT=$(cat /tmp/endpoint)