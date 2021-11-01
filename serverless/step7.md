The `serverless` framework is now installed, let's write our first deployment file!

*Once again, in this step, you don't need to write any code, make sure you understand the code, then click on `Copy to editor` on the following code snippet* 

This file will describe what we want to deploy. Here we are going to deploy :

* our function
* an HTTP Gateway to expose our function so it can be reached
* some IAM policies to access/get our S3 items

<pre class="file" data-filename="serverless.yml" data-target="replace">
service: serverless-workshop-service

configValidationMode: error

custom:
  #This is the bucket where images will be stored
  imageBucketName: serverless-workshop-image-${self:provider.stage}

provider:
  name: aws
  stage: ${opt:stage}
  region: us-east-1
  lambdaHashingVersion: 20201221
  deploymentBucket:
    name: serverless-workshop-deployment
  environment:
    # These environment variables will be set on our functions
    BUCKET_NAME: ${self:custom.imageBucketName}
    STAGE: ${self:provider.stage}
    
  iam:
    role:
      statements:
        - Effect: "Allow"
          Action:
            - "s3:PutObject"
            - "s3:PutObjectAcl"
            - "s3:GetObject"
          Resource: "arn:aws:s3:::${self:custom.imageBucketName}/*"

resources:
  Resources:
    S3Assets:
      Type: AWS::S3::Bucket
      Properties:
        BucketName: ${self:custom.imageBucketName}

functions:
  create-image-upload-url:
    runtime: nodejs14.x
    name: create-image-upload-url-${self:provider.stage}
    handler: create-urls.handler
    events:
    # This will create a HTTP Gateway so that our function will be easily reachable 
     - http:
         path: images/uploads
         method: post
# placeholder-second-function
</pre>