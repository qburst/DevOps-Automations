module "ecs_cluster" {
  source = "../../modules/ecs-cluster"

  name = "mng-ecs-cluster-fargate01"

  enable_container_insights = true

  tags = {
    ManagedBy   = "terraform"
    Project     = "CloudMigration-PoC"
    Environment = "Type-Int"
  }
}

