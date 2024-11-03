data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "kpikachu"
    workspaces = {
      name = "vpc_test"
    }
  }
}

data "terraform_remote_state" "security_group" {
  backend = "remote"

  config = {
    organization = "kpikachu"
    workspaces = {
      name = "security_group_test"
    }
  }
}