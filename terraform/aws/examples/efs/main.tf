module "efs" {
  source           = "../../modules/efs"
  creation_token   = "test-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

}

output "example_outputs" {
  value = module.efs
}
