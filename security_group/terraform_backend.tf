terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kpikachu"

    workspaces {
      name = "security_group_test"
    }
  }
}
