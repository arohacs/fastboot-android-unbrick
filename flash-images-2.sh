#!/usr/bin/env bash
set -xe
images=$1
if [ -z "$images" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi
   
fastboot flash odm ${images}/odm.img
fastboot flash system ${images}/system.img
fastboot flash system_ext ${images}/system_ext.img
fastboot flash product ${images}/product.img
fastboot flash vendor ${images}/vendor.img
fastboot flash --slot=all ${images}/vbmeta vbmeta.img
fastboot flash --slot=all ${images}/vbmeta_system vbmeta_system.img

echo if there have not been any errors,
echo now return to recovery, do a factory reset and reboot
