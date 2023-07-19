locals {
  bucket_name = length(var.source_bucket) > 0 ? var.source_bucket : google_storage_bucket.default[0].name
}

resource "random_id" "default" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  count = length(var.source_bucket) > 0 ? 0 : 1
  name                        = "${random_id.default.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = var.location
  uniform_bucket_level_access = true
}

data "archive_file" "default" {
  type        = "zip"
  output_path = "/tmp/function-source.zip"
  source_dir  = var.source_dir
}

resource "google_storage_bucket_object" "object" {
  name   = "${var.function_name}/function-source.zip"
  bucket = local.bucket_name
  source = data.archive_file.default.output_path # path to the zipped function source code
}

resource "google_cloudfunctions2_function" "default" {
  name        = var.function_name
  location    = var.location
  description = var.description

  build_config {
    runtime     = var.config.runtime
    entry_point = var.config.entry_point # Set the entry point
    source {
      storage_source {
        bucket = local.bucket_name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count = var.config.max_instance_count
    available_memory   = var.config.available_memory
    timeout_seconds    = var.config.timeout_seconds
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  count = var.make_public == true ? 1 : 0
  depends_on = [ google_cloudfunctions2_function.default ]
  location = var.location
  service = var.function_name
  role = "roles/run.invoker"
  member = "allUsers"
}