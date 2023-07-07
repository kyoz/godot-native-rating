#!/bin/bash

PLUGIN="rating"

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
