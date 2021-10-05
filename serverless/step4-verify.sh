cd /root/workshop
if [ -f "/usr/bin/jest" ]; then
    jest
    if [ "$?" -ne 0 ]; then
        exit 1
    else
        exit 0
    fi
else 
    exit 1
fi