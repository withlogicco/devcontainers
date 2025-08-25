#! /bin/sh

set -eux

export TOOL_DIR=${TOOL_DIR:-/opt/tools/postgres}

mkdir -p ${TOOL_DIR}
cp -r ./bin ${TOOL_DIR}/bin
cp -r ./include ${TOOL_DIR}/include
cp -r ./lib ${TOOL_DIR}/lib
cp -r ./share ${TOOL_DIR}/share

for f in "${TOOL_DIR}/bin"/*; do
    [ -e "$f" ] || continue   # skip if glob didn't match
    [ -d "$f" ] && continue   # skip directories
    name="${f##*/}"
    ln -sf "$f" "/usr/local/bin/$name"
done
