if [ -d "/root/workshop/node_modules/@aws-sdk" ]; then
    numberOfPackage=$(ls -la node_modules/@aws-sdk | grep -E 'client-s3|s3-request-presigner' | wc -l)
    [ $numberOfPackage -eq "2" ] && echo "done"
else 
    exit 1
fi