
resource "artifactory_group" "machines-readonly" {
  name             = "machines-readonly"
  description      = "Read-only group for programmatic access to Artifactory"
  admin_privileges = false
  auto_join        = false
}

resource "artifactory_group" "ci-write" {
  name             = "ci-write"
  description      = "CI User Group v1"
  admin_privileges = false
  auto_join        = false
}

resource "artifactory_group" "team-write" {
  for_each         = toset([for k, v in local.groups : k])
  name             = "${each.key}-write"
  description      = "Group to vend read/write tokens for ${each.key}."
  admin_privileges = false
  auto_join        = false
}