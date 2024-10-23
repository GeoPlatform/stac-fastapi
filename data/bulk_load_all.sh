#!/bin/bash

set -e

# collections first 
echo "loading national map sample collections..."
pypgstac load collections /data/national-map/collections.ndjson

# items
for filename in /data/national-map/items/*.ndjson; do
    [ -e "$filename" ] || continue
    echo "loading $filename..."
    pypgstac load items $filename
done