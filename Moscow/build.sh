#!/usr/bin/env bash

a=$(dirname "$0")
b="${PWD}"
cd "$a"
SUBPRJPATH="${PWD}"
cd "$b"

SUBPRJNAME=$(basename "${SUBPRJPATH}")
SUBPRJBUILDPATH="${SUBPRJPATH}/build"
SUBPRJHEADERSPATH="${SUBPRJBUILDPATH}/include"
SUBPRJOBJPATH="${SUBPRJBUILDPATH}/objs"

CC=$(gnustep-config --variable=CC)

y=""
for x in $(gnustep-config --objc-flags); do
    if [ "$x" != "-w" -a "${x:0:2}" != "-O" -a "${x:0:2}" != "-g" ]; then
        y="${y} ${x}"
    fi
done

OPTS="${y:1} -fobjc-arc -fobjc-nonfragile-abi -I${SUBPRJHEADERSPATH} -Ofast -g0"
LOPTS="$(gnustep-config --base-libs) -ldispatch"

mkdir -p "${SUBPRJBUILDPATH}" || exit $?
mkdir -p "${SUBPRJHEADERSPATH}" || exit $?
mkdir -p "${SUBPRJHEADERSPATH}/${SUBPRJNAME}" || exit $?
mkdir -p "${SUBPRJOBJPATH}" || exit $?

for x in $(find "${SUBPRJPATH}" -name "*.h"); do
    y="$(basename "${x}")"
    z="${SUBPRJHEADERSPATH}/${SUBPRJNAME}/${y}"
    echo "cp ${x} ==> ${z}"
    cp "${x}" "${z}" || exit $?
done

for x in $(find "${SUBPRJPATH}" -name "*.m"); do
    y=$(basename "${x}")
    z="${SUBPRJOBJPATH}/${y}.o"
    echo "${y} ==> ${z}"
    "${CC}" ${OPTS} -c "${x}" -o "${z}" || exit $?
done

for x in $(find "${SUBPRJPATH}" -name "${SUBPRJNAME}_GNUstep_vers.[cm]"); do
    y=$(basename "${x}")
    z="${SUBPRJOBJPATH}/${y}.o"
    echo "${y} ==> ${z}"
    "${CC}" -c "${x}" -o "${z}" || exit $?
done

exit $?
