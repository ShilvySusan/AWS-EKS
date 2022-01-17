variable "aws_region" {
    type = string
    description = "AWS Region in which EKS is created"
}

variable "cluster_name"{
    type = string
    description = "name of the cluster"
}

variable "vpc_name"{
    type = string
    description = "name of vpc"
}

variable "vpc_cidr_block" {
    type = string
    description = "CIDR block for VPC"
}

variable "public_subnet_cidr_blocks" {
    type = list(string)
    description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidr_blocks" {
    type = list(string)
    description = "CIDR blocks for private subnets"
}

variable "instance_type" {
    type = list(string)
    description = "Type of instance being used for nodes"
}