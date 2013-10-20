#!/bin/bash -e
./scripts/system/musl.sh
./scripts/system/binutils.sh
./scripts/system/gcc.sh
./scripts/system/make.sh
./scripts/system/busybox.sh
./scripts/system/linux.sh
./scripts/system/setup.sh

