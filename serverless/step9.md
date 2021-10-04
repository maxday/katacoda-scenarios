Great we now have our service deployed but no observability so far so it's cleary not production ready!

Let's use the Datadog CLI tool to auto-instrument our service.

First let's install the tool with `npm install -g @datadog/datadog-ci@0.17.5`{{execute}}

Then we can instrument our service with : `datadog-ci lambda instrument --function create-image-upload-url-$STAGE -r us-east-1 --extensionVersion 11 --layerVersion 63`{{execute}}

That was easy! Our service is now instrumented and metrics, logs and traces will be available in Datadog.

Now let's simulate some traffic by calling 3 times our functions

`seq 3 | xargs -Iz ./upload.sh "$ENDPOINT" "$STAGE" testimage.jpg`{{execute}}
