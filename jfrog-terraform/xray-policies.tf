// CVE Critical Notify
resource "xray_security_policy" "critical-cve-notify" {
  name        = "critical-cve-notify"
  description = "Notify on Critical CVE"
  type        = "security"

  rule {
    name     = "critical-cve-notify-1"
    priority = 1

    criteria {
      min_severity = "Critical"
    }

    actions {
      webhooks                          = []
      mails                             = []
      notify_watch_recipients           = true
      notify_deployer                   = true
      create_ticket_enabled             = false
      fail_build                        = false
      block_release_bundle_distribution = false

      block_download {
        unscanned = false
        active    = false
      }
    }
  }
}

// CVE Critical Block Download
resource "xray_security_policy" "critical-cve-block" {
  name        = "critical-cve-block"
  description = "Block on Critical CVE"
  type        = "security"

  rule {
    name     = "critical-cve-block-1"
    priority = 1

    criteria {
      min_severity = "Critical"
    }

    actions {
      webhooks                          = []
      mails                             = []
      notify_watch_recipients           = true
      notify_deployer                   = true
      create_ticket_enabled             = false
      fail_build                        = false
      block_release_bundle_distribution = false

      block_download {
        unscanned = true
        active    = true
      }
    }
  }
}

// Blocked Licenses
resource "xray_license_policy" "allowed-licenses" {
  name        = "license-whitelist"
  description = "License policy, whitelist certain licenses"
  type        = "license"

  rule {
    name     = "license-whitelist-1"
    priority = 1

    criteria {
      allowed_licenses         = local.permitted_licenses
      allow_unknown            = false
      multi_license_permissive = true
    }

    actions {
      webhooks                          = []
      mails                             = []
      block_release_bundle_distribution = false
      fail_build                        = false
      notify_watch_recipients           = true
      notify_deployer                   = true
      create_ticket_enabled             = false
      custom_severity                   = "Medium"

      block_download {
        unscanned = false
        active    = false
      }
    }
  }
}