#!/bin/bash

PLUGIN="rating"
EXAMPLE_PLUGIN_PATH="example/ios/plugins"

# Compile Plugin
./scripts/ios/generate_static_library.sh $PLUGIN release $1
./scripts/ios/generate_static_library.sh $PLUGIN release_debug $1
mv ./ios/bin/${PLUGIN}.release_debug.a ./ios/bin/${PLUGIN}.debug.a

# Move to release folder
rm -rf ./ios/bin/release
mkdir ./ios/bin/release
rm -rf ./ios/bin/release/${PLUGIN}
mkdir -p ./ios/bin/release/${PLUGIN}

# Move Plugin
mv ./ios/bin/${PLUGIN}.{release,debug}.a ./ios/bin/release/${PLUGIN}
cp ./ios/plugin/${PLUGIN}.gdip ./ios/bin/release/${PLUGIN}

# Copy to example if possible
if [ -d $EXAMPLE_PLUGIN_PATH ]
then
    echo ">> Copy plugin to example"
    rm -rf ${EXAMPLE_PLUGIN_PATH}/${PLUGIN}
    cp -r ./ios/bin/release/${PLUGIN} ${EXAMPLE_PLUGIN_PATH}/${PLUGIN}
fi