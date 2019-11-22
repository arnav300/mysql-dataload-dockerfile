# mysql-dataload-dockerfile
This tutorial helps in loading data in mysql using a docker file

Follow below steps to load data into minikube

1) Pull docker image :
 - docker pull arnav30/mysql:3.0
 
2) To start container and load data in mysql in minikube use below command :

 - minikube start ( Make sure your minikube is running)
 - minikube dashboard ( To open GUI for minikube)
 - ./database_kubernetes.sh init
 
 This will load the data in your my-database container.
 
 3) To confirm login into mysql container :
  - kubectl exec -it $POD_NAME -- mysql -proot titanicNew
