variable "tags" {
  type = map(string)
  default = {
    Environment = "production"
    Project     = "workshop-devops-na-nuvem"
  }
}

variable "assume_role" {
  type = object({
    arn    = string
    region = string
  })

  default = {
    arn    = "<YOUR_ROLE>"
    region = "us-east-1"
  }
}

variable "remote_backend" {
  type = object({
    s3_bucket_name               = string
    dynamodb_table_name          = string
    dynamodb_table_billing_mode  = string
    dynamodb_table_hash_key      = string
    dynamodb_table_hash_key_type = string
  })

  default = {
    s3_bucket_name               = "<YOUR_BUCKET>"
    dynamodb_table_name          = "workshop-march-state-locking-table"
    dynamodb_table_billing_mode  = "PAY_PER_REQUEST"
    dynamodb_table_hash_key      = "LockID"
    dynamodb_table_hash_key_type = "S"
  }
}
