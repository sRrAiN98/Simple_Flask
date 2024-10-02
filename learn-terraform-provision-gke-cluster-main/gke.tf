# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "node_locations" {
  description = "List of zones for node pool"
  type        = list(string)
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
} 

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location = var.region
  version_prefix = "1.30."
}

resource "google_container_cluster" "primary" {
  name     = "${var.name}-gke"
  node_locations = var.node_locations  # tfvars에서 정의한 노드 영역

  # 기본 노드 풀을 생성하지 않도록 설정
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  # 노드 설정
  node_config {
    machine_type = "n1-standard-1"
    disk_type    = "pd-standard"  # 표준 HDD 사용
    disk_size_gb = 100             # 원하는 디스크 용량
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.region
  cluster  = google_container_cluster.primary.name
  
  version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_locations = var.node_locations  # tfvars에서 정의한 노드 영역
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    disk_type    = "pd-standard"  # 표준 HDD 사용
    disk_size_gb = 100             # 원하는 디스크 용량
    tags         = ["gke-node", "${var.name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}



# # Kubernetes provider
# # The Terraform Kubernetes Provider configuration below is used as a learning reference only. 
# # It references the variables and resources provisioned in this file. 
# # We recommend you put this in another file -- so you can have a more modular configuration.
# # https://learn.hashicorp.com/terraform/kubernetes/provision-gke-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider.

# provider "kubernetes" {
#   load_config_file = "false"

#   host     = google_container_cluster.primary.endpoint
#   username = var.gke_username
#   password = var.gke_password

#   client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
#   client_key             = google_container_cluster.primary.master_auth.0.client_key
#   cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
# }
