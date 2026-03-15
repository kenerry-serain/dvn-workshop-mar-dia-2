terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "<YOUR_BUCKET>"
    key          = "networking/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    # dynamodb_table = "workshop-march-state-locking-table"
  }
}

provider "aws" {
  region = var.assume_role.region

  default_tags {
    tags = var.tags
  }

  assume_role {
    role_arn = var.assume_role.arn
  }
}
