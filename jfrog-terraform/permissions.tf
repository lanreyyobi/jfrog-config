# read-only permissions to all repos

resource "artifactory_permission_target" "read-only" {
  name = "read-only"

  repo {
    includes_pattern = ["**"]
    excludes_pattern = []
    repositories = [
      "ANY LOCAL",
      "ANY REMOTE"
    ]

    actions {
      groups {
        name        = var.developer_group
        permissions = ["read"]
      }
    }
  }
}

/* remote-caching
**
** Description:
**    Provides the ability to cache remote artifacts locally.
**    Without this, developers will not be able to pull from
**    mirrors unless someone with write access has already
**    cached the artifact.
*/
resource "artifactory_permission_target" "remote-caching" {
  name = "remote-caching"

  repo {
    includes_pattern = ["**"]
    excludes_pattern = []
    repositories     = ["ANY REMOTE"]

    actions {
      groups {
        name        = var.developer_group
        permissions = ["write"]
      }
      groups {
        name        = artifactory_group.machines-readonly.name
        permissions = ["write"]
     }

      // All teams need to be able to access remote cache
      dynamic "groups" {
        for_each = toset([for k, v in local.groups : k])
        content {
          name        = artifactory_group.team-write[groups.value].name
          permissions = ["write"]
        }
      }
    }
  }
}


resource "artifactory_permission_target" "team-generic-write" {
  for_each = toset([
    for group_name in keys(local.groups) :
    group_name if length(lookup(local.groups[group_name], "generic_repos", [])) > 0
  ])
  name = "${each.key}-generic-write"

  repo {
    includes_pattern = ["**"]
    repositories     = local.groups[each.key]["generic_repos"]

    actions {
      groups {
        name = artifactory_group.team-write[each.key].name
        permissions = [
          "read",
          "annotate",
          "managedXrayMeta",
          "write"
        ]
      }
    }
  }
}

resource "artifactory_permission_target" "team-terraform-write" {
  for_each = toset([for k, v in local.groups : k])
  name     = "${each.key}-tf-write"

  repo {
    includes_pattern = ["${each.key}/**/*"]
    repositories = [
      artifactory_local_terraform_module_repository.terraform-local-modules.key,
      artifactory_local_terraform_provider_repository.terraform-local-provider.key
    ]

    actions {
      groups {
        name = artifactory_group.team-write[each.key].name
        permissions = [
          "annotate",
          "manage",
          "managedXrayMeta",
          "read",
          "write"
        ]
      }
    }
  }
}