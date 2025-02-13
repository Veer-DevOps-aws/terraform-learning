variable "regin-name" {
    description = "defining region name"
    type = string
    default = "ap-south-1"
  
}


variable "vpc-cidr" {
    description = "defining vpc cidr"
    type = string
    default = "10.0.0.0/16"
  
}

variable "vpc-name" {
    description = "defining vpc name"
    type = string
    default = "terraform-vpc-demo"
}

variable "subnet-cidr" {
    description = "defining cidr of subnet"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]  
}

variable "subnet-amz" {
    description = "defining az for public subnet"
    type = list(string)
    default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}

variable "priv-sub-cidr" {
    description = "defining cidr of private subnet"
    type = list(string)
    default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]  
}

variable "priv-amz" {
    description = "defining az for private subnet"
    type = list(string)
    default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]  
}

variable "igw-name" {
    description = "defining internet gateway name"
    type = string
    default = "igw-tf"
  
}

variable "public-route" {
    description = "defining public route table name"
    type = string
    default = "public-route-tf"
}


variable "ec2-ami" {
    description = "difining ami of ec2 machine"
    type = string
    default = "ami-00bb6a80f01f03502"
}


variable "ec2-type" {
    description = "defining  type of ec2 machine"
    type = string
    default = "t2.micro"
}

variable "ec2-name" {
    description = "definining name of ec2"
    type = list(string)
    default = ["web-server-1", "web-server-2", "web-server-3"]
}

variable "my-ip" {
    description = "defining my ip address"
    type = string
    default = "152.58.118.15/32"
}