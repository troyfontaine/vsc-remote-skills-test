variable "region" {
  description = "AWS Region to Build in"
  type        = string
  default     = "us-west-2"
}

variable "base_ami_name" {
  description = "The name of the AMI to filter on"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}

variable "base_ami_owner" {
  description = "The base AMI Owner"
  type        = string
  default     = "099720109477"
}

variable "domain" {
  description = "The domain portion of the hostname that will be used with the instance"
  type = string
}

variable "sub_domain" {
  description = "The hostname that will be used with the instance as part of the FQDN- ensure that it is followed by a period!"
  type = string
  default = "test."
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }
