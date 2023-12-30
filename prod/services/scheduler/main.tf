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
  source = "github.com/tzehon/terraform_modules//services/scheduled-job?ref=v0.0.11"

  project_id     = var.project_id
  scheduler_name = var.scheduler_name
  service_name   = var.service_name
  region         = var.region
  url            = var.url
  secret_id      = var.secret_id
  secret_value   = var.secret_value
  connector_name = var.connector_name
  cidr_range     = var.cidr_range
  router_name    = var.router_name
  ip_name        = var.ip_name
}
