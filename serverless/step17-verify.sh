if [ -f "/root/workshop/trigger.spec.js" ]; then
    cat /root/workshop/trigger.spec.js | grep -q "const validRecord" || exit 1
    echo "done"
else 
    exit 1
fi