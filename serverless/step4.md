We're going to write our Lambda handler code. 

*In this step, you don't need to write any code, make sure you understand the code, then click on `Copy to editor` on each of the following code snippets* 

First let's import our previously downloaded dependencies

<pre class="file" data-filename="create-urls.js" data-target="replace">
// Import the S3 client
const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3");

// This will allow us to create an url where we can upload our image
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

// placeholder-import-custom-metric

// placeholder-handler
</pre>

Make sure the newly created file is correctly open in the file explorer.

Then, write the handler function
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-handler">
// Handler code
module.exports.handler = async () => {
// placeholder-environment-variables
};
</pre>

Both the bucket name and the stage will come from our deployment tool via environment variable, so let's write the code to get those values

<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-environment-variables">
    // The Serverless framework is responsible for setting those environment variables
    const bucket = process.env.BUCKET_NAME;
    const stage = process.env.STAGE;

    // Make sure to throw an error if something is wrong with those variables
    if(!bucket || !stage) {
        throw "BUCKET_NAME and STAGE environment variables could not be found";
    }

// placeholder-create-random-id
</pre>

To avoid any conflicts, let's generate a random filename, this will be the location where our file will be uploaded to

<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-create-random-id">
    // Build a random image name
    const id = Math.floor(Math.random() * 10e16);
    const fileName = `${id}.jpg`;
    console.log(`Generated filename : ${fileName}`);

// placeholder-generate-commands
</pre>

*Here we've added a custom log line to output the generated filename, we will be able to see this log in the Datadog UI later in the workshop*

Then let's generate PutObject and GetObject command to respectively add a document to S3 and retrieve it

<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-generate-commands">
    const unprocessedOptions = {
        Bucket: bucket,
        Key: `${stage}/unprocessed/${fileName}`,
        ContentType: "image/jpeg",
    };

    const processedOptions = { ...unprocessedOptions, Key: `${stage}/processed/${fileName}`};

    try {
        // This will create the upload url
        const command = new PutObjectCommand(unprocessedOptions);

        // This will create urls to get the original + processed image
        const unprocessedCommand = new GetObjectCommand(unprocessedOptions);
        const processedCommand = new GetObjectCommand(processedOptions);

// placeholder-s3-client
</pre>

Then initialize a S3 Client and execute the three commands

<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-s3-client">
        const client = new S3Client();

        // Get the signed urls
        const signedUrl = [
            getSignedUrl(client, command),
            getSignedUrl(client, unprocessedCommand),
            getSignedUrl(client, processedCommand)
        ];

        // Wait for all signedUrl to complete
        const [uploadUrl, unprocessedUrl, processedUrl] = await Promise.all(signedUrl);

// placeholder-send-custom-metric

// placeholder-return
</pre>

Finally, return the 3 URLs and handle any errors
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-return">
        return {
            statusCode: 202,
            body: JSON.stringify({
                uploadUrl,
                unprocessedUrl,
                processedUrl
            })
        };

    } catch(e) {
        throw "Impossible to create pre-signed urls";
    }
</pre>

Woot woot! You've just completed coding the first handler function!

Let's go to the next step to see how we can deploy it!


