variable "ami" {
  type = string
  default = "ami-005835d578c62050d"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "ec2-key"
}