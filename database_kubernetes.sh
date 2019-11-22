#!/bin/bash

CMD=$1

IMAGE_TAG=3.0

IMAGE_NAME="docker.io/arnav30/mysql"

CONTAINER_NAME="my-database"
#kubectl get pods | grep -i my* | awk '{print $1}' | grep -i my-da*"
echo $CONTAINER_NAME

DATABASE_NAME="titanicNew"

MYSQL_ROOT_PASSWORD="root"

DATABASE_PORT="3306"

case $CMD in
    init)
        CMD="kubectl run"
        CMD="$CMD  $CONTAINER_NAME"
        CMD="$CMD --env=MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD"
        CMD="$CMD --image=$IMAGE_NAME:$IMAGE_TAG"
        echo "$CMD"
	eval $CMD;

	sleep 20

export POD_NAME=`kubectl get pods | grep -i my* | awk '{print $1}' | grep -i my-da*`
echo $POD_NAME
        echo "Waiting for mysql start"
       # while ! kubectl exec -it  $POD_NAME mysqladmin -p$MYSQL_ROOT_PASSWORD ping &>/dev/null ; do sleep 1 ; done

        #sleep 10

        echo "Loading database data"
kubectl exec -it $POD_NAME -c $CONTAINER_NAME -- mysql -p$MYSQL_ROOT_PASSWORD $DATABASE_NAME -e "LOAD DATA LOCAL INFILE 'var/lib/mysql-files/titanic.csv' INTO TABLE titanic FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (survived,passengerClass,name,sex,age,siblingsOrSpousesAboard,parentsOrChildrenAboard,fare, @uuid) SET uuid=UUID()";
        ;;
    stop)
        kubectl stop $CONTAINER_NAME
        ;;
    remove)
        kubectl rm -f $CONTAINER_NAME
        ;;
    rmi)
        kubectl rmi -f $CONTAINER_NAME
        ;;
    *)
        echo "Usage : build | start <image_tag> | stop | remove | rmi"
        ;;
esac

exit 0


