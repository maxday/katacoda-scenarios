Our application is now COMPLETED!

Let's redeploy one last time our service using the `serverless` framework once again  
`serverless deploy --stage $STAGE`{{execute}}

Don't forget to instrument our new function with `Datadog CLI`
`datadog-ci lambda instrument --function process-image-$STAGE -r us-east-1 --extensionVersion 11 --layerVersion 63 --service $STAGE | tee /tmp/ddOutput2`{{execute}}

Now re-run the script to upload a picture and this time, you should be able to see the processed image.
Open the link displayed in `Public processed image URL`
`upload.sh "$ENDPOINT" testimage.jpg`{{execute}}

Woot woot congrats! You've just deployed a full serverless application

Let's simulate some traffic by calling 3 times our function
`for i in {1..3}; do upload.sh "$ENDPOINT" testimage.jpg; done`{{execute}}

And see you in the very final step!
