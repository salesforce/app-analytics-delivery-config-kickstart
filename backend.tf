terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63.0"
    }
  }

  backend "s3" {
    region = ""
    bucket = ""
    key    = "byob-kickstart.tfstate"
  }
}
