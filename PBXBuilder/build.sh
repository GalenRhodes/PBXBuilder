#!/bin/bash

x="${PWD}"
y=$(dirname "$0")
cd "${y}"
PRJDIR="${PWD}"
cd "${x}"

OBJCOPTS="$(gnustep-config --objc-flags) -fobjc-arc"
LINKOPTS=$(gnustep-config --base-libs)
HEADERS="$(find "${PRJDIR}" -name "*.h")"
HEADERS_DIR="${PRJDIR}/tmp1"

rm -fr "${HEADERS_DIR}"
mkdir -p "${HEADERS_DIR}"

for y in ${HEADERS}; do
  echo "Found header> ${y}"
  cp "${y}" "${HEADERS_DIR}/"
done

/opt/objc/llvm/bin/clang -c ${OBJCOPTS} -I${HEADERS_DIR} `find "${PRJDIR}" -name "*.m"`

/opt/objc/llvm/bin/clang -o test ${LINKOPTS} -ldispatch `find "${PRJDIR}" -name "*.o"`

find "${PRJDIR}" -name "*.[od]" -delete
