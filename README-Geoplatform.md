# STAC FastAPI for Geoplatform
[https://sit-stacapi.geoplatform.info/](https://sit-stacapi.geoplatform.info/)

The deployed version of STAC FastAPI uses the `pgstac` backend. 

This image is built to support the [stacapi](https://github.com/GeoPlatform/GeoPlatform/tree/develop/infrastructure/stac-api) stack. 

## Local Development
1. review the `docker-compose.gp.yml` and rename `sample.env` to `.env`

    > This compose file also contains the service for [importing stac](https://github.com/GeoPlatform/GeoPlatform/tree/develop/infrastructure/stac-import) collections and items. Optionally uncomment this service. 

2. Start application with:
    ```sh
    docker-compose -f docker-compose.gp.yml up -d
    ```
3. Stop application with:
    ```sh
    docker-compose -f docker-compose.gp.yml down
    ```

## ECR/ECS Deployment

Use docker to build the stac-api container and push to SIT

1. create ECR repository (one time only)
    ```sh
    aws ecr create-repository --repository-name sit-stac-fastapi
    ```
2. Run 
    ```sh
    sh build-push-deploy.sh
    ```
   This will also restart the ECS task as a last step which will deploy the new image. 

## Bulk Loading Data
A sample ndjson collection and items are in the /data directory. To bulk load these, run:

```sh
docker-compose -f docker-compose.gp.yml exec stac sh /data/bulk_load_all.sh
```