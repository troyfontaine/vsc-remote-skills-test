variable "http_port" {
  description = "Port used for http access to instance from the world"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Port used for http access to instance from the world"
  type        = number
  default     = 443
}

variable "vs_port" {
  description = "Port used for visual studio code app from the www"
  type        = number
  default     = 8443
}

variable "k8s_port" {
  description = "Port used for visual studio code app from the www"
  type        = number
  default     = 6443
}

variable "ssh_port" {
  description = "Port used for SSH access to the testing instance"
  type        = number
  default     = 22
}

variable "image_name_filter" {
  description = "Name of image to filter for, defaults to one of the testing images built with packer"
  type = string
  default = "ubuntu-focal-hiring-testing-nginx-*"
}

variable "domain" {
  description = "The domain name to be used by the testing instance within the caddyfile configuration for Let's Encrypt i.e. test.mydomain.com - it MUST be in AWS Route 53"
  type = string
}

variable "sub_domain" {
  description = "Subdomain of the domain name to be used for the testing instance within the caddyfile configuration for Let's Encrypt.  Please ensure that the subdomain name is followed by a period"
  type = string
  default = ""
}
