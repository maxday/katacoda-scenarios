Once the `serverless` framework installed, let's write our first deployment file!

<pre class="file" data-filename="serverless.yml" data-target="replace">
service: serverless-workshop-service

configValidationMode: error

custom:
  imageBucketName: serverless-workshop-image

provider:
  name: aws
  stage: ${opt:stage}
  region: us-east-1
  lambdaHashingVersion: 20201221
  deploymentBucket:
    name: serverless-workshop-deployment
  environment:
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

functions:
  create-image-upload-url:
    runtime: nodejs14.x
    name: create-image-upload-url-${self:provider.stage}
    handler: app.handler
    events:
     - http:
         path: images/uploads
         method: post
</pre>