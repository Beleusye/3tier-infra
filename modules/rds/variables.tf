variable "region" {
  description = "AWS Region"
  type = string
}

variable "db_instance_type" {
  description = "RDS Instance Type"
  type = string
}

variable "db_engine" {
  description = "RDS engine"
  type = string
}

variable "db_engine_version" {
  description = "RDS engine version"
  type = string
}

variable "db_storage_size" {
  description = "RDS Allocated Storage"
  type = string
}

variable "db_name" {
  description = "Database Name"
  type = string
}

variable "db_user" {
  description = "Database Login User"
  type = string
}

variable "db_password" {
  description = "Database Login Password"
  type = string
}
