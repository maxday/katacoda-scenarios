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
    // placeholder-body-handler
};
</pre>