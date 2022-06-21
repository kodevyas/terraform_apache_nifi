# GKE cluster for hosting Apache Nifi

This deployment has two resources:
1. GKE Cluster
2. Nodepool

## Dependencies
1. GCP Project
2. Terraform

## How to setup

1. Create a Service Account in GCP with permission to create GKE cluster and Compute instances.
2. Generate the Key for the Service Account
3. Clone the repository
4. Create a *values.tfvars* file at the root
5. Insert the path for the json key for the Service Account in *values.tfvars file*.
6. Add values for all the other variables defined in the *variables.tf* in *values.tfvars file*.
7. To initialize the Terrform, run the following command at the root of the directory
    `$ terraform init`
8. Run Terrform plan to see all the resources that will be created and check the values assigned and pass the *values.tfvars* file.
    `$ terraform plan -var-file 'values.tfvars'`
9. Run Terraform apply to apply the configurations in your cloud environment.
    `$ terraform apply -var-file 'values.tfvars'`