Now that our custom metric is here, let's redeploy our service using the `serverless` framework once again  
`serverless deploy --stage $STAGE`{{execute}}

Now let's simulate again some traffic by calling 3 times our function  
`for i in {1..3}; do upload.sh "$ENDPOINT" testimage.jpg; done`{{execute}}

Go back to the Datadog UI

1. Make sure you select a large enough time span (like 1 hour)
2. In `Graph:` enter the name of your metric which is `create_urls.request`
3. You should see some data points corresponding to your invocations

*Again feel free to add some tags to filter out only your function for instance*
