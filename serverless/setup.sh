#!/bin/bash
mkdir -p /root/dash-serverless-workshop
docker pull maxday/dash:2
docker run -it -v "$(pwd)"/dash-serverless-workshop:/root/dash-serverless-workshop maxday/dash:2
clear
echo "All set! You can start the workshop."