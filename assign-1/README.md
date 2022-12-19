# Assignment 1 - AWS, Terraform, CI/CD

## Infra folder 
It is for provisioning the infrastructure in AWS which will include ASG, ALB in default vpc of Singapore region

The EC2 servers when booting up will download its web content from a private S3 bucket

## application folder
It contains application code (html website) - incremental and decremental counter

Changes to this code will trigger CI/CD pipeline which will upload the update to private s3 bucket and then refresh the autoscaling group

## Deliverables
both public ALB and server fleet A will only allow on port 80/TCP
server fleet will download and install nginx on boot
infra pipeline will provision the infrastructure while the app pipeline will upload the application code
so s3 bucket will not contain application code at first and server fleet will not display the website
application pipeline will upload the website and trigger the instance refresh
after successful refresh of ASG, the website can be reached via public internet

## improvements
custom VPC, internet gateway, NAT gateway would be recommended for flexibility and privacy
multiple private subnets will enable the high availability of server fleet
NAT gateway is required and so provisioned in the infrastructure to enable outbound internet otherwise server fleet will not be communicating with the internet
Two pipelines created for separation of concerns: one for infrastructure and one for application code
each update will trigger corresponding pipeline




