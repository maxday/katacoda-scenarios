We just saw that Datadog provides out-of-the-box some useful metrics.

It's also possible to send custom metrics, let's add one when the urls are generated.

First we need to import the Datadog Library (no need to install it as the Datadog CLI tools is taking care of it)
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-import-custom-metric">
const sendDistributionMetric = require("datadog-lambda-js").sendDistributionMetric;
</pre>

Then let's send the metric
<pre class="file" data-filename="create-urls.js" data-target="insert" data-marker="// placeholder-send-custom-metric">
        sendDistributionMetric(
            "create_urls.request",                          // Metric name
            1,                                              // Metric value
            `bucket:${bucket},my_custom_tag:some_value`,    // Metric tag
        );
</pre>