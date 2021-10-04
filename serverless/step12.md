Now that our custom metric is here, let's redeploy our service using the `serverless` framework once again
`serverless deploy --stage $stage`{{execute}}

Now let's simulate again some traffic by calling 3 times our function
`for i in {1..3}; do ./upload.sh "$ENDPOINT" "$STAGE" testimage.jpg; done`{{execute}}

Finally let's go the Datadog UI and search for your metric : 

[Go to Metrics Explorer](https://app.datadoghq.com/metric/explorer)

1. Make sure you select a large enough time span (like 1 hour)
2. In `graph` enter the name of your metric which is `create_urls.request`
3. You should see some data points corresponding to your invocations
