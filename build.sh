#!/bin/bash

x="${PWD}"
y=$(dirname "$0")
cd "${y}"
PRJDIR="${PWD}"

EXENAME="pbxbuild"

rm -f "${PRJDIR}/${EXENAME}"

"${PRJDIR}/Moscow/build.sh" || exit $?
"${PRJDIR}/PBXBuilder/build.sh" "${PRJDIR}/Moscow" || exit $?

CC=$(gnustep-config --variable=CC)

"${CC}" $(gnustep-config --base-libs) -ldispatch $(find "Moscow/build/objs" -name "*.o") $(find "PBXBuilder/build/objs" -name "*.o") -o "${PRJDIR}/${EXENAME}"

exit $?
