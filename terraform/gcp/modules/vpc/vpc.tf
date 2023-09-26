locals {
  router_regions     = tolist(toset([for x in var.subnet_config : x.subnet_region if x.nat_gw_enabled == true]))
  auto_nat_subnets   = [for x in var.subnet_config : x if x.nat_gw_enabled == true && x.nat_ip_allocate_option == "AUTO_ONLY"]
  manual_nat_subnets = [for x in var.subnet_config : x if x.nat_gw_enabled == true && x.nat_ip_allocate_option == "MANUAL_ONLY"]
}

resource "google_compute_network" "default" {
  name                    = "${var.name_prefix}-vpc"
  auto_create_subnetworks = false
}


resource "google_compute_router" "router" {
  count   = length(local.router_regions) > 0 ? length(local.router_regions) : 0
  name    = "${var.name_prefix}-${local.router_regions[count.index]}-router"
  network = google_compute_network.default.id
  region  = local.router_regions[count.index]
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}

resource "google_compute_subnetwork" "default" {
  count = length(var.subnet_config)

  name          = "${var.subnet_config[count.index].name}-subnetwork"
  ip_cidr_range = var.subnet_config[count.index].subnet_ip_cidr_range
  region        = var.subnet_config[count.index].subnet_region
  network       = google_compute_network.default.id
}


resource "google_compute_router_nat" "auto_nat" {

  depends_on = [google_compute_router.router, google_compute_subnetwork.default]
  count      = length(local.auto_nat_subnets)
  name       = "${local.auto_nat_subnets[count.index].name}-nat"
  router     = "${var.name_prefix}-${local.auto_nat_subnets[count.index].subnet_region}-router"
  region     = local.auto_nat_subnets[count.index].subnet_region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = "${local.auto_nat_subnets[count.index].name}-subnetwork"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}

resource "google_compute_address" "address" {
  depends_on = [google_compute_router.router, google_compute_subnetwork.default]
  count      = length(local.manual_nat_subnets)
  name       = "nat-manual-ip-${local.manual_nat_subnets[count.index].name}"
  region     = local.manual_nat_subnets[count.index].subnet_region
}

resource "google_compute_router_nat" "manual_nat" {

  depends_on = [google_compute_router.router, google_compute_subnetwork.default, google_compute_address.address]
  count      = length(local.manual_nat_subnets)
  name       = "${local.manual_nat_subnets[count.index].name}-nat"
  router     = "${var.name_prefix}-${local.manual_nat_subnets[count.index].subnet_region}-router"
  region     = local.manual_nat_subnets[count.index].subnet_region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = ["nat-manual-ip-${local.manual_nat_subnets[count.index].name}"]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = "${local.manual_nat_subnets[count.index].name}-subnetwork"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}