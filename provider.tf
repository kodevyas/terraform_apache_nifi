provider "google" {
    project =   var.google_project
    region = var.cluster_name
    # Need to create variable for credentials
    credentials = file(var.service_account_key)
}