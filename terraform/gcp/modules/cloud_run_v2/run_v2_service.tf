data "google_project" "project" {
}

locals {
  project   = data.google_project.project.project_id
  connector = length(var.vpc_connector) > 0 ? ["${var.vpc_connector}"] : []
}

resource "google_cloud_run_v2_service" "default" {
  name     = var.service_name
  location = var.location
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      min_instance_count = var.min_instance_count
      max_instance_count = var.max_instance_count
    }

    containers {
      image = var.img_url
      ports {
        container_port = var.container_port
      }
      dynamic "env" {
        for_each = var.container_env
        content {
          name  = env.value.key
          value = env.value.value
        }
      }
    }

    dynamic "vpc_access" {
      for_each = local.connector
      content {
        connector = "projects/${local.project}/locations/${var.location}/connectors/${var.vpc_connector}"
        egress    = "ALL_TRAFFIC"
      }
    }
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  count    = var.make_public == true ? 1 : 0
  location = var.location
  service  = var.service_name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}