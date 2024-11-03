variable "region" {
  description = "AWS Region"
  type = string
}

variable "max_size" {
  description = "Horizontal Autoscale Max Size"
  type = number
}

variable "min_size" {
  description = "Horizontal Autoscale Min Size"
  type = number
}

variable "capacity" {
  description = "Desired Capacity"
  type = number
}