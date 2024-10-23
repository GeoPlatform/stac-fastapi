#!/bin/bash

set -e

# collections first 
echo "loading national map sample collections..."

pypgstac load collections https://geoplatform-cdn-temp.s3.amazonaws.com/stac-import/national-map/collections.ndjson
pypgstac load items https://geoplatform-cdn-temp.s3.amazonaws.com/stac-import/national-map/items/struct_features.ndjson
pypgstac load items https://geoplatform-cdn-temp.s3.amazonaws.com/stac-import/national-map/items/topo_map_vector_features.ndjson
pypgstac load items https://geoplatform-cdn-temp.s3.amazonaws.com/stac-import/national-map/items/tran_features.ndjson
