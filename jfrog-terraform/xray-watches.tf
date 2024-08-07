resource "xray_watch" "all-repos" {
  name        = "all-repos-watch"
  description = "Watch for all repositories"
  active      = true

  watch_resource {
    bin_mgr_id = "default"
    name       = "All Repositories"
    type       = "all-repos"
  }

  assigned_policy {
    name = xray_security_policy.critical-cve-notify.name
    type = "security"
  }

}
