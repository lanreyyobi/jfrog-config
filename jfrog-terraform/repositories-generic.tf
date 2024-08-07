resource "artifactory_local_generic_repository" "team-generic-local" {
  for_each = local.repos.generic

  key = each.key
}