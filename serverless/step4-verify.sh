if [ -f "/root/workshop/create-urls.js" ]; then
    cat /root/workshop/create-urls.js | grep -q "S3Client, PutObjectCommand, GetObjectCommand"  || exit 1
    cat /root/workshop/create-urls.js | grep -q "module.exports.handler" || exit 1
    cat /root/workshop/create-urls.js | grep -q "process.env.BUCKET_NAME" || exit 1
    cat /root/workshop/create-urls.js | grep -q "Math.floor" || exit 1
    cat /root/workshop/create-urls.js | grep -q "processedOptions" || exit 1
    cat /root/workshop/create-urls.js | grep -q "const signedUrl" || exit 1
    cat /root/workshop/create-urls.js | grep -q "JSON.stringify" || exit 1
    echo "done"
else 
    exit 1
fi