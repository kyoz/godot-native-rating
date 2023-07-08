#!/bin/bash

AAR_OUTPUT_PATH=android/app/build/outputs/aar
EXAMPLE_PLUGIN_PATH=example/android/plugins

# Android

echo ">> Cleaning..."
rm -rf $AAR_OUTPUT_PATH/*

echo ">> Building lib..."
cd android
./gradlew assembleRelease
cd ..

if [ -d $EXAMPLE_PLUGIN_PATH ]
then
    echo ">> Copy plugin to example"
    cp $AAR_OUTPUT_PATH/app-release.aar $EXAMPLE_PLUGIN_PATH/rating-release.aar
    cp android/Rating.gdap $EXAMPLE_PLUGIN_PATH/
fi