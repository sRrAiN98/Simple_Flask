1. 구글 클라우드 계정 활성화
2. 구글 API 활성화
    # Kubernetes Engine
    gcloud services enable container.googleapis.com 
    # Compute Engine
    gcloud services enable compute.googleapis.com 

3. 테라폼 모듈 다운로드
    https://github.com/hashicorp/terraform-google-terraform-enterprise-gke-hvd 가 좀 더 최신버전 모듈을 사용했기에
    examples/new-gke-cluster 에 있는 모듈을 사용하여 프로비저닝
    
4. 테라폼 apply 
    VPC, GKE 프로비저닝

5. Jenkins, ArgoCD 배포
6. 간단한 파이썬 git에 업로드하여 배포

7. loki, grafana 설치
8. 오픈텔레메터리 설치