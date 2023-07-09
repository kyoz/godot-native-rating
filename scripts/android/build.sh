#!/bin/bash
set -e

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${ANDROID_CACHE_DIR}
BUILD_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_ANDROID_TEMPLATE})
AAR_OUTPUT_PATH=android/app/build/outputs/aar
EXAMPLE_PLUGIN_PATH=example/android/plugins

echo ">> Cleaning..."
rm -rf $AAR_OUTPUT_PATH/*

echo ">> Install Android template..."
./scripts/android/install.sh $BUILD_VERSION

echo ">> Preparing build template..."
# Remove other templates
find "android/app/libs" -name "*.aar" -type f -delete
# Copy matching godot aar template
AAR_FILE=$(get_android_template_file_name $BUILD_VERSION)
cp ${CACHE_DIR}/${AAR_FILE} android/app/libs/${AAR_FILE}

echo ">> Building lib..."
cd android
./gradlew assembleRelease
cd ..

# Copy to example if possible (for faster development)
if [ -d $EXAMPLE_PLUGIN_PATH ]
then
    echo ">> Copy plugin to example"

    cp $AAR_OUTPUT_PATH/app-release.aar $EXAMPLE_PLUGIN_PATH/${PLUGIN_NAME}-release.aar
    cp android/${GDAP_FILE} $EXAMPLE_PLUGIN_PATH/
fi