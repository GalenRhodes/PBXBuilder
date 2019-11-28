#!/bin/bash

x="${PWD}"
y=$(dirname "$0")
cd "${y}"
PRJDIR="${PWD}"

"${PRJDIR}/Moscow/build.sh" || exit $?
"${PRJDIR}/PBXBuilder/build.sh" "${PRJDIR}/Moscow" || exit $?

CC=$(gnustep-config --variable=CC)

"${CC}" $(gnustep-config --base-libs) -ldispatch $(find "Moscow/build/objs" -name "*.o") $(find "PBXBuilder/build/objs" -name "*.o") -o "pbxbuild"

exit 0
