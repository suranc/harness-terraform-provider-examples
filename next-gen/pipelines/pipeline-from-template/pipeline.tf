data "template_file" "pipeline" {

  template = "${file("${path.module}/pipeline_from_template.tmpl.yaml")}"

  vars = {
    codebase_connector = var.codebase_connector
    codebase_repo = var.codebase_repo
    docker_repo = var.docker_repo
    env_id = var.env_id
    infra_id = var.infra_id
    org_id = var.org_id
    pipeline_id = var.pipeline_id
    pipeline_name = var.pipeline_name
    primary_artifact_id = var.primary_artifact_id
    project_id = var.project_id
    service_id = var.service_id
  }
}

resource "harness_platform_pipeline" "example_template_from_template" {
  identifier  = var.pipeline_id
  name        = var.pipeline_name
  project_id  = var.project_id
  org_id      = var.org_id
  yaml = data.template_file.pipeline.rendered
}
