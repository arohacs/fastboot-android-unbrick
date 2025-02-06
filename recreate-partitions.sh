#!/usr/bin/env bash
set -xe

fastboot create-logical-partition odm_a 100000
fastboot create-logical-partition odm_b 100000
fastboot create-logical-partition system_a 100000
fastboot create-logical-partition system_b 100000
fastboot create-logical-partition system_ext_a 100000
fastboot create-logical-partition system_ext_b 100000
fastboot create-logical-partition product_a 100000
fastboot create-logical-partition product_b 100000
fastboot create-logical-partition vendor_a 100000
fastboot create-logical-partition vendor_b 100000
