Now that our second function is written and correctly tested, let's update the deployment file and deploy it!

*In this step, you don't need to write any code, make sure you understand the code, then click on `Copy to editor` on each of the following code snippets* 

Add a section in `serverless.yml` to describe the new function and the S3 bucket trigger

<pre class="file" data-filename="serverless.yml" data-target="insert" data-marker="# placeholder-second-function">
  process-image:
    runtime: nodejs14.x
    name: process-image-${self:provider.stage}
    handler: trigger.handler
    events: # Emits event when a jpg file is uploaded to the directory
      - s3:
          bucket: ${self:custom.imageBucketName}
          existing: true
          event: s3:ObjectCreated:*
          rules:
            - prefix: ${self:provider.stage}/unprocessed
            - suffix: .jpg
</pre>