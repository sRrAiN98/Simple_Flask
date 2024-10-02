# Learn Terraform - Provision a GKE Cluster

This repo is a companion repo to the [Provision a GKE Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke), containing Terraform configuration files to provision an GKE cluster on GCP.

This sample repo also creates a VPC and subnet for the GKE cluster. This is not
required but highly recommended to keep your GKE cluster isolated.


# 코드 수정
 
**VPC, GKE 이름 변수 추가**   
    name       = "jaehee"

**사용할 노드 영역 변수 추가**   
    node_locations = ["asia-northeast3-a", "asia-northeast3-c"]    
    asia-northeast3-b의 제한으로 인해 가용 영역 수정   

**원하는 노드 수 설정**    
    gke_num_nodes = 1  

**무료 사용량만큼의 디스크 용량 수정**   
    disk_type    = "pd-standard"  # 표준 HDD 사용   
    disk_size_gb = 100             # 원하는 디스크 용량