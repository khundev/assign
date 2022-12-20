# Assign 2 - Kubernetes 

## counter
Run counter.sh to completely setup the kubenetes objects
```
chmod +x counter.sh
./counter.sh
```
Would need to ad hoc commands to check databases and tables
To enter into the mysql pod to check database and table
``` 
kubectl exec -it <pod> -- bash
```

To enter into the mysql database
```
mysql -p test1234
```

Here in the mysql console
```
show databases;
use khundev;
show tables;
select * from khundev;
```
## About commands
need to create config file for counter deployment
```
kubectl get configmap
```
```
kubectl create configmap counter-config --from-file=index.html
```
it contains the application code which will locate to the direction /usr/share/nginx 

so every time when changes to application code applied, need to update just this config

To run the nginx deployment
```
kubectl apply -f mysql-secret.yml
```
```
kubectl apply -f counter.yml
```

finally counter-service will expose the deployment outside the cluster
```
kubectl apply -f counter-service.yml
```

this is only for demonstration and minikube is used for local development
to expose the service, run this command
```
minikube service counter-service
```

## mysql
deployment objects are used in this assignment to create mysql containers for only demonstration purpose

production workload would require stateful sets to prevent data loss from pods disruption

Managed database solutons such as AWS RDS or GCP cloud SQL are more approprite for stateful applications as they remove the overhead of managing infrastructure.

No need to run these commands if already run script
```
kubectl apply -f mysql-pvc.yml -f mysql-secret.yml -f mysql-service.yml -f mysql-table.yml -f mysql.yml
```

## assumptions
1. website code, being lack of logic to connect to the database, will not actually communicate with the mysql database

2. However, by assuming counter deployment has the capability to connect to database, it includes environment variables to initiate connection with the mysql database

3. This particular deployment is for single-instance MySQL deployment. It means that the deployment cannot be scaled - it works on exactly one Pod

4. This deployment does not support rolling updates. Therefore, the spec.strategy.type must always be set to Recreate

5. The setup is not recommended for production use