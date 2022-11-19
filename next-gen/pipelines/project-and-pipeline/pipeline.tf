data "template_file" "pipeline" {
  template = "${file("${path.module}/pipeline_from_template.tmpl.yaml")}"

  vars = {
    org_id = var.org_id
    project_id = harness_platform_project.example_project.identifier
    pipeline_id = var.pipeline_id
    pipeline_name = var.pipeline_name
  }
}

resource "harness_platform_project" "example_project" {
  identifier = var.project_id
  org_id = var.org_id
  name       = var.project_name
  color      = "#0063F7"
}

resource "harness_platform_pipeline" "example_template_from_template" {
  identifier  = var.pipeline_id
  name        = var.pipeline_name
  project_id  = harness_platform_project.example_project.identifier
  org_id      = var.org_id
  yaml = data.template_file.pipeline.rendered
}
