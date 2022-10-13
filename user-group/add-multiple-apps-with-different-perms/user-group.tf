data "harness_application" "regulated_apps" {
  for_each = toset( var.regulated_apps )
  name = each.key
}


data "harness_application" "nonregulated_apps" {
  for_each = toset( var.nonregulated_apps )
  name = each.key
}

resource "harness_user_group" "multiperm-multiapp-tf-example-group" {
    name        = "multiperm-multiapp-tf-example-group"

    permissions {
        account_permissions = [
            "CREATE_CUSTOM_DASHBOARDS"
        ]

        app_permissions {

            all {
                app_ids = [
                    for app in data.harness_application.nonregulated_apps:
                    app.id
                ]
                actions = ["ABORT_WORKFLOW", "EXECUTE_PIPELINE", "EXECUTE_WORKFLOW", "READ", "ROLLBACK_WORKFLOW", "CREATE", "UPDATE", "DELETE"]
            }

            deployment {
                filters = ["NON_PRODUCTION_ENVIRONMENTS"]
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["ABORT_WORKFLOW", "EXECUTE_PIPELINE", "EXECUTE_WORKFLOW", "READ", "ROLLBACK_WORKFLOW"]
            }

            deployment {
                filters = ["PRODUCTION_ENVIRONMENTS"]
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["ABORT_WORKFLOW", "EXECUTE_PIPELINE", "READ"]
            }

            environment {
                filters = ["PRODUCTION_ENVIRONMENTS", "NON_PRODUCTION_ENVIRONMENTS"]
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["CREATE", "READ", "UPDATE", "DELETE"]
            }

            pipeline {
                filters = ["NON_PRODUCTION_PIPELINES"]
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["CREATE", "READ", "UPDATE", "DELETE"]
            }

            pipeline {
                filters = ["PRODUCTION_PIPELINES"]
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["READ"]
            }

            provisioner {
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["CREATE", "READ", "UPDATE", "DELETE"]
            }

            service {
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["CREATE", "READ", "UPDATE", "DELETE"]
            }

            template {
                app_ids = [
                    for app in data.harness_application.regulated_apps:
                    app.id
                ]
                actions = ["CREATE", "READ", "UPDATE", "DELETE"]
            }
        }
    }
}