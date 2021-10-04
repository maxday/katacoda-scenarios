Let's test our first verison of the app!

Download one (or more) of the following images to try our newly deployed service!

`wget -O testimage.jpg https://i.imgflip.com/gw42w.jpg`{{execute}}

Then run this script to test posting the image to our service:

`./upload.sh "$STAGE" testimage.jpg`{{execute}}

Give S3 a few seconds to process, and then open up the URL printed out by the upload script.

*Note that the processed URL is not yet available since you didn't build the second part yet*