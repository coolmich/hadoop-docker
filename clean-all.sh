#!/usr/bin/env bash

docker rm $(docker stop $(docker ps -a -q --filter="name=hadoop-master"))
docker rm $(docker stop $(docker ps -a -q --filter="name=hadoop-slave"))
