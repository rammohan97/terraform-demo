variable "ami_id" {
    default = "ami-0220d79f3f480ecf5"
    type = string
}

variable "instance_type" {
    default = "t3.micro"
    type = string
}

variable "sg_name" {
  type = string
  default = "allow-all"
  description = "value for the name of the security group"
}

variable "cidr" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "common_tags" {
  type = map
  default = {
    Terraform = "True"
    Environment = "development"
    Project = "roboshop"
  }
}

variable "sg_tags" {
  type = map
  default = {
    Name = "Allow-All"
    Terraform = "True"
    Environment = "Development"
    Project = "Terraform-Demo-Project"
  }
  
}

variable "ingress_from_port" {
  type = number
  default = 0  
}

variable "ingress_to_port" {
  type = number
  default = 0  
}

variable "egress_from_port" {
  type = number
  default = 0  
}

variable "egress_to_port" {
  type = number
  default = 0
}

variable "protocol" {
  type = string
  default = "-1"
}

variable "instances" {
    default = ["mongodb-demo", "redis", "mysql", "rabbitmq"] 
  # default = {
  #   mongodb = "t3.micro",
  #   redis = "t3.micro",
  #   mysql = "t3.micro"
  # }
}

variable "project" {
  default = "robosho"
}

variable "environment" {
  default = "development"
}

# variable "common_name" {
#   default = "${var.project}-${var.environment}"   # Here we are using one variable into another variable. This is called variable interpolation.
# }