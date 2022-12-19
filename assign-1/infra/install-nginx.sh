#! /bin/bash
sudo yum update
sudo amazon-linux-extras list | grep nginx
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
sudo chkconfig nginx on
sudo service nginx start
sudo aws s3 cp s3://s3-web-content/index.html /usr/share/nginx/html/
