#!/bin/bash
set -e

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${IOS_CACHE_DIR}
BUILD_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_IOS_TEMPLATE})
EXAMPLE_PLUGIN_PATH="example/ios/plugins/${PLUGIN_NAME}"

echo ">> Install iOS template..."
./scripts/ios/install.sh $BUILD_VERSION

echo ">> Cleaning and preparing folders..."
rm -rf ios/bin
mkdir -p ios/bin
rm -rf ios/godot
mkdir -p ios/godot

echo ">> Preparing build template..."
SOURCE_FILE=$(get_ios_template_file_name $BUILD_VERSION)
tar -xf ${CACHE_DIR}/${SOURCE_FILE} --strip-components=1 -C ./ios/godot

echo ">> Generate headers..."
MAJOR_VERSION=$(get_ios_major_version $BUILD_VERSION)
./scripts/ios/generate_headers.sh ${MAJOR_VERSION} || true

echo ">> Building..."
./scripts/ios/release_static_library.sh ${MAJOR_VERSION}