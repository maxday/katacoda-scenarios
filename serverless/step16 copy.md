Let's complete our application by creating our second and last function to grayscale the image and crop it.

*In this step, you don't need to write any code, make sure you understand the code, then click on `Copy to editor` on each of the following code snippets* 

First we will need one last dependency to perform the grayscale/crop action, so let's install it with    
`npm install --save jimp@0.16.1`{{execute}}

Then we can create our second function, as a reminder this function will be automatically triggered when a PutCommand is made on our bucket.

So this function will :
1. Be run automatically when an item is put into our bucket (by our first function for instance)
2. Read the event payload to get the url of the image
3. Fetches the image
4. Perform a grayscale + crop
5. Upload this new image in our bucket

<pre class="file" data-filename="trigger.js" data-target="replace">
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const { S3Client, GetObjectCommand, PutObjectCommand } = require("@aws-sdk/client-s3");
const Jimp = require("jimp");

exports.handler = async (event) => {
    try {
      const client = new S3Client();
      // iterates through every incoming event sent from S3, and processes
      // asynchronously.
      const records = event.Records;
      const promises = records.map(record => this.processImage(record, client));
      // Wait until all the processed images are sent to S3
      await Promise.all(promises);
      return {
          statusCode: 200,
          body: JSON.stringify({
            processed : promises.length
          })
      }
    } catch (e) {
      console.log(e);
      throw "Impossible to process the image";
    }
};

exports.getInfoFromRecord = (record) => {
    try {
      const bucketName = record.s3.bucket.arn.split(":::")[1];
      const key = record.s3.object.key;
      const stage = key.split("/")[0];
      const id = key.split("/")[2];
      return { bucketName, key, stage, id };
    } catch (e) {
      console.log(e);
      throw "Impossible to retrieve info from the record";
    }
}

exports.getProcessInfoFromRecord = async (record, client) => {
  try {
    const { bucketName, key, stage, id } = this.getInfoFromRecord(record);
    const options = {
      Bucket: bucketName,
      Key: key,
      ContentType: "image/jpeg"
    };
    const command = new GetObjectCommand(options);
    const processInfo =  {
      url: await getSignedUrl(client, command, { expiresIn: 3600 }),
      bucketName, 
      processedKey: `${stage}/processed/${id}`
    } 
    return processInfo;
  } catch (e) {
    console.log(e);
    throw "Impossible to retrieve the url from the record";
  }
}

exports.grayScaleImage = async (record, client) => {
  try {
    const { url, bucketName, processedKey } = await this.getProcessInfoFromRecord(record, client);
    const jmp = await Jimp.read(url);
    const image = await jmp
    .cover(256, 256)
    .greyscale()
    .getBufferAsync(Jimp.MIME_JPEG);
    return { bucketName, processedKey, image };
  } catch (e) {
    console.log(e);
    throw "Impossible to generate the image";
  }
}

exports.sendImage = async (client, bucketName, processedKey, image) => {
  try {
    const putCommand = new PutObjectCommand({
      Bucket: bucketName,
      Key: processedKey,
      Body: image,
      ContentType: Jimp.MIME_JPEG
    });
    await client.send(putCommand);
  } catch (e) {
    console.log(e);
    throw "Impossible to send the image";
  }
}

exports.processImage = async (record, client) => {
  try {
    const { bucketName, processedKey, image } = await this.grayScaleImage(record, client);
    await this.sendImage(client, bucketName, processedKey, image);
  } catch (e) {
    console.log(e);
    throw "Impossible to process the image";
  }
}
</pre>