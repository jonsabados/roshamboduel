variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI profile to use (required for SSO)"
  default     = null
}

variable "state_bucket" {
  type        = string
  description = "The name of the state bucket, used to grant GitHub Actions access to terraform state"
}

variable "route53_domain" {
  type        = string
  description = "The name of the domain, registered in route53, that will be used to deploy the application"
  default     = "roshamboduel.com"
}