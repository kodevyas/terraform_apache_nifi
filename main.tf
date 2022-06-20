resource "google_container_cluster" "xapo-cluster" {
  name     = var.cluster_name
  location = var.cluster_region
  network = var.cluster_vpc
  subnetwork = var.cluster_vpc_subnet
  min_master_version = var.cluster_master_version
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary-node-pool" {
  name       = var.primary_node_pool
  cluster    = google_container_cluster.xapo-cluster.id
  node_count = var.primary_node_pool_node_count
  version = var.primary_node_pool_node_version
  
  management {
    auto_repair  = true
    auto_upgrade = false
  }
  node_config {
    preemptible  = true
    machine_type = var.primary_node_pool_machine_type
    service_account = var.primary_node_pool_service_account
    image_type = var.primary_node_pool_image_type
    disk_type = var.primary_node_pool_disk_type
    disk_size_gb = var.primary_node_pool_disk_size
  }
}
