#!/bin/bash

# the default node number is 5
N=${1:-5}

docker pull kiwenlau/hadoop:1.0
docker network create --driver=bridge hadoop
# start hadoop master container
docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name hadoop-master \
                --hostname hadoop-master \
                kiwenlau/hadoop:1.0 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                kiwenlau/hadoop:1.0 &> /dev/null
	i=$(( $i + 1 ))
done

# copy needed files for runninng
docker cp hadp.jar hadoop-master:/root
docker cp config/run-wordcount.sh hadoop-master:/root

docker exec -t hadoop-master mkdir input
docker cp file.txt hadoop-master:/root/input


# run command in hadoop master container
docker exec -t hadoop-master ./start-hadoop.sh

echo "start to run bigram count"
docker exec -t hadoop-master ./run-wordcount.sh