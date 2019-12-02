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

rm -fr "${SUBPRJBUILDPATH}"

CC=$(gnustep-config --variable=CC)

y=""
for x in $(gnustep-config --objc-flags); do
    if [ "$x" != "-w" -a "${x:0:2}" != "-O" -a "${x:0:2}" != "-g" ]; then
        y="${y} ${x}"
    fi
done

OPTS="${y:1} -fobjc-arc -fobjc-nonfragile-abi -Ofast -g0 -I${SUBPRJHEADERSPATH}"
for _a in $@; do
    cd "${_a}"
    OPTS="${OPTS} -I${PWD}/build/include"
done
cd "$b"
echo "${OPTS}"
LOPTS="$(gnustep-config --base-libs) -ldispatch -L${SUBPRJPATH}/.. -lMoscow"

mkdir -p "${SUBPRJBUILDPATH}" || exit $?
mkdir -p "${SUBPRJHEADERSPATH}" || exit $?
mkdir -p "${SUBPRJOBJPATH}" || exit $?

for x in $(find "${SUBPRJPATH}" -name "*.h"); do
    y="$(basename "${x}")"
    z="${SUBPRJHEADERSPATH}/${y}"
    echo "cp ${x} ==> ${z}"
    cp "${x}" "${z}" || exit $?
done

for x in $(find "${SUBPRJPATH}" -name "*.m"); do
    y=$(basename "${x}")
    z="${SUBPRJOBJPATH}/${y}.o"
    echo "${y} ==> ${z}"
    "${CC}" ${OPTS} -c "${x}" -o "${z}" || exit $?
done

exit $?
