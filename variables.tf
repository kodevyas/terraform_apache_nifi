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
  default = "e2-medium"
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