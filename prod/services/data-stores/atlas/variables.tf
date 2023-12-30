variable "project_id" {
  description = "Existing MongoDB Atlas Project ID"
  type        = string
}

variable "public_key" {
  description = "Public API key to authenticate to Atlas"
  type        = string
}

variable "private_key" {
  description = "Private API key to authenticate to Atlas"
  type        = string
}

variable "provider_name" {
  description = "Atlas cluster provider name"
  default     = "GCP"
  type        = string
}

variable "backing_provider_name" {
  description = "Atlas cluster backing provider name"
  type        = string
}

variable "provider_instance_size_name" {
  description = "Atlas cluster provider instance name"
  default     = "M0"
  type        = string
}

variable "cluster_name" {
  description = "Atlas cluster name"
  default     = "prop-analysis-dev"
  type        = string
}

variable "user_name" {
  description = "Atlas admin user name"
  type        = string
}

variable "password" {
  description = "Atlas admin user password"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The preferred GCP region"
  type        = string
}