Let's now execute our first deployment!

In this lab we are all pushing code to the same AWS account. We will keep our code separate by assigning a unique stage to our functions. We can do this by setting an environment variable.

Create an environment variable called STAGE as shown in the example below and set it to the first letter of your first name followed by your last name.

```
# use the first letter of your first name followed by your last name
STAGE="mdavid" // this is only an example, make sure you change it
```

Then, deploy with the following command.

`serverless deploy --stage $STAGE`{{execute}}

*(This may take a minute or two)*