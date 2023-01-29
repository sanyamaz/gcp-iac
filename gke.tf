//gke VPC

resource "google_compute_network" "gke_vpc" {
  project                 = var.project
  name                    = "gke-vpc"
  auto_create_subnetworks = false
  #routing_mode = "GLOBAL"
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "34.23.0.0/16"
  region        = var.region
  network       = google_compute_network.gke_vpc.id
}

//GKE cluster

resource "google_container_cluster" "gke_cluster" {
  name                     = "gke-${var.project}"
  location                 = var.zone #will be a zonal cluster
  remove_default_node_pool = true
  network                  = google_compute_network.gke_vpc.self_link
  subnetwork               = google_compute_subnetwork.gke_subnet.self_link
  initial_node_count       = 1
}

resource "google_container_node_pool" "gke_nodes" {
  name       = "gke-${var.project}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-medium" // or medium

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = module.gke_sa["gke-sa"].sa_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
