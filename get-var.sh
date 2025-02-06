#!/usr/bin/env bash
set -xe

fastboot getvar all > $PWD/vars.txt

