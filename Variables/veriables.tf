variable "region" {
  description = "Please enter region"
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Enter instance type"
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of ports to open for server"
  type        = list
  default     = ["80", "443", "22", "8080"]
}

variable "enable_detail_monitoring" {
  type    = bool
  default = false
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map
  default = {
    Owner       = "Andrei Leonovich"
    Project     = "Phoenix"
    CostCenter  = "12345"
    Environment = "development"
  }
}
