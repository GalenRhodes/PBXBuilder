#!/usr/bin/env bash

a=$(dirname "$0")
b="${PWD}"
cd "$a"
SUBPRJPATH="${PWD}"
cd "$b"

#CODE_OPTS="-Ofast -g0 -Wno-unknown-pragmas"
CODE_OPTS="-Ofast -g0 -Wno-unknown-pragmas -DDEBUG=1"

SUBPRJNAME=$(basename "${SUBPRJPATH}")
SUBPRJBUILDPATH="${SUBPRJPATH}/build"
SUBPRJHEADERSPATH="${SUBPRJBUILDPATH}/include"
SUBPRJFWKHEADERSPATH="${SUBPRJHEADERSPATH}/${SUBPRJNAME}"
SUBPRJOBJPATH="${SUBPRJBUILDPATH}/objs"

rm -fr "${SUBPRJBUILDPATH}"

CC=$(gnustep-config --variable=CC)

y=""
for x in $(gnustep-config --objc-flags); do
    if [ "$x" != "-w" -a "${x:0:2}" != "-O" -a "${x:0:2}" != "-g" ]; then
        y="${y} ${x}"
    fi
done

OPTS="${y:1} -fobjc-arc -fobjc-nonfragile-abi -I${SUBPRJHEADERSPATH} -I${SUBPRJFWKHEADERSPATH} ${CODE_OPTS}"
for _a in $@; do
    cd "${_a}"
    OPTS="${OPTS} -I${PWD}/build/include"
    cd "$b"
done

mkdir -p "${SUBPRJBUILDPATH}" || exit $?
mkdir -p "${SUBPRJHEADERSPATH}" || exit $?
mkdir -p "${SUBPRJFWKHEADERSPATH}" || exit $?
mkdir -p "${SUBPRJOBJPATH}" || exit $?

for x in $(find "${SUBPRJPATH}" -name "*.h"); do
    y="$(basename "${x}")"
    z="${SUBPRJFWKHEADERSPATH}/${y}"
    ln -s "${x}" "${z}" || exit $?
done

pushd "${SUBPRJOBJPATH}" 2> /dev/null > /dev/null
echo "Compiling subproject ${SUBPRJNAME}"
${CC} ${OPTS} -c $(find "${SUBPRJPATH}" -name "*.m") || exit $?
${CC} ${CODE_OPTS} -c $(find "${SUBPRJPATH}" -name "*.c") || exit $?
popd 2> /dev/null > /dev/null

exit 0
