terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kpikachu"

    workspaces {
      name = "instance_test"
    }
  }
}
