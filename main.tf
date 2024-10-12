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

  has_issues = true

  delete_branch_on_merge = true

  security_and_analysis {
    advanced_security {
      status = "enabled"
    }

    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}
