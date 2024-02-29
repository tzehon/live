provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "tth-prop-analysis-bucket"
    prefix = "prod/scheduled_job/terraform.tfstate"
  }
}

module "scheduled_job" {
  source = "github.com/tzehon/terraform_modules//services/scheduled-job?ref=v0.3.0"

  project_id                    = var.project_id
  scheduler_name                = var.scheduler_name
  service_name                  = var.service_name
  region                        = var.region
  url                           = var.url
  access_key_id                 = var.access_key_id
  access_key_value              = var.access_key_value
  atlas_user_id                 = var.atlas_user_id
  atlas_user_value              = var.atlas_user_value
  atlas_password_id             = var.atlas_password_id
  atlas_password_value          = var.atlas_password_value
  atlas_connection_string_id    = var.atlas_connection_string_id
  atlas_connection_string_value = var.atlas_connection_string_value
}
