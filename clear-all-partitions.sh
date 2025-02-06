#!/usr/bin/env bash
set -xe

fastboot delete-logical-partition odm
fastboot delete-logical-partition system
fastboot delete-logical-partition system_ext
fastboot delete-logical-partition product
fastboot delete-logical-partition vendor

fastboot delete-logical-partition odm_a
fastboot delete-logical-partition odm_b
fastboot delete-logical-partition system_a
fastboot delete-logical-partition system_b
fastboot delete-logical-partition system_ext_a
fastboot delete-logical-partition system_ext_b
fastboot delete-logical-partition product_a
fastboot delete-logical-partition product_b
fastboot delete-logical-partition vendor_a
fastboot delete-logical-partition vendor_b


fastboot delete-logical-partition system_a-cow
fastboot delete-logical-partition system_b-cow


