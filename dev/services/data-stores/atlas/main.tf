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
 }

provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

resource "mongodbatlas_project_ip_access_list" "ip_access_list" {
  project_id = var.project_id
  cidr_block = "0.0.0.0/0"
  comment    = "Allow access from anywhere"
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
      }
      provider_name         = var.provider_name
      backing_provider_name = var.backing_provider_name
      region_name           = "SOUTHEASTERN_ASIA_PACIFIC"
      priority              = 7
    }
  }

  tags {
    key   = "environment"
    value = "dev"
  }

  tags {
    key   = "author"
    value = "tth"
  }
}