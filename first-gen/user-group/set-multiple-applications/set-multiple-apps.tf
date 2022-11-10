data "harness_application" "myapps" {
  for_each = toset( var.apps )
  name = each.key
}

resource "harness_user_group" "app_developer" {
  name        = "multiapp-tf-example"
  description = "Example of setting multiple applications on a group."

  permissions {
    account_permissions = [
      "CREATE_CUSTOM_DASHBOARDS"
    ]

    app_permissions {

      all {
        app_ids = [
          for app in data.harness_application.myapps:
          app.id
        ]
        actions = ["READ"]
      }
    }
  }
}
