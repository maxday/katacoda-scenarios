#!/usr/bin/env bash
set -e

print_usage () {
    echo 'Usage: upload.sh <stage> <file>'
}

if [ "$#" -ne 2 ]; then
    print_usage
    exit 1
fi

STAGE="$1"
FILE="$2"

ENDPOINT=$(sls info --stage=$STAGE | grep -o "\S*images\/uploads\b" )

echo "Requesting presigned URL from ${ENDPOINT}"
echo ""
SIGNED_RESULT=$( curl -s -d "" "$ENDPOINT" )

UPLOAD_URL=$( echo $SIGNED_RESULT | jq -r .uploadUrl )
UNPROCESSED_IMAGE_URL=$( echo $SIGNED_RESULT | jq -r .unprocessedUrl )
PROCESSED_IMAGE_URL=$( echo $SIGNED_RESULT | jq -r .processedUrl )

echo "Uploading to : "
echo "--" 
echo ${UPLOAD_URL}
echo "--"

curl -s -X PUT -H "Content-Type: image/jpeg" --upload-file ${FILE} $UPLOAD_URL

echo "Public unprocessed image URL: "
echo ""
echo ${UNPROCESSED_IMAGE_URL}
echo "--"
echo "Public processed image URL: "
echo ""
echo ${PROCESSED_IMAGE_URL}
echo "--"