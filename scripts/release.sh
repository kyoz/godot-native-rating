#!/usr/bin/env bash

AAR_OUTPUT_PATH="android/app/build/outputs/aar"

# Android

echo ">> Cleaning..."
rm -rf $AAR_OUTPUT_PATH/*

echo ">> Building lib..."
cd android
./gradlew assembleRelease
cd ..

echo ">> Release to zip file..."
mv -f $AAR_OUTPUT_PATH/app-release.aar $AAR_OUTPUT_PATH/rating-release.aar

if [ -d "release" ]
then
    rm -rf release/*
else
    mkdir release
fi

zip -j release/godot-native-rating.zip $AAR_OUTPUT_PATH/rating-release.aar android/Rating.gdap