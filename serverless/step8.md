Let's now execute our first deployment!

Deploy the newly created service with the following command, this might take up to 1 or 2 minutes  
`serverless deploy --stage $STAGE`{{execute}}

*Reminder : as we all deploy to the same AWS account, the $STAGE environment variable which has been set at the very begining of the workshop will act as the discriminant*

If you have a `Plain object expected` error, please retry in 30 seconds as the deployment file might not have been saved yet.

Finally, let's save the endpoint URL as we will use it later  
`source saveEndpoint.sh`{{execute}}

You can see your endpoint with  
`echo $ENDPOINT`{{execute}}