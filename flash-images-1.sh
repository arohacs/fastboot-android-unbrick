#!/usr/bin/env bash

set -xe
images=$1
if [ -z "$images" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

fastboot flash recovery recovery.img
fastboot flash boot boot.img
fastboot flash dtbo dtbo.img
fastboot reboot fastboot
fastboot flash --slot=all recovery ${images}/recovery.img
fastboot flash --slot=all boot ${images}/boot.img
fastboot flash --slot=all dtbo ${images}/dtbo.img
fastboot flash --slot=all abl ${images}/abl.img
fastboot flash --slot=all aop ${images}/aop.img
fastboot flash --slot=all bluetooth ${images}/bluetooth.img
fastboot flash --slot=all cmnlib64 ${images}/cmnlib64.img
fastboot flash --slot=all cmnlib ${images}/cmnlib.img
fastboot flash --slot=all devcfg ${images}/devcfg.img
fastboot flash --slot=all dsp ${images}/dsp.img
fastboot flash --slot=all featenabler ${images}/featenabler.img
fastboot flash --slot=all hyp ${images}/hyp.img
fastboot flash --slot=all imagefv ${images}/imagefv.img
fastboot flash --slot=all keymaster ${images}/keymaster.img

# if you have a logo.img, comment this back in
#fastboot flash --slot=all logo logo.img

# depending on what your oem stanvbk is named, adjust accordingly
#fastboot flash --slot=all mdm_oem_stanvbk mdm_oem_stanvbk.img

fastboot flash --slot=all oem_stanvbk ${images}/oem_stanvbk.img
fastboot flash --slot=all modem ${images}/modem.img
fastboot flash --slot=all multiimgoem ${images}/multiimgoem.img
fastboot flash --slot=all qupfw  ${images}/qupfw.img
fastboot flash --slot=all spunvm ${images}/spunvm.img
fastboot flash --slot=all storsec ${images}/storsec.img
fastboot flash --slot=all xbl_config ${images}/xbl_config.img
fastboot flash --slot=all xbl ${images}/xbl.img
