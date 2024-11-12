#!/bin/bash

# 현재 디렉토리에 애플리케이션과 시크릿, ConfigMap 폴더 생성
APP_DIR="./applications"
SECRET_DIR="./secrets"
CONFIGMAP_DIR="./configmaps"
mkdir -p $APP_DIR
mkdir -p $SECRET_DIR
mkdir -p $CONFIGMAP_DIR

echo "Backing up to directories: $APP_DIR for applications, $SECRET_DIR for secrets, $CONFIGMAP_DIR for configmaps"

# argocd 네임스페이스의 애플리케이션 백업
echo "Backing up applications in argocd namespace..."
APPLICATIONS=$(kubectl get applications -n argocd -o jsonpath='{.items[*].metadata.name}')

for APP_NAME in $APPLICATIONS; do
    kubectl get applications -n argocd $APP_NAME -o yaml > $APP_DIR/${APP_NAME}_argocd_application.yaml
    echo "Backed up application $APP_NAME in namespace argocd."
done

# argocd 네임스페이스의 시크릿 백업
echo "Backing up secrets in argocd namespace..."
SECRETS=$(kubectl get secrets -n argocd -o jsonpath='{.items[*].metadata.name}')

for SECRET_NAME in $SECRETS; do
    kubectl get secrets -n argocd $SECRET_NAME -o yaml > $SECRET_DIR/${SECRET_NAME}_argocd_secret.yaml
    echo "Backed up secret $SECRET_NAME in namespace argocd."
done

# argocd 네임스페이스의 ConfigMap 백업
echo "Backing up configmaps in argocd namespace..."
CONFIGMAPS=$(kubectl get configmaps -n argocd -o jsonpath='{.items[*].metadata.name}')

for CONFIGMAP_NAME in $CONFIGMAPS; do
    kubectl get configmaps -n argocd $CONFIGMAP_NAME -o yaml > $CONFIGMAP_DIR/${CONFIGMAP_NAME}_argocd_configmap.yaml
    echo "Backed up configmap $CONFIGMAP_NAME in namespace argocd."
done


echo "Backup completed. Files are saved in $APP_DIR and $SECRET_DIR."

