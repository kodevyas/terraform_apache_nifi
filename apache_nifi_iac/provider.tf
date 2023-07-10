provider "google" {
    project =   var.google_project
    region = var.cluster_region 
    # Need to create variable for credentials
    credentials = file(var.service_account_key)
}