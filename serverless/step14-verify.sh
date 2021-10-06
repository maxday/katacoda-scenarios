if [ -f "/root/workshop/create-urls.js" -a -d /root/workshop/node_modules/datadog-lambda-js ]; then
    cat /root/workshop/create-urls.js | grep -q "datadog-lambda-js"  || exit 1
    cat /root/workshop/create-urls.js | grep -q "sendDistributionMetric(" || exit 1
    cat /root/workshop/create-urls.spec.js | grep -q "datadog-lambda-js" || exit 1
    echo "done"
else 
    exit 1
fi