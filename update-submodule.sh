#!/bin/bash

# Shell script to set all submodules to the main branch
submodulePath="."

echo "Setting all submodules to the main branch at path: $submodulePath"
cd $submodulePath

# Get all submodule paths
submodules=$(git submodule foreach --quiet 'echo $sm_path')

for submodule in $submodules; do
    echo "Updating submodule at path: $submodule"
    cd $submodule
    git checkout main
    git pull origin main
    cd ..
done

echo "All submodules have been set to the main branch."
