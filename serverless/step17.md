To be as production-ready as possible in this workshop, this new function should be tested as well. So let's add a new test file.

*In this step, you don't need to write any code, make sure you understand the code, then click on `Copy to editor` on each of the following code snippets* 

<pre class="file" data-filename="trigger.spec.js" data-target="replace">
jest.mock("@aws-sdk/s3-request-presigner");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const fs = require('fs');

jest.mock('@aws-sdk/client-s3', () => ({
    ...jest.requireActual('@aws-sdk/client-s3'),
    S3Client : jest.fn().mockImplementation(() => { return {
        send : () => true
    } })
}));

const { handler, 
    getInfoFromRecord, 
    getProcessInfoFromRecord, 
    grayScaleImage,
    sendImage,
    processImage
} = require("./trigger");

const validRecord =  {
    "s3": {
        "s3SchemaVersion": "1.0",
        "configurationId": "process-image-max-xxx",
        "bucket": {
            "name": "testBucketName",
            "ownerIdentity": {
                "principalId": "xxx"
            },
            "arn": "arn:aws:s3:::testBucketName"
        },
        "object": {
            "key": "max/unprocessed/testImageName.jpg",
            "size": 19471,
            "eTag": "xxx",
            "sequencer": "xxx"
        }
    }
}

describe("handler", () => {
    it("should throw an error as environment variables are not set", async () => {
        expect.assertions(1);
        await expect(handler()).rejects.toEqual('Impossible to process the image');
    });

    it("should succeed as records is empty", async () => {
        expect.assertions(1);
        const event = { Records : []}
        await expect(handler(event)).resolves.toEqual({"body": "{\"processed\":0}", "statusCode": 200});
    });

    it("should succeed as records is not empty", async () => {
        expect.assertions(1);
        const returnedUrl = '/tmp/img.jpeg';
        getSignedUrl.mockImplementation(() => Promise.resolve(returnedUrl));
        const event = { Records : [ validRecord ]}
        await expect(handler(event)).resolves.toEqual({"body": "{\"processed\":1}", "statusCode": 200});
    });
});

describe("getInfoFromReport", () => {
    it("should fails as the record is invalid", () => {
        expect.assertions(1);
        const invalidRecord = {}
        expect(() => getInfoFromRecord(getInfoFromRecord(invalidRecord))).toThrowError("Impossible to retrieve info from the record");
       
    });
    it("should succeed as the record is valid", () => {
        expect.assertions(4);
        const { bucketName, key, stage, id } = getInfoFromRecord(validRecord);
        expect(bucketName).toEqual("testBucketName");
        expect(key).toEqual("max/unprocessed/testImageName.jpg");
        expect(stage).toEqual("max");
        expect(id).toEqual("testImageName.jpg");
    });
});

describe("getProcessInfoFromRecord", () => {
    it("should throw an error as getSignedUrl fails", async () => {
        expect.assertions(1);
        getSignedUrl.mockImplementation(() => Promise.reject());
        await expect(getProcessInfoFromRecord(validRecord, null)).rejects.toEqual('Impossible to retrieve the url from the record');
    });
    it("should succeed", async () => {
        expect.assertions(3);
        const returnedUrl = 'http://myTestUrl';
        getSignedUrl.mockImplementation(() => Promise.resolve(returnedUrl));
        const { url, bucketName, processedKey } = await getProcessInfoFromRecord(validRecord, null);
        expect(url).toEqual(returnedUrl);
        expect(bucketName).toEqual("testBucketName");
        expect(processedKey).toEqual("max/processed/testImageName.jpg");
    });
});

describe("grayScaleImage", () => {
    it("should fail as the image does not exist", async () => {
        expect.assertions(1);
        const returnedUrl = 'XXX.jpeg';
        getSignedUrl.mockImplementation(() => Promise.resolve(returnedUrl));
        await expect(grayScaleImage(validRecord, null)).rejects.toEqual('Impossible to generate the image');
    });
    it("should succeed", async () => {
        expect.assertions(3);
        const returnedUrl = '/tmp/img.jpeg';
        getSignedUrl.mockImplementation(() => Promise.resolve(returnedUrl));
        const { bucketName, processedKey, image } = await grayScaleImage(validRecord, null);
        expect(bucketName).toEqual("testBucketName");
        expect(processedKey).toEqual("max/processed/testImageName.jpg");
        const expectedImage = fs.readFileSync('/tmp/processed_img.jpeg');
        expect(image).toEqual(expectedImage);
    });
});

describe("sendImage", () => {
    it("should fail", async () => {
        expect.assertions(1);
        await expect(sendImage(null)).rejects.toEqual('Impossible to send the image');
    });
});

describe("processImage", () => {
    it("should fail", async () => {
        expect.assertions(1);
        await expect(processImage(null)).rejects.toEqual('Impossible to process the image');
    });
});
</pre>

Make sure all test are passing and the coverage is still at 100% with    
`jest --coverage`{{execute}}