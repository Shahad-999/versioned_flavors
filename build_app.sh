#!/bin/bash

YELLOW_BOLD='\033[1;33m'
PINK_BOLD='\033[1;35m'
GREEN_BOLD='\033[1;32m'
BLUE_BOLD='\033[1;34m'
NC='\033[0m'
RED_BOLD='\033[1;31m'


echo -e "${PINK_BOLD}Building Application${NC}"

# PROJECT_ROOT=$(git rev-parse --show-toplevel)
PROJECT_ROOT="."

# Step 1: Environment selection
echo -e ""
echo -e "${Yellow}Step 1: Select environment:${NC}"
select env in $(yq e '.flavors | keys | .[]' "$PROJECT_ROOT/flavorizr.yaml"); do
    if [[ -n "$env" ]]; then
        echo -e ""
        echo -e "✅ Selected environment: ${GREEN_BOLD}$env${NC}"
        break
    else
        echo -e "${RED_BOLD}Invalid selection. Please try again.${NC}"
    fi
done


echo -e ""
echo -e "${YELLOW_BOLD} Updating versions and building...${NC}"

# Step 3: Update versions
echo -e "${YELLOW_BOLD}Step 3: Updating versions${NC}"

"$PROJECT_ROOT/update_versions.sh" "$env"


# Read the updated version
build_name=$(yq e ".${env}.build_name" "$PROJECT_ROOT/versions.yaml")
build_number=$(yq e ".${env}.build_number" "$PROJECT_ROOT/versions.yaml")

echo -e "${PINK_BOLD}Building version: $build_name+$build_number${NC}"



# Step 4+: Build APK
echo -e "${YELLOW_BOLD} Building APK (Android)${NC}"

fvm flutter build apk --release --flavor $env \
--build-name $build_name \
--build-number $build_number

 
apk_path="$PROJECT_ROOT/build/app/outputs/flutter-apk/app-$env-release.apk"
  
echo -e "${GREEN_BOLD}✅ APK saved to: $apk_path${NC}"
   

# Build App Bundle
echo -e "${YELLOW_BOLD} Building App Bundle (Android)${NC}"

fvm flutter build appbundle --release --flavor $env \
--build-name $build_name \
--build-number $build_number
    
appbundle_path="$PROJECT_ROOT/build/app/outputs/bundle/${env}Release/app-$env-release.aab"
echo -e "${GREEN_BOLD}✅ App Bundle saved to: $appbundle_path${NC}"


# Build IPA
# echo -e "${YELLOW_BOLD} Building IPA (iOS)${NC}"

# fvm flutter build ipa --release --flavor $env \
# --build-name $build_name \
# --build-number $build_number

# ipa_path="$PROJECT_ROOT/build/ios/ipa/"
# echo -e "${GREEN_BOLD}✅ IPA build completed${NC}"




# Summary
echo -e "${PINK_BOLD}✅ Build Complete!${NC}"
echo -e ""
echo -e "${YELLOW_BOLD}Outputs:${NC}"
echo -e "${BLUE_BOLD}APK: $apk_path${NC}"
echo -e "${BLUE_BOLD}App Bundle: $appbundle_path${NC}"
# echo -e "${BLUE_BOLD}IPA: $ipa_path${NC}"
echo -e "${BLUE_BOLD}==========================================${NC}"
