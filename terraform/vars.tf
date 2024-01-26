variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMI" {
  default = "ami-0a3c3a20c09d6f377"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "instance_name" {
  default = "jenkins"
}

variable "cluster-name" {
  default = "pet-clinic"
}
