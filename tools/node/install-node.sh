set -ex

export $(cat /tmp/node_arch.env)

curl -fsSL -o node.tar.xz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_ARCH}.tar.xz 
tar -xJf node.tar.xz
rm node.tar.xz
mv node-v${NODE_VERSION}-${NODE_ARCH}/bin $TOOLS_DIR/
mv node-v${NODE_VERSION}-${NODE_ARCH}/include $TOOLS_DIR/
mv node-v${NODE_VERSION}-${NODE_ARCH}/lib $TOOLS_DIR/
mv node-v${NODE_VERSION}-${NODE_ARCH}/share $TOOLS_DIR/
