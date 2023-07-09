#!/bin/bash

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${ANDROID_CACHE_DIR}
INSTALL_VERSIONS=(${ANDROID_TEMPLATES[@]})
CHOOSED_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_ANDROID_TEMPLATE})

GODOT_AAR_URL="https://downloads.tuxfamily.org/godotengine/"

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

# Install template, will bypass cached templates
for version in "${INSTALL_VERSIONS[@]}"; do
    AAR_FILE=$(get_android_template_file_name $version)

    # Check if version is cached
    if test -f "${CACHE_DIR}/${AAR_FILE}"; then
        echo "- Downloaded android template version ${version} (cached)"
    else
        echo "- Downloading android template version ${version}..."
        wget "${GODOT_AAR_URL}/${version}/${AAR_FILE}" \
            -O "${CACHE_DIR}/${AAR_FILE}" \
            -q --show-progress
    fi
done

exit 0