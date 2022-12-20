# Assignment 1 - AWS, Terraform, CI/CD

## Infra folder 
This is for provisioning the infrastructure in AWS which will include ASG, ALB in default vpc of Singapore region

The EC2 servers after booting up will download its web content from a private S3 bucket

## Application folder
It contains application code - incremental and decremental counter

Changes to this code will trigger CI/CD pipeline which will upload the update to private s3 bucket and then refresh the autoscaling group

## Deliverables
1. Both public ALB and server fleet A will only allow on port 80/TCP

2. Server fleet will download and install nginx on boot

3. Infra pipeline will provision the infrastructure while the app pipeline uploads the application code

4. s3 bucket does not contain application code at first and server fleet will not display the website

5. Application pipeline will upload the website and trigger the instance refresh 

6. After successful refresh of ASG, the website can be reached via public internet

## improvements
1. Custom VPC, internet gateway, NAT gateway would be recommended for flexibility and privacy

2. Multiple private subnets within different AZs will enable the high availability of server fleet

3. NAT gateway is required and provisioned in the infrastructure to enable outbound internet otherwise server fleet will not be communicating with the internet

4. Two pipelines meant for separation of concerns: one for infrastructure and one for application code then every update will trigger corresponding pipeline




