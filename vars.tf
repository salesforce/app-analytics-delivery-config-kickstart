variable "aws_region" {}

variable "lmo_org_id" {}

variable "bucket_names" {
  type    = list(string)
  default = []
}

variable "bucket_prefixes" {
  type    = list(string)
  default = []
}

variable "sfdc_aws_account" {
  type    = string
  default = "686444179860"
}
