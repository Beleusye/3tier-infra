variable "region" {
  description = "AWS Region"
  type = string
}

variable "availability_zone" {
  description = "AWS Availability Zone"
  type = string
}

variable "ami_id" {
  description = "Instance Image ID"
  type = string
}

variable "web_instance_type" {
  description = "Instance Type"
  type = string
}

variable "was_instance_type" {
  description = "Instance Type"
  type = string
}

variable "bastion_user_data" {
  description = "Bastion Instance User Data"
  type = string
}

variable "web_user_data" {
  description = "Bastion Instance User Data"
  type = string
}

variable "was_user_data" {
  description = "Bastion Instance User Data"
  type = string
}