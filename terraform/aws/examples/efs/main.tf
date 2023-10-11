module "efs" {
  source           = "../../modules/efs"
  creation_token   = "test-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encryption_set   = true
  kms_key_id       = "arn:aws:kms:ap-south-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  subnet_id        = "subnet-01234567890abcdef"
  security_groups  = ["sg-01234567890abcdef", "sg-01234567890abcdef"]

}

output "example_outputs" {
  value = module.efs
}
