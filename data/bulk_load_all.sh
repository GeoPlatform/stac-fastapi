#!/bin/bash

set -e

# collections first 
echo "loading collections..."
pypgstac load collections /data/collections.ndjson

# items
for filename in /data/items/*.ndjson; do
    [ -e "$filename" ] || continue
    echo "loading $filename..."
    pypgstac load items $filename
done
