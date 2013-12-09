#!/usr/bin/env bash

BASE_DIR=`dirname $0`

if [ -d source/ -a -d sass/ -a -f _config.yml ]; then
    echo "Copying source/* and sass/* files."
else
    echo "ERROR: Current directory is not Octpress environment. You need run this shell script on your own Octpress environment."
    exit 1
fi

cp -R ${BASE_DIR}/source ./
cp -R ${BASE_DIR}/sass ./

echo "Copied source/* and sass/* files."
echo "You need add 'custom/asides/posted_by.html' into 'default_asides' of _config.yml."
