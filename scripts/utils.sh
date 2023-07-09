#!/bin/bash

get_android_template_file_name() {
    VERSION=$1

    if [ "${VERSION:0:1}" != "4" ]; then
        echo "godot-lib.${VERSION}.stable.release.aar"
    else
        echo "godot-lib.${VERSION}.stable.template_release.aar"
    fi
}

get_ios_template_file_name() {
    echo "godot-$1-stable.tar.xz"
}

get_ios_major_version() {
    VERSION=$1

    if [[ $VERSION =~ ^3\..* ]]; then
        echo $VERSION | sed -E 's/^([0-9]+)\..*$/\1.x/g'
    else
        echo ${VERSION:0:3}
    fi
}