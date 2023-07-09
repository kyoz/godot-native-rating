#!/bin/bash
set -e

source ./build.env
source ./scripts/utils.sh

PLUGIN=${PLUGIN_NAME}
CACHE_DIR=${IOS_CACHE_DIR}
BUILD_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_IOS_TEMPLATE})
EXAMPLE_PLUGIN_PATH="example/ios/plugins"

echo ">> Install iOS template..."
./scripts/ios/install.sh $BUILD_VERSION

echo ">> Cleaning and preparing folders..."
rm -rf ios/bin
mkdir -p ios/bin
rm -rf ios/godot
mkdir -p ios/godot

echo ">> Preparing extracted header template..."
HEADER_FILE=$(get_ios_template_file_name $BUILD_VERSION)
tar -xf ${CACHE_DIR}/${HEADER_FILE} -C ./ios/

echo ">> Building..."
MAJOR_VERSION=$(get_ios_major_version $BUILD_VERSION)

# Compile Plugin
./scripts/ios/generate_static_library.sh $PLUGIN release $MAJOR_VERSION
./scripts/ios/generate_static_library.sh $PLUGIN release_debug $MAJOR_VERSION
mv ./ios/bin/${PLUGIN}.release_debug.a ./ios/bin/${PLUGIN}.debug.a

# Move to release folder
rm -rf ./ios/bin/release
mkdir ./ios/bin/release
rm -rf ./ios/bin/release/${PLUGIN}
mkdir -p ./ios/bin/release/${PLUGIN}

# Move Plugin
mv ./ios/bin/${PLUGIN}.{release,debug}.a ./ios/bin/release/${PLUGIN}
cp ./ios/plugin/${PLUGIN}.gdip ./ios/bin/release/${PLUGIN}

# Copy to example if possible (for faster development)
if [ -d $EXAMPLE_PLUGIN_PATH ]
then
    echo ">> Copy plugin to example"
    rm -rf ${EXAMPLE_PLUGIN_PATH}/${PLUGIN}
    cp -r ./ios/bin/release/${PLUGIN} ${EXAMPLE_PLUGIN_PATH}/${PLUGIN}
fi