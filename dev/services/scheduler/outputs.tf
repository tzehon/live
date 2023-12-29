output "address" {
    value = module.scheduled_job.cloud_run_url
    description = "Cloud Run URL"
}

output "external_ip_address" {
  value = module.scheduled_job.external_ip_address
  description = "The external IP address for Cloud Run"
}