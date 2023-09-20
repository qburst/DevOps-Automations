provider "google"{
    project = "qburst-devops-automation"
    region = "us-central1"
    credentials = "${file("credentials.json")}"
    
}