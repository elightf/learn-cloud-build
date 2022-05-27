variable "project" {
  default     = "cloud-build-terraform-demo"
  type        = string
  description = "Google Cloud Platform Project ID"
}

variable "region" {
  default = "us-central1"
  type    = string
}
