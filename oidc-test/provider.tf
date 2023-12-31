# Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#provider block
provider "aws" {
  region = "us-east-1"

}



data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../cluster/terraform.tfstate"
  }
}




