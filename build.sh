#!/bin/bash

x="${PWD}"
y=$(dirname "$0")
cd "${y}"
PRJDIR="${PWD}"

Moscow/build.sh || exit $?
PBXBuilder/build.sh || exit $?

exit 0
