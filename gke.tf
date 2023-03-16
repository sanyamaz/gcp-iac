//GKE VPC
resource "google_compute_network" "gke_vpc" {
  project                 = var.project
  name                    = "gke-vpc"
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "34.23.0.0/16"
  region        = var.region
  network       = google_compute_network.gke_vpc.id
}

//GKE cluster
#resource "google_container_cluster" "gke_cluster" {
#  name                     = "gke-${var.project}"
#  location                 = var.region
#  remove_default_node_pool = true
#  network                  = google_compute_network.gke_vpc.self_link
#  subnetwork               = google_compute_subnetwork.gke_subnet.self_link
#  initial_node_count       = 1
#
#  depends_on = [google_project_service.app_cloud_services["compute.googleapis.com"]]
#}
#
#resource "google_container_node_pool" "gke_np" {
#  name       = "gke-${var.project}-np"
#  location   = var.region
#  cluster    = google_container_cluster.gke_cluster.name
#  node_count = 2
#
#  node_config {
#    #preemptible  = true
#    image_type   = "COS_CONTAINERD"
#    machine_type = "e2-small"
#    service_account = google_service_account.gke_sa.email
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/cloud-platform"
#    ]
#  }
#
#  depends_on = [google_project_service.app_cloud_services["compute.googleapis.com"]]
#}
