terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Recommended: remote state per environment
  # backend "s3" {
  #   bucket = "my-tf-state-bucket"
  #   key    = "dev/terraform.tfstate"
  #   region = "ap-south-1"
  # }
}

provider "aws" {
  region = var.region
}

locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = var.project
  }
}

module "security_group" {
  source = "../../modules/security-group"

  name          = "${var.project}-${var.environment}"
  description   = "Security group for ${var.environment} instances"
  vpc_id        = var.vpc_id
  ingress_rules = var.ingress_rules
  tags          = local.common_tags
}

module "ec2" {
  source = "../../modules/ec2"

  name               = "${var.project}-${var.environment}-app"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = var.subnet_id
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.key_name
  root_volume_size   = var.root_volume_size
  tags               = local.common_tags
}

module "s3" {
  source = "../../modules/s3"

  bucket_name        = var.bucket_name
  versioning_enabled = var.versioning_enabled
  force_destroy      = var.force_destroy
  tags               = local.common_tags
}
