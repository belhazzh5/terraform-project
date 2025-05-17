#!/bin/bash

# Set root directory
PROJECT_DIR="my-nextjs-app"

# Create root project directories
mkdir -p $PROJECT_DIR/{pages,lib,terraform}

# Create base files
touch $PROJECT_DIR/{Dockerfile,docker-compose.yml,.dockerignore,.env.local,README.md,package.json}

# Create Terraform files
touch $PROJECT_DIR/terraform/{main.tf,variables.tf,outputs.tf}

# Create optional backend config
touch $PROJECT_DIR/terraform/backend.tf

echo "✅ Project structure created under $PROJECT_DIR"

