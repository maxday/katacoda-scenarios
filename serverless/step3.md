We're going to write our Lambda handler code. 

First let's import our previously downloaded dependencies

<pre class="file" data-filename="create-urls.js" data-target="replace">
// Import the S3 client
const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3");

// This will allow us to create an url where we can upload our image
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

// placeholder-handler
</pre>

Then, write the handler function
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-handler">
// Handler code
module.exports.handler = async () => {
    // placeholder-environment-variables
};
</pre>

Both the bucket name and the stage will come from our deployment tool via environment variable, so let's write the code to get those values

<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-environment-variables">
// The Serverless framework is responsible to set those environment variables
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
</pre>

