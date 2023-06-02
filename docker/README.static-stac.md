# STAC data

To ingest a stac catalog into the container during the build process, use the `--build-arg IMPORT_FILE=<filename>` argument
to specify an import file.

The file has a very simple format.  The first line must point at a STAC collection ndjson file and the remaining lines
point at additional item ndjson files.

# Example

First build the image using the national map import files (requires NSJSON files to be present in S3)

```
docker build -t static-stac --no-cache --build-arg IMPORT_FILE=./import/national-map-s3-import.txt -f Dockerfile.static-stac . 
```

Next, run the container as a daemon and expose the STAC API port

```
docker run --env-file ./gp/gp.env -d -p 8082:8082 static-stac
```

Finally, view the contents using a stac browser like [radient earth](https://radiantearth.github.io/stac-browser/#/external/http:/localhost:8082/?.language=en)