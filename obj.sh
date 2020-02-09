#!/bin/sh

set -e

cd /mnt

ibmcloud login --apikey "$IBMC_API_KEY" -r us-south

case "$1" in
  put)
    ibmcloud cos put-object \
      --bucket baldinho-cos-standard-ozm \
      --key "$TRAVIS_BUILD_ID/$2" \
      --body "$2"
    ;;

  get)
    ibmcloud cos get-object \
      --bucket baldinho-cos-standard-ozm \
      --key "$TRAVIS_BUILD_ID/$2" \
      "$2"
    ;;
esac
