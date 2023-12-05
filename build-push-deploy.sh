#!/bin/bash

# AWS_ACCOUNT_ID=998343784597 for SIT
# AWS_ACCOUNT_ID=824888059401 for STG and PRD
set -e

docker build --platform linux/amd64 -t ${STAGE}-stac-fastapi . -f docker/Dockerfile

docker tag ${STAGE}-stac-fastapi ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${STAGE}-stac-fastapi:latest

# aws ecr get-login-password --profile default --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com 

docker push ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${STAGE}-stac-fastapi:latest

#aws ecs update-service --force-new-deployment --cluster sit-vpc-ECSCluster-OSV5bONITro4 --service ${STAGE}-stacapi