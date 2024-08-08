module "vpc" {
  source  = "wema.jfrog.io/tf__cloudops/s3/local"
  version = "v1.0.1"

  team   = var.team
  status = var.status
  env    = var.env
  prefix = var.prefix
  topic  = var.topic
}