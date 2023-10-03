module "cloud_function_v2" {
  source        = "/.../.../gcp/modules/cloud_function_v2"
  function_name = "new-function"
  location      = "us-central1"
  make_public   = true
  config = {
    runtime     = "python310"
    entry_point = "hello_http"
  }

}

output "cloud_function_v2_module_outputs" {
  value = module.cloud_function_v2
}