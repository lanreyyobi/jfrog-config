
resource "artifactory_user" "admin" {
  name              = "admin"
  email             = ""
  admin             = true
  disable_ui_access = false
}

resource "artifactory_user" "wema" {
  name              = ""
  email             = ""
  admin             = true
  groups            = ["readers", "cloudops-write"]
  disable_ui_access = false
  password = ""
}