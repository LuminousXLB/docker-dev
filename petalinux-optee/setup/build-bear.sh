#!/bin/bash

set -ex

wget https://api.github.com/repos/rizsotto/Bear/tarball -O rizsotto-Bear.tar.gz
tar -xf rizsotto-Bear.tar.gz
cd rizsotto-Bear-*

cmake -B build -DENABLE_UNIT_TESTS=OFF -DENABLE_FUNC_TESTS=OFF

NPROC=$(($(nproc) - 2))
if [ $NPROC -gt 0 ]; then
    export CMAKE_BUILD_PARALLEL_LEVEL=$NPROC
fi

cmake --build build
cmake --install build
