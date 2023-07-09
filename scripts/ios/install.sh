#!/bin/bash

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${IOS_CACHE_DIR}
INSTALL_VERSIONS=(${IOS_TEMPLATES[@]})
CHOOSED_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_IOS_TEMPLATE})

GODOT_SOURCE_URL="https://github.com/godotengine/godot/releases/download"

# Create .cache folder if not existed
if [ ! -d "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
fi

# Check if template version is support or not
if [[ " ${INSTALL_VERSIONS[*]} " =~ " ${CHOOSED_VERSION} " ]]; then
    INSTALL_VERSIONS=(${CHOOSED_VERSION})
else
    echo "- Your template version is not supported yet :'("
    exit 1
fi

# Install godot sources, will bypass cached sources
for version in "${INSTALL_VERSIONS[@]}"; do
    SOURCE_FILE=$(get_ios_template_file_name $version)

    # Check if version is cached
    if test -f "${CACHE_DIR}/${SOURCE_FILE}"; then
        echo "- Downloaded godot source version ${version} (cached)"
    else
        echo "- Downloading godot source version ${version}..."
        echo "${GODOT_SOURCE_URL}/${version}-stable/${SOURCE_FILE}"
        wget -P "${CACHE_DIR}" "${GODOT_SOURCE_URL}/${version}-stable/${SOURCE_FILE}"
    fi
done