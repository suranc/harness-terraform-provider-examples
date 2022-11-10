terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}

provider "harness" {
  account_id = "<account-id>"
  api_key    = "<api-token>"
}