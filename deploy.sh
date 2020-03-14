#!/bin/bash
set -e

yarn run clean
yarn run build
readonly old_links=(gpg salary payment)
for old_link in "${old_links[@]}"
do
  touch public/${old_link}.html
done
aws s3 sync --delete public/ s3://wanko-cc/
for old_link in "${old_links[@]}"
do
  aws s3api put-object --bucket wanko-cc --key "${old_link}.html" --website-redirect-location "/${old_link}"
done
