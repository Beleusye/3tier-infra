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

data "terraform_remote_state" "loadbalancer" {
  backend = "remote"

  config = {
    organization = "kpikachu"
    workspaces = {
      name = "loadbalancer_test"
    }
  }
}

data "terraform_remote_state" "rds" {
  backend = "remote"

  config = {
    organization = "kpikachu"
    workspaces = {
      name = "rds_test"
    }
  }
}