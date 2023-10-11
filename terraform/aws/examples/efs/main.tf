module "efs" {
  source           = "../../modules/efs"
  creation_token   = "test-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encryption_set   = true
  subnet_id        = ["subnet-01234567890abcdef","subnet-01234567890ghijklm"]
  security_groups  = ["sg-01234567890abcdef", "sg-01234567890abcdef"]

}

output "example_outputs" {
  value = module.efs
}
