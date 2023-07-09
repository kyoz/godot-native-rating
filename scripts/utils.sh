#!/bin/bash

get_android_template_file_name() {
    VERSION=$1

    if [ "${VERSION:0:1}" != "4" ]; then
        echo "godot-lib.${VERSION}.stable.release.aar"
    else
        echo "godot-lib.${VERSION}.stable.template_release.aar"
    fi
}
