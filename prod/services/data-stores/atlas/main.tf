resource "mongodbatlas_database_user" "my_user" {
  username           = var.user_name
  password           = var.password
  project_id         = var.project_id
  auth_database_name = "admin"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }

  backend "gcs" {
    bucket = "tth-prop-analysis-bucket"
    prefix = "prod/atlas/terraform.tfstate"
  }
}

 provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

resource "mongodbatlas_project_ip_access_list" "ip_access_list" {
  project_id = var.project_id
  ip_address = data.terraform_remote_state.scheduled_job.outputs.external_ip_address
  comment    = "prop-puller external IP"
}

data "terraform_remote_state" "scheduled_job" {
  backend = "gcs"

  config = {
    bucket = "tth-prop-analysis-bucket"
    prefix = "prod/scheduled_job/terraform.tfstate"
  }
}

resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id   = var.project_id
  name         = var.cluster_name
  cluster_type = "REPLICASET"

  replication_specs {
    num_shards = 1

    region_configs {
      electable_specs {
        instance_size = var.provider_instance_size_name
        node_count    = 3
      }
      provider_name = var.backing_provider_name
      region_name   = "SOUTHEASTERN_ASIA_PACIFIC"
      priority      = 7
    }
  }

  tags {
    key   = "environment"
    value = "prod"
  }

  tags {
    key   = "author"
    value = "tzehon"
  }
}
