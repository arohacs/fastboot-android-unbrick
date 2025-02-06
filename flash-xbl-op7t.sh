#!/usr/bin/env bash
set -xe
images=$1
# flash op7t xbl
fastboot flash --slot=all xbl_config ${images}/xbl_config.img
fastboot flash --slot=all xbl ${images}/xbl.img
