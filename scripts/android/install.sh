#!/bin/bash

source ./build.env

CACHE_DIR=".cache/android-templates"
INSTALL_VERSIONS=(${ANDROID_TEMPLATES[@]})
CHOOSED_VERSION=$1

GODOT_AAR_URL="https://downloads.tuxfamily.org/godotengine/"

# Create .cache folder if not existed
if [ ! -d "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
fi

# If there is a version provided, check if it is support or not
if [ ! -z "$CHOOSED_VERSION" ]; then
    # If is has support, set it as the template to install
    if [[ " ${INSTALL_VERSIONS[*]} " =~ " ${CHOOSED_VERSION} " ]]; then
        INSTALL_VERSIONS=(${CHOOSED_VERSION})
    else
        echo "Your template version is not supported yet :'("
        exit
    fi
fi

# Install template, will bypass cached templates
for version in "${INSTALL_VERSIONS[@]}"; do
    # Check if version is cached
    if test -f "${CACHE_DIR}/${version}.zip"; then
        echo "Downloaded android template version ${version} (cached)"
    else
        echo "Downloading android template version ${version}..."
        wget "${GODOT_AAR_URL}/${version}/godot-lib.${version}.stable.release.aar" \
            -O "${CACHE_DIR}/${version}.zip" \
            -q --show-progress
    fi
done