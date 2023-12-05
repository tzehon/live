#!/bin/bash

# Define subfolders
FOLDERS=("scheduler" "secret_manager")

# Iterate through each folder and run Terraform commands
for folder in "${FOLDERS[@]}"; do
    echo "Running Terraform in $folder"
    cd $folder
    terraform init
    terraform plan
    terraform apply -auto-approve
    cd ..
done
