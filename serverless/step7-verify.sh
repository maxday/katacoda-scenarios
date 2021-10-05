if [ -d /root/workshop/.serverless ]; then
    if [ -z "$ENDPOINT" ]; then
        exit 1
    else 
        echo "done"
    fi
else
    exit 1
fi