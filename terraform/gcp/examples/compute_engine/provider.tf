provider "google"{
    project = "qburst-devops-automation"
    region = "us-central1"
    credentials = "${file("credentials.json")}"
    
}
terraform {
  required_version = "1.5.0"
}