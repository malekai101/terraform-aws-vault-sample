variable "region" {
  description = "The AWS region to deploy the Vault server"
  type    = string
}

variable "project_name" {
  description = "The name of the project for the tag."
  type    = string
}

variable "vpc_id" {
    description = "The vpc id"
}

variable "admin_ip" {
  description = "The IP address of the administrator"
  type = string
}

variable "key" {
  description = "The ssh key for access."
  type = string
}

variable "subnet_id" {
    description = "The subnet for the Vault server."
}