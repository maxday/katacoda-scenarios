if [ -f "/root/workshop/create-urls.js" ]; then
    cat /root/workshop/create-urls.js | grep -q "datadog-lambda-js"  || exit 1
    cat /root/workshop/create-urls.js | grep -q "sendDistributionMetric(" || exit 1
    echo "done"
else 
    exit 1
fi