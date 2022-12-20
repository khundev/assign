#! /bin/bash

kubectl create configmap counter-config --from-file=index.html
kubectl apply -f .
kubectl get pv,pvc,all
minikube service counter-service

