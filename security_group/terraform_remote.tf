data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "kpikachu"
    workspaces = {
      name = "vpc_test"
    }
  }
}