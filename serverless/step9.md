Let's test our first verison of the app!

Download a sample image to try our newly deployed service with  
`wget -O testimage.jpg https://i.imgflip.com/gw42w.jpg`{{execute}}

Then run this script to test posting the image to our service  
`upload.sh "$ENDPOINT" testimage.jpg`{{execute}}

Open up the URL printed under `Public unprocessed image URL`, you should see a beautiful cat!

*Note that the processed URL is not yet available since you didn't build the second part yet*