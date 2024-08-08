module "vpc" {
  source = "wema.jfrog.io/tf__cloudops/vpc/local"
  version = "v1.1.0"

  private_cidr = var.private_cidr
  availability_zones = var.availability_zones
  public_cidr = var.public_cidr
  environment = var.environment
  cidr_block = var.cidr_block
  log_destination = var.log_destination
  log_destination_type = var.log_destination_type
  vpc_name  = var.vpc_name
  region = var.region
}