#! /bin/sh

set -eux

export TOOL_DIR=${TOOL_DIR:-/opt/tools/git}

mkdir -p $TOOL_DIR
cp -r ./bin $TOOL_DIR/bin
cp -r ./lib $TOOL_DIR/lib
cp -r ./share $TOOL_DIR/share

ln -s $TOOL_DIR/bin/git /usr/local/bin/git
ln -s $TOOL_DIR/bin/git-cvsserver /usr/local/bin/git-cvsserver
ln -s $TOOL_DIR/bin/git-remote-http /usr/local/bin/git-remote-http
ln -s $TOOL_DIR/bin/git-remote-https /usr/local/bin/git-remote-https
ln -s $TOOL_DIR/bin/git-shell /usr/local/bin/git-shell
ln -s $TOOL_DIR/bin/git-upload-archive /usr/local/bin/git-upload-archive
ln -s $TOOL_DIR/bin/git-upload-pack /usr/local/bin/git-upload-pack
ln -s $TOOL_DIR/bin/gitk /usr/local/bin/gitk
ln -s $TOOL_DIR/bin/scalar /usr/local/bin/scalar
