if [ -f "/usr/bin/datadog-ci" ]; then
    cat /tmp/ddOutput2 | grep -q "Datadog-Extension"  || exit 1
    cat /tmp/ddOutput2 | grep -q "Datadog-Node14-x"  || exit 1
    echo "done"
else 
    exit 1
fi