locals {
  groups = {
    cloudops = {
      docker_namespaces = [
        "cloudops"
      ]
      generic_repos = [
        "cloudops-bin"
      ]
      use_helm      = true
      use_terraform = true
    }
  }
}

locals {
  // See the README for list, formatting needs to match exactly.
  permitted_licenses = [
    "Apache-2.0",
    "BSD",
    "BSD-3-Clause",
    "BSD-2-Clause",
    "GPL-2.0",
    "GPL-2.0-only",
    "GPL-2.0-or-later",
    "GPL-3.0",
    "LGPL-2.1-or-later",
    "MIT",
    "MPL-2.0",
    "OpenSSL",
    "ZLIB",
    "Zlib"
  ]
}

locals {
  repos = {
    generic = toset(flatten([
      for group_name in keys(local.groups) :
      lookup(local.groups[group_name], "generic_repos", [])
    ]))
    terraform = toset([
      for group_name in keys(local.groups) :
      lower(group_name) if lookup(local.groups[group_name], "use_terraform", false)
    ])
  }
}

