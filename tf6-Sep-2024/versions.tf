terraform {
  cloud {
    organization = "p2k"
    hostname = "app.terraform.io"
    workspaces {
      name = "random-string-test"
    }
  }
}
