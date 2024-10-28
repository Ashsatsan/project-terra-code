variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use for the subnets"
  type        = list(string)
}

variable "my_ip" {
  description = "The public IP address"
  type        = string
}

variable "mysql_username" {
  description = "The MySQL username"
  type        = string
}

variable "mysql_password" {
  description = "The MySQL password"
  type        = string
}

variable "Priv_key_path" {
  description = "Path to private key file"
  type        = string
}

variable "Pub_key_path" {
  description = "Path to public key file"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_size" {
  description = "Number of nodes in the EKS node group"
  type        = number
}

variable "s3" {
  description = "kasten bucket"
  type        = string
}