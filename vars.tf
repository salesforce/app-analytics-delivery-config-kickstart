/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
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
