# Assign 2 - Kubernetes 

## counter
Run counter.sh to completely setup the kubenetes objects
Minikube and helm are to be installed before this script
```
chmod +x counter.sh
./counter.sh
```

## About ad hoc commands
need to create config file for counter deployment
```
kubectl get configmap
```
```
kubectl create configmap counter-config --from-file=index.html
```
It contains the application code which will locate to the direction /usr/share/nginx 

So every time when changes to application code applied, need to update just this config

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

this is only for demonstration so minikube is used as local cluster

To expose the service, run this command
```
minikube service counter-service
```

## mysql
Deployment objects are used in this assignment to create mysql containers for only demonstration purpose

Production workload would require stateful sets to prevent data loss from pods disruption

Managed database solutions such as AWS RDS or GCP cloud SQL are more appropriate alternatives for stateful applications as they remove the overhead of managing infrastructure.

Database and tables will be created at the start of the mysql pod initiation

mysql-table.yml includes sql script which will create database and table

No need to run the following command if already run script
```
kubectl apply -f mysql-pvc.yml -f mysql-secret.yml -f mysql-service.yml -f mysql-table.yml -f mysql.yml
```

If need to check databases and tables, run the following ad hoc commands

To check database and table, replace the pod with one from the below command
``` 
kubectl get pods
kubectl exec -it <pod> -- bash
```

Here inside your pod, enter into the mysql database with your password
```
pod-bash#> mysql -p test1234
```

Then in the mysql console
```
mysql> show databases;
mysql> use khundev;
mysql> show tables;
mysql> select * from khundev;
```

## monitoring - prometheus and grafana
Run the following command after counter.sh and open localhost:3000 in browser
```
kubectl port-forward deployment/prometheus-grafana 3000 -n kubernetes-monitoring
```

To view the grafana web app
```
kubectl port-forward deployment/prometheus-grafana 3000 -n kubernetes-monitoring
```
Enter the following into the grafana browser
```
username: admin
password: prom-operator
```

To view the prometheus web
```
kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n kubernetes-monitoring 9090
```
## assumptions
1. Website code, being lack of logic to connect to the database, will not actually communicate with the mysql database

2. Aassuming it has the capability to connect to database, it includes environment variables to initiate connection with the mysql database
```
        env:
        - name: NAME
          value: "KHUN"
        - name: MYSQL_DB_HOST
          value: "mysql"           
        - name: MYSQL_DB_PORT
          value: "3306"            
        - name: MYSQL_DB_NAME
          value: "master-db"            
        - name: MYSQL_DB_USER
          value: "admin"             
        - name: MYSQL_DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secrets
              key: password
```
It will not communicate with the mysql database but able to if the code includes logic

3. This particular deployment is for single-instance MySQL deployment. It means that the deployment cannot be scaled - it works on exactly one Pod

4. This deployment does not support rolling updates. Therefore, the spec.strategy.type must always be set to Recreate

5. The setup is not recommended for production use