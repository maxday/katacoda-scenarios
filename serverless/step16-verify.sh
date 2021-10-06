if [ -d "/root/workshop/node_modules/jimp" ]; then
    if [ -d "/root/workshop/trigger.js" ]; then
        cat /root/workshop/trigger.js | grep -q "exports.handler" || exit 1
        echo "done"
    else 
        exit 1
    fi
else 
    exit 1
fi