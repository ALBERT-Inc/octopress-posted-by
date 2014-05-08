#!/usr/bin/env bash

BASE_DIR=`dirname $0`

if [ -d source/ -a -d sass/ -a -f _config.yml ]; then
    echo "Copying files."
else
    echo "ERROR: Current directory is not Octpress environment. You need run this shell script on your own Octpress environment."
    exit 1
fi

cp -R ${BASE_DIR}/source ./
cp -R ${BASE_DIR}/sass ./
cp -R ${BASE_DIR}/plugins ./

echo "Copied files successfully."
cat <<EOF

You need to edit _config.yml
  - add 'custom/asides/posted_by.html' into 'default_asides'.
  - add Google+ API enabled API key into 'posted_by.google_api_key'.

EOF
