#!/usr/bin/env bash
set -xe

# this command will either exit 0 or 1
adb shell getprop ro.boot.ddr_type

# running adb reboot fastboot here 
# will exit 0 so the script can't be automated

# oneplus 7t has LPDDR4x RAM
#
# if LPDDR4x
# return 0
#  fastboot flash --slot=all xbl_config xbl_config.img
#  fastboot flash --slot=all xbl xbl.img
#elif $? -eq 1; then
# if LPDDR5
# return 1
#  fastboot flash --slot=all xbl_config xbl_config_lp5.img
#  fastboot flash --slot=all xbl xbl_lp5.img
#fi

