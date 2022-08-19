# STAC FastAPI for Geoplatform
[https://sit-stacapi.geoplatform.info/](https://sit-stacapi.geoplatform.info/)

The deployed version of STAC FastAPI uses the `pgstac` backend. 

This image is built to support the [stacapi](https://github.com/GeoPlatform/GeoPlatform/tree/develop/infrastructure/stac-api) stack. 

## Local Development

Use docker to build the container and push to SIT

1. clone & checkout develop
    ```sh
    git clone https://github.com/GeoPlatform/stac-fastapi.git

    git checkout develop
    ```
2. build locally
    ```sh
    docker build -t sit-stac-fastapi .
    ```
3. tag container
    ```sh
    docker tag sit-stac-fastapi 998343784597.dkr.ecr.us-east-1.amazonaws.com/sit-stac-fastapi:latest
    ```
4. create ECR repository (one time only)
    ```sh
    aws ecr create-repository --repository-name sit-stac-fastapi
    ```
5. login and push container to ECR
    ```sh
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 998343784597.dkr.ecr.us-east-1.amazonaws.com 

    docker push 998343784597.dkr.ecr.us-east-1.amazonaws.com/sit-stac-fastapi:latest
    ```