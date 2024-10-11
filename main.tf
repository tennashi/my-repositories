terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

provider "github" {}

resource "github_repository" "my_repositories" {
  name = "my-repositories"
  description = "My git repositories"

  visibility = "public"
}
