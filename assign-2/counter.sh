#! /bin/bash

# install kube prometheus operator for monitoring k8s objects
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace Kubernetes-monitoring

# install counter and mysql objects
kubectl create configmap counter-config --from-file=index.html
kubectl apply -f .
kubectl get pv,pvc,all
minikube service counter-service

