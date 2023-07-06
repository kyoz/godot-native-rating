#!/bin/bash

AAR_OUTPUT_PATH=android/app/build/outputs/aar
PLUGIN_PATH=example/android/plugins

# Android

echo ">> Cleaning..."
rm -rf $AAR_OUTPUT_PATH/*

echo ">> Building lib..."
cd android
./gradlew assembleRelease
cd ..

if [ -d $PLUGIN_PATH ]
then
    echo ">> Copy plugin to example"
    cp $AAR_OUTPUT_PATH/app-release.aar $PLUGIN_PATH/rating-release.aar
    cp android/Rating.gdap $PLUGIN_PATH/
fi