variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI profile to use (required for SSO)"
  default     = null
}

variable "route53_domain" {
  type        = string
  description = "The domain registered in Route53"
  default     = "roshamboduel.com"
}