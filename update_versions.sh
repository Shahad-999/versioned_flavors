#!/bin/bash

# Script to update version numbers in versions.yaml
# Usage: ./update_versions.sh <environment>
# Example: ./update_versions.sh staging

env=$1

PROJECT_ROOT=$(git rev-parse --show-toplevel)
VERSIONS_FILE="$PROJECT_ROOT/versions.yaml"


# Read the current version and build number
old_build_name=$(yq e ".${env}.build_name" "$VERSIONS_FILE")
old_build_number=$(yq e ".${env}.build_number" "$VERSIONS_FILE")

echo "Current version: $old_build_name+$old_build_number"

# Update versions based on environment
if [ "$env" == "staging" ] || [ "$env" == "development" ]; then
    # For staging/development: increment build number for both dev and staging
    new_build_number=$((old_build_number + 1))
    
    yq e -i ".${env}.build_number = $new_build_number" "$VERSIONS_FILE"

    echo "✅ Updated development and staging build numbers to: $new_build_number"

elif [ "$env" == "production" ]; then
    # For production: increment both build number and patch version
    new_build_number=$((old_build_number + 1))
    
    # Increment patch version (e.g., 0.6.11 -> 0.6.12)
    IFS='.' read -r major minor patch <<< "$old_build_name"
    new_patch=$((patch + 1))
    new_version="$major.$minor.$new_patch"
    
    # Update production
    yq e -i ".production.build_number = $new_build_number" "$VERSIONS_FILE"
    yq e -i ".production.build_name = \"$new_version\"" "$VERSIONS_FILE"
    
    echo "✅ Updated production to: $new_version+$new_build_number"
    
    # Update staging and development to match new production version (this is personal preference, you can remove this if you want)
    yq e -i ".development.build_number = $new_build_number" "$VERSIONS_FILE"
    yq e -i ".development.build_name = \"$new_version\"" "$VERSIONS_FILE"

    yq e -i ".staging.build_number = $new_build_number" "$VERSIONS_FILE"
    yq e -i ".staging.build_name = \"$new_version\"" "$VERSIONS_FILE"
    
    echo "✅ Updated development and staging to match production: $new_version+$new_build_number"
fi

# Clean up temporary file if it exists
if [ -f tmp.yaml ]; then
    rm tmp.yaml
fi

echo "✅ versions.yaml updated successfully"

