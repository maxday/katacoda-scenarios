Datadog also generates out the box some `enhanced metrics` such as :
- init duration (for cold starts)
- duration
- max_memory_used
- billed_duration
- and more.

Let's have a look at those metrics!

1. Go to `Metrics` > `Explorer` on the left sidebar.

1. Select a valid timespan on the top right hand corner (like 1 hour)

1. In `Graph:` type `aws.lambda.enhanced.duration` + `enter` to see a graph

1. This graph shows the timeserie of this metric for `all` lambda functions, you can add a tag in the `Over:` section with your service name (for instance : `service:mdavid`)

Feel free to add more tags or to try other metrics such as : 

* aws.lambda.enhanced.max_memory_used
* aws.lambda.enhanced.invocations



