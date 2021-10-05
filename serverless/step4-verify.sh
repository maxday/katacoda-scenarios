cd /root/workshop
if [ -f "/usr/bin/jest" ]; then
    jest
    if [ "$?" -ne 0 ]; then
        exit 1
    else
        echo "done"
    fi
else 
    exit 1
fi