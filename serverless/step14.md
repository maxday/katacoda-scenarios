We just saw that Datadog provides out-of-the-box some useful metrics.

It's also possible to send custom metrics, let's add one when the urls are generated.

*Once again, in this step, you don't need to write any code, make sure you understand the code, then click on `Copy to editor` on the following code snippet* 


First let's install the Datadog library to send the metric with  
`npm install --save-dev datadog-lambda-js@4.64.0`{{execute}}
This is a `development` dependency only as Datadog CLI tools is taking care of bundling it for us in a `Lambda Layer`

Then let's import the Datadog Library
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-import-custom-metric">
const sendDistributionMetric = require("datadog-lambda-js").sendDistributionMetric;
</pre>

Then let's write the code to actually send the metric
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-send-custom-metric">
        sendDistributionMetric(
            "create_urls.request",                          // Metric name
            1,                                              // Metric value
            `bucket:${bucket},my_custom_tag:some_value`,    // Metric tag
        );
</pre>

Don't forget to adjust our test 
<pre class="file" data-filename="create-urls.spec.js" data-target="insert" data-marker="// placeholder-adjust-test">
jest.mock("datadog-lambda-js");
</pre>

Make sure our tests are still passing with  
`jest --coverage`{{execute}}