terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kpikachu"

    workspaces {
      name = "rds_test"
    }
  }
}
