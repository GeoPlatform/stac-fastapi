#!/bin/bash

# Read the collections
read -r FIRSTLINE < "$1"
pypgstac load collections "$FIRSTLINE"

# Read the items
while IFS= read -r line; do
    pypgstac load items "$line"
done < <(sed 1,1d "$1")
