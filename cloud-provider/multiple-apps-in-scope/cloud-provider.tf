//local scopes{}

data "harness_application" "myapps" {
  for_each = toset( var.apps )
  name = each.key
}

resource "harness_cloudprovider_kubernetes" "demo" {
  name = "terraform-example-multiple-apps"

  authentication {
    delegate_selectors = ["k8s"]
  }
    
  dynamic "usage_scope" {
    for_each = data.harness_application.myapps
    content {
      application_id = usage_scope.value.id
      environment_filter_type = "NON_PRODUCTION_ENVIRONMENTS"
    }
  }
}