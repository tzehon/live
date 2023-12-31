provider "aws" {
  region  = "ap-southeast-1"
  profile = "286510118323_AdministratorAccess"
}

terraform {
  backend "s3" {
    bucket  = "terraform-up-and-running-state-tth"
    key     = "stage/services/webserver-cluster/terraform.tfstate"
    region  = "ap-southeast-1"
    profile = "286510118323_AdministratorAccess"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "webserver_cluster" {
    source = "github.com/tzehon/terraform_modules//services/webserver-cluster?ref=v0.0.1"


  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-tth"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port = 12345
  to_port   = 12345
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
