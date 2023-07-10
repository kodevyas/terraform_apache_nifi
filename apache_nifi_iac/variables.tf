variable "google_project" {
  type = string
  description = "Name of GCP project to deploy Apache Nifi"
}

variable "service_account_key" {
  type = string
  description = "Path for the Service Account json key for accessing GCP resources"
}

variable "cluster_name" {
  type = string
  description = "Name of the cluster to host apace nifi"
  default = "xapo-cluster"
}

variable "cluster_region" {
  type = string
  description = "GCP region for the Apache Nifi"
  default = "us-central1-a"
}

variable "cluster_vpc" {
  type = string
  description = "VPC for cluster to be created in"
  default = "default"
}

variable "cluster_vpc_subnet" {
  type = string
  description = "Subnet for the cluster to be created in"
}
variable "cluster_master_version" {
  type = string
  description = "The minimum Kubernetes version on the master"
  default = "1.21.11-gke.1900"
}
variable "primary_node_pool" {
  type = string
  description = "Name for the primary node-pool"
  default = "primary-node-pool"
}

variable "primary_node_pool_node_count" {
  type = number
  description = "Number of nodes for the primary node-pool"
  default = 1
}

variable "primary_node_pool_node_version" {
  type = string
  description = "GKE version for nodes"
  default = "1.21.10-gke.2000"
}

variable "primary_node_pool_machine_type" {
  type = string
  description = "Machine type for primary node-pool nodes"
  default = "e2-standard-2"
}

variable "primary_node_pool_service_account" {
  type = string
  description = "Service Account for the primary node-pool"
  default = "default"
}

variable "primary_node_pool_image_type" {
  type = string
  description = "Image type for the primary node-pool"
  default = "COS"
}

variable "primary_node_pool_disk_type" {
  type = string
  description = "Boot disk type for the primary node-pool"
  default = "pd-standard"
}

variable "primary_node_pool_disk_size" {
  type = number
  description = "Disk size in GB for primary node pool"
  default = 20
}

variable "nifi_persistent_disk_name" {
  type = string
  description = "Name of the persistent disk for nifi deployment"
  default = "nifi-persistent-disk"
}

variable "nifi_persistent_disk_size" {
  type = number
  description = "Disk size in GB for nifi persistent disk"
  default = 100
}

variable "nifi_persistent_disk_type" {
  type = string
  description = "Disk type for nifi persitent disk"
  default = "pd-standard"
}

variable "nifi_persistent_disk_zone" {
  type = string
  description = "GCP zone for nifi_persistent disk"
  default = "us-central1-a"
}

variable "nifi_persistent_volume_name" {
  type = string
  description = "Name of the persistent volume for nifi deployment"
  default = "nifi_persistent_volume"
}

variable "nifi_persistent_volume_storage" {
  type = string
  description = "Disk size in GB for nifi persistent volume"
  default = "20Gi"
}

variable "nifi_persistent_volume_access_modes" {
  type = string
  description = "Access mode for nifi persistent volume"
  default = "ReadWriteOnce"
}

variable "nifi_persistent_volume_claim_name" {
  type = string
  description = "Name of the persistent volume claim"
  default = "nifi_persistent_volume_claim"
}

variable "nifi_deployment_name" {
  type = string
  description = "Name of the nifi deployment"
  default = "nifi_deployment_name"
}

variable "nifi_deployment_replica_count" {
  type = number
  description = "Number of replicas for nifi deployment"
  default = 1
}

variable "nifi_deployment_container_name" {
  type = string
  description = "Name of the nifi container"
  default = "nifi"
}

variable "nifi_deployment_container_image" {
  type = string
  description = "Container image for nifi"
  default = "apache/nifi:latest"
}

variable "nifi_deployment_containter_port" {
  type = string
  description = "Port where nifi container has to be exposed"
  default = 8080
}

variable "nifi_deployment_container_pd_mount_path" {
  type = string
  description = "Path inside the container where nifi persistent disk has to be mounted"
  default = "/opt/nifi/data"
}