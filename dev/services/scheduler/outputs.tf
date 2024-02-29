output "address" {
    value = module.scheduled_job.cloud_run_url
    description = "Cloud Run URL"
}