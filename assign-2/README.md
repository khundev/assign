# Assign 2 - Kubernetes 

## counter
need to create config file for counter deployment
```
kubectl get configmap
```
```
kubectl create configmap counter-config --from-file=index.html
```
it contains the application code which will locate to the direction /usr/share/nginx 
so every time changes to application code applied, need to update just this config

To run the nginx deployment
```
kubectl apply -f counter.yml
```

finally counter-service will expose the deployment outside the cluster
```
kubectl apply -f counter-service.yml
```

this is for demonstration only and minikube is used for local development
to expose the service, run this command
```
minikube service counter-service
```
## mysql

## deliverables