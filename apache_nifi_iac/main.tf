
# Set up kubernetes cluster
resource "google_container_cluster" "xapo-cluster" {
  name     = var.cluster_name
  location = var.cluster_region
  network = var.cluster_vpc
  subnetwork = var.cluster_vpc_subnet
  min_master_version = var.cluster_master_version
  remove_default_node_pool = true                 # to remove default node-pool
  initial_node_count       = 1
}

# Set up custom node-pool
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


# Set up persistent disk
resource "google_compute_disk" "nifi_persistent_disk" {
  name  = var.nifi_persistent_disk_name
  size  = var.nifi_persistent_disk_size
  type  = var.nifi_persistent_disk_type
  zone  = var.nifi_persistent_disk_zone
}

# Set up persistent volume
resource "kubernetes_persistent_volume" "nifi_persistent_volume" {
  metadata {
    name = var.nifi_persistent_volume_name
  }

  spec {
    capacity {
      storage = var.nifi_persistent_volume_storage
    }

    access_modes = [var.var.nifi_persistent_volume_access_modes]

    gce_persistent_disk {
      pd_name = google_compute_disk.nifi_persistent_disk.name
      fs_type = "ext4"
    }
  }
}

# Set up persistent volume claim
resource "kubernetes_persistent_volume_claim" "nifi_persistent_volume_claim" {
  metadata {
    name = var.nifi_persistent_volume_claim_name
  }

  spec {
    access_modes = [var.var.nifi_persistent_volume_access_modes]
    resources {
      requests {
        storage = var.nifi_persistent_volume_storage
      }
    }

    selector {
      match_labels = {
        "app" = "nifi"
      }
    }
  }
}

# Set up Apache NiFi deployment
resource "kubernetes_deployment" "nifi_deployment" {
  metadata {
    name = var.nifi_deployment_name
    labels = {
      "app" = "nifi"
    }
  }

  spec {
    replicas = var.nifi_deployment_replica_count

    selector {
      match_labels = {
        "app" = "nifi"
      }
    }

    template {
      metadata {
        labels = {
          "app" = "nifi"
        }
      }

      spec {
        volume {
          name = var.nifi_persistent_volume_name
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.nifi_persistent_volume_claim.metadata[0].name
          }
        }

        container {
          name  = var.nifi_deployment_container_name
          image = var.nifi_deployment_container_image
          ports {
            container_port = var.nifi_deployment_containter_port
          }

          volume_mount {
            name       = var.nifi_persistent_volume_name
            mount_path = var.nifi_deployment_container_pd_mount_path
          }
        }
      }
    }
  }
}