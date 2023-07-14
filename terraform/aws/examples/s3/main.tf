module "s3" {
  source        = "../../modules/s3"
  bucket_name   = ["qbs3test", "qb3test1"]
  force_destroy = false
  logging = {
    bucket_name = "qbs3logtest"
    prefix      = "test_buckets/"
  }
}
