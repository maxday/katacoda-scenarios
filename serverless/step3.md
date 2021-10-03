We're going to write our Lambda handler code. 

<pre class="file" data-filename="create-urls.js" data-target="replace">
// Import the S3 client
const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3");
// This will allow us to create an url where we can upload our image
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
// Handler code
module.exports.handler = async () => {
    // The Serverless framework is responsible to set those environment variables
    const bucket = process.env.BUCKET_NAME;
    const stage = process.env.STAGE;

    // Make sure to throw an error if something is wrong with those variables
    if(!bucket || !stage) {
        throw "BUCKET_NAME and STAGE environment variables could not be found";
    }

    // Build a random image name
    const id = Math.floor(Math.random() * 10e16);
    const fileName = `${id}.jpg`;
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
        const client = new S3Client();
        
        // Get the signed urls
        const signedUrl = [
            getSignedUrl(client, command),
            getSignedUrl(client, unprocessedCommand),
            getSignedUrl(client, processedCommand)
        ];
    
        // Wait for all signedUrl to complete
        const [uploadUrl, unprocessedUrl, processedUrl] = await Promise.all(signedUrl);
    
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
};