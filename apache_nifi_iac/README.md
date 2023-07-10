
# GKE cluster for hosting Apache Nifi

This terraform script will create following resources:

1. GKE Cluster
2. Nodepool
3. Persistent Disk
4. Persistent Disk Claim
5. Kubernetes Deployment

  

## Directory Structure

```
.
├── .circleci
│   └── config.yaml
│   
└── apache_nifi_iac
    ├── README.md
    ├── main.tf
    ├── provider.tf
    └── variables.tf

```

  

## Dependencies

1. GCP Project
2. Terraform


In the **apache_nifi_iac**

1.  We define a GKE cluster using `google_container_cluster` resource.
2.  We create a persistent disk using `google_compute_disk` resource.
3.  We set up a persistent volume using `kubernetes_persistent_volume` resource, referencing the persistent disk created above.
4.  We create a persistent volume claim using `kubernetes_persistent_volume_claim` resource, which requests storage from the persistent volume.
5.  Finally, we define an Apache NiFi deployment using `kubernetes_deployment` resource. The deployment uses the persistent volume claim and mounts it to the container at `/opt/nifi/data`.

You can customize the values, such as cluster location, disk size, persistent volume size, and other configurations, as needed. Make sure you have the necessary provider and authentication configurations in place to interact with GKE and the Kubernetes cluster using Terraform.



In the **.circleci/config.yaml**:

1.  We specify the CircleCI version and define a single job called `deploy`.
2.  We use the `hashicorp/terraform:latest` Docker image as the execution environment.
3.  The `working_directory` specifies the path to your Terraform project in the repository.
4.  In the `steps` section:
    -   `checkout` checks out the repository code.
    -   We set up Google Cloud credentials using the `GOOGLE_CREDENTIALS_JSON`, `GOOGLE_PROJECT_ID`, `GOOGLE_CLUSTER_NAME`, and `GOOGLE_CLUSTER_REGION` environment variables. Make sure you configure these variables in your CircleCI project settings or use a secrets management feature.
    -   We install any necessary dependencies, such as the `make` utility.
    -   We initialize Terraform using `terraform init`.
    -   We plan the Terraform changes using `terraform plan` and save the plan to `tfplan`.
    -   Finally, we apply the Terraform changes using `terraform apply -auto-approve tfplan`.

Make sure you replace the placeholder values (`$GOOGLE_CREDENTIALS_JSON`, `$GOOGLE_PROJECT_ID`, `$GOOGLE_CLUSTER_NAME`, and `$GOOGLE_CLUSTER_REGION`) with the appropriate values for your Google Cloud project.

With this CircleCI configuration file in place, CircleCI will automatically trigger a deployment whenever there are changes to your Terraform code. You can also manually trigger a deployment by running the CircleCI pipeline.