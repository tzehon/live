provider "aws" {
  region  = "ap-southeast-1"
  profile = "286510118323_AdministratorAccess"
}

terraform {
  backend "s3" {
    bucket  = "terraform-up-and-running-state-tth"
    key     = "stage/data-stores/mysql/terraform.tfstate"
    region  = "ap-southeast-1"
    profile = "286510118323_AdministratorAccess"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "database" {
  source = "../../../../modules/services/data-stores/mysql"

  db_username = var.db_username
  db_password = var.db_password
  db_identifier_prefix = "terraform-up-and-running-stage"
}
