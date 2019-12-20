#!/bin/bash

x="${PWD}"
y=$(dirname "$0")
cd "${y}"
PRJDIR="${PWD}"
EXENAME="pbxbuild"

SUBPROJECTS="Moscow PBX PBXBuilder"
PRIORPDIRS=""
LINK_FILES=""

rm -f "${PRJDIR}/${EXENAME}"

for prj in ${SUBPROJECTS}; do
    q="${PRJDIR}/${prj}"
    "${q}/build.sh" ${PRIORPDIRS} || exit $?
    PRIORPDIRS="${PRIORPDIRS} ${q}"
    LINK_FILES="${LINK_FILES} $(find "${q}/build/objs" -name "*.o")"
done

CC=$(gnustep-config --variable=CC)
echo "Linking ${EXENAME}"
"${CC}" $(gnustep-config --base-libs) -ldispatch ${LINK_FILES} -o "${PRJDIR}/${EXENAME}"

exit $?
