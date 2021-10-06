Now that our project is created, let's write our first Lambda function code.
As a reminder, this function will be responsible to create and output three diferent URLs.
- The first one will be our endpoint to upload an image
- The second one to view the unprocessed image
- The third one to view the processed image

Our code will rely on two dependencies that we are going to install thanks to `npm`

The first one is the S3 Client SDK provided by AWS. Let's install it with  
`npm install --save @aws-sdk/client-s3@3.34.0`{{execute}}

The second one will allow us to created signed URL to prevent exposing publicly our S3 bucket, let's install it with  
`npm install --save @aws-sdk/s3-request-presigner@3.34.0`{{execute}}


You can now check if both dependencies are correctly installed. They should be output when running  
`ls -la node_modules/@aws-sdk | grep -E 'client-s3|s3-request-presigner'`{{execute}}

Great! Our dependencies are now installed! Let's write our first handler in the next step