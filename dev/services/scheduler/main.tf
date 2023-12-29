provider "google" {
  project = var.project_id
  region  = var.region
}

module "scheduled_job" {
  source = "github.com/tzehon/terraform_modules//services/scheduled-job?ref=v0.0.10"
  # source = "/Users/tth/projects/terraform_modules/services/scheduled-job"

  project_id     = var.project_id
  scheduler_name = var.scheduler_name
  service_name   = var.service_name
  region         = var.region
  url            = var.url
  secret_id      = var.secret_id
  secret_value   = var.secret_value
  connector_name = var.connector_name
  cidr_range     = var.cidr_range
}
