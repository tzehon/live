provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "tth-prop-analysis-bucket"
    prefix = "prod/secret_manager/terraform.tfstate"
  }
}

module "secret_manager" {
  source = "github.com/tzehon/terraform_modules//services/secrets?ref=v0.0.5"

  project_id   = var.project_id
  region       = var.region
  secret_id    = var.secret_id
  secret_value = var.secret_value
}
