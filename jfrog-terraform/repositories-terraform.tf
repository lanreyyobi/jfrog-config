// Remote Terraform Registry
resource "artifactory_remote_terraform_repository" "terraform-mirror-hashicorp" {
  key                     = "terraform-mirror-hashicorp"
  description             = "Mirror of registry.terraform.io and releases.hashicorp.com"
  url                     = "https://github.com/"
  terraform_registry_url  = "https://registry.terraform.io"
  terraform_providers_url = "https://releases.hashicorp.com"
}
// Local Terraform Module Registry
resource "artifactory_local_terraform_module_repository" "terraform-local-modules" {
  key = "terraform-local-modules"
}

// Local Terraform Provider Registry
resource "artifactory_local_terraform_provider_repository" "terraform-local-provider" {
  key = "terraform-local-provider"
}

// Virtual Terraform Registry: Aggregates the Local Terraform Module and the Local Terraform Provider registry
resource "artifactory_virtual_terraform_repository" "terraform-virtual" {
  key = "tf"
  repositories = [
    artifactory_remote_terraform_repository.terraform-mirror-hashicorp.key,
    artifactory_local_terraform_module_repository.terraform-local-modules.key,
    artifactory_local_terraform_provider_repository.terraform-local-provider.key,
  ]
  description             = "WemaDevOps Terraform Registry"
  default_deployment_repo = artifactory_local_terraform_module_repository.terraform-local-modules.key
}
