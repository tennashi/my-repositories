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

resource "github_repository_ruleset" "main" {
  name = "main"
  repository = github_repository.my_repositories.name

  enforcement = "active"

  target = "branch"

  conditions {
    ref_name {
      exclude = []
      include = [ "~DEFAULT_BRANCH" ]
    }
  }

  rules {
    creation = true
    deletion = true
    required_linear_history = true
    non_fast_forward = true

    pull_request {
      required_review_thread_resolution = true
      require_last_push_approval = true
      dismiss_stale_reviews_on_push = true
    }
  }
}
