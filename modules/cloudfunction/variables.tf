variable "entry_point" {}

variable "runtime" {}

variable "cf_name" {}

variable "cf_bucket_name" {}

variable "source_code" {}

variable "project" {}

variable "region" {}

variable "sa_name" {}

variable "cf_iam_roles" {}

variable "sa_type" {
  default = "serviceAccount"
}
