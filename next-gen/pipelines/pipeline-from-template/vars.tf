variable "codebase_connector" {
    description = "Connector ID of the codebase connector for the build stage"
}

variable "codebase_repo" {
    description = "Name of the repository to be built in the build stage"
}

variable "docker_repo" {
    description = "Docker repository to hold the image being built an deployed"
}

variable "service_id" {
    description = "Identifier of the service being deployed"
}

variable "primary_artifact_id" {
    description = "Identifier of the primary artifact source on the service being deployed"
}

variable "env_id" {
    description = "Identifier of the environment being deployed to"
}

variable "infra_id" {
    description = "Identifier of the infrastructure definition under the environment being deployed to"
}

variable "org_id" {
    description = "Identifier for the org where this is to be installed"
}

variable "project_id" {
    description = "Identifier for the projecta where this is to be installed"
}

variable "pipeline_id" {
    description = "Identifier to give the pipeline being created"
}

variable "pipeline_name" {
    description = "Name to give the pipeline being created"
}
