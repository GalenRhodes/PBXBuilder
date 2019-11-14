#!/bin/bash

x="${PWD}"
y=$(dirname "$0")
cd "${y}"
PRJDIR="${PWD}"
cd "${x}"

echo "Project Path: \"${PRJDIR}\""

CC="/opt/objc/llvm/bin/clang"
CXX="/opt/objc/llvm/bin/clang++"

HEADERS=$(find "${PRJDIR}" -name "*.h")
HEADERS_DIR="${PRJDIR}/tmp1"
SOURCE_FILES=$(find "${PRJDIR}" -name "*.m")

OBJCOPTS="$(gnustep-config --objc-flags) -fobjc-arc -I${HEADERS_DIR}"
LINKOPTS="$(gnustep-config --base-libs) -ldispatch"

rm -fr "${HEADERS_DIR}"
mkdir -p "${HEADERS_DIR}"

for y in ${HEADERS}; do
  cp "${y}" "${HEADERS_DIR}/"
done

################################################################################################
# COMPILE
#
"${CC}" -c ${OBJCOPTS} ${SOURCE_FILES}

################################################################################################
# LINK
#
"${CC}" -o PBXBuilder ${LINKOPTS} $(find "${PRJDIR}" -name "*.o")

################################################################################################
# CLEAN UP
#
find "${PRJDIR}" -name "*.[od]" -delete
rm -fr "${HEADERS_DIR}"

exit 0
