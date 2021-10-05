if [ -f "/root/workshop/create-urls.js" ]; then
    cat /root/workshop/create-urls.js | grep "S3Client, PutObjectCommand, GetObjectCommand" || exit 1
    cat /root/workshop/create-urls.js | grep "module.exports.handler" || exit 1
    cat /root/workshop/create-urls.js | grep "process.env.BUCKET_NAME" || exit 1
    cat /root/workshop/create-urls.js | grep "Math.floor" || exit 1
    cat /root/workshop/create-urls.js | grep "processedOptions" || exit 1
    cat /root/workshop/create-urls.js | grep "const signedUrl" || exit 1
    cat /root/workshop/create-urls.js | grep "JSON.stringify" || exit 1
else 
    exit 1
fi