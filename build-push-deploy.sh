#!/bin/bash

set -e

docker build --platform linux/amd64 -t sit-stac-fastapi . -f docker/Dockerfile

docker tag sit-stac-fastapi 998343784597.dkr.ecr.us-east-1.amazonaws.com/sit-stac-fastapi:latest

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 998343784597.dkr.ecr.us-east-1.amazonaws.com 

docker push 998343784597.dkr.ecr.us-east-1.amazonaws.com/sit-stac-fastapi:latest

aws ecs update-service --force-new-deployment --cluster sit-vpc-ECSCluster-OSV5bONITro4 --service sit-stacapi