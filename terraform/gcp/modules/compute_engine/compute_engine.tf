resource "google_compute_instance" "compute_engine" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["QBurst"]

  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "QBurst"
      }
    }
  }
  network_interface {
    network = var.network
   
  }
service_account {
    email  = google_service_account.computeengine_sa.email
    #The scope can be changed based on requirement.By using cloud-platform,it has full access to all APIs.In ideal case, restrict the scope
    scopes = ["cloud-platform"]
  }
}

resource "google_service_account" "computeengine_sa" {
  account_id   = "compute-engine-sa"
  display_name = "Service Account"
}
