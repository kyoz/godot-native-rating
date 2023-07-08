#!/bin/bash

# Create bin folder
if [ -d "ios/bin" ]
then
    mkdir ios/bin
fi

./scripts/ios/release_static_library.sh 3.x