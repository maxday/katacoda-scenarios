Not so fast, as we are here to build an service as production-ready as possible let's right some unit tests to ensure that our function is valid.

We often hear that it's not possible or quite difficult to unit test serverless application. We will see that that's not correct here.

We are going to use the `jest` framework to write and run our unit tests, so let's install it now with `npm install -g jest@27.2.4`{{execute}}

You can now try to run the tests with `jest`{{execute}}
Of course this will fail since we don't have any tests yet.

So let's create our first test suite which will be run against our previously writen function
<pre class="file" data-filename="create-urls.spec.js" data-target="replace">
const handler = require('./create-urls').handler;

jest.mock("@aws-sdk/s3-request-presigner");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

describe("handler", () => {
    it("should throw an error as environment variables are not set", async () => {
        expect.assertions(1);
        await expect(handler()).rejects.toEqual('BUCKET_NAME and STAGE environment variables could not be found');
    });
    it("should throw an error as getSignedUrl fails", async () => {
        expect.assertions(1);
        process.env.STAGE = 'testStage';
        process.env.BUCKET_NAME = 'testBucketName';
        getSignedUrl.mockImplementation(() => Promise.reject());
        await expect(handler()).rejects.toEqual('Impossible to create pre-signed urls');
    });
    it("should succeeed", async () => {
        expect.assertions(1);
        process.env.STAGE = 'testStage';
        process.env.BUCKET_NAME = 'testBucketName';
        const returnedUrl = 'http://myTestUrl';
        getSignedUrl.mockImplementation(() => Promise.resolve(returnedUrl));
        await expect(handler()).resolves.toEqual({"body": `{"uploadUrl":"${returnedUrl}","unprocessedUrl":"${returnedUrl}","processedUrl":"${returnedUrl}"}`, 'statusCode': 202});
    });
});
</pre>

Let's try again our jest command : `jest`{{execute}}

Great our tests are passing, you can also the test with the coverage option to verify that every statements have been tested `jest --coverage`{{execute}}