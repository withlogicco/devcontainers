#! /bin/sh

set -eux

DEFAULT_TOOL_DIR=${1:-${TOOLS_ROOT}/node}

export TOOL_DIR=${TOOL_DIR:-$DEFAULT_TOOL_DIR}

mkdir -p ${TOOL_DIR}
cp -r ./bin ${TOOL_DIR}/bin
cp -r ./include ${TOOL_DIR}/include
cp -r ./lib ${TOOL_DIR}/lib
cp -r ./share ${TOOL_DIR}/share

ln -s ${TOOL_DIR}/bin/corepack /usr/local/bin/corepack
ln -s ${TOOL_DIR}/bin/node /usr/local/bin/node
ln -s ${TOOL_DIR}/bin/npm /usr/local/bin/npm
ln -s ${TOOL_DIR}/bin/npx /usr/local/bin/npx
