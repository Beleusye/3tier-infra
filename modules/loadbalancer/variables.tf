variable "region" {
  description = "AWS Region"
  type = string
}

variable "http_port" {
  description = "Target Port - HTTP"
  type = number
}

variable "https_port" {
  description = "Target Port - HTTPS"
  type = number
}

variable "was_port" {
  description = "Target Port - WAS"
  type = number
}

variable "alb_health_path" {
  description = "ABC Target Group Health Check Path"
  type = string
}

variable "nlb_health_path" {
  description = "NLB Target Group Health Check Path"
  type = string
}