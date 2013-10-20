#!/bin/bash -e
./scripts/compiler/binutils.sh
./scripts/compiler/gcc.sh
./scripts/compiler/linux-headers.sh
./scripts/compiler/musl.sh

