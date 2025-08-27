#! /bin/sh

set -eux

export TOOL_DIR=${TOOL_DIR:-/opt/tools/git}

mkdir -p $TOOL_DIR $TOOL_DIR/bin $TOOL_DIR/lib $TOOL_DIR/libexec $TOOL_DIR/share

if [ "$(pwd -P)" != "$TOOL_DIR" ]; then
    cp -r ./bin "$TOOL_DIR/bin"
    cp -r ./lib "$TOOL_DIR/lib"
    cp -r ./libexec "$TOOL_DIR/libexec"
    cp -r ./share "$TOOL_DIR/share"
else
    printf 'Skipping copy: current directory is %s\n' "$TOOL_DIR" >&2
fi

for f in "$TOOL_DIR/bin"/*; do
    [ -e "$f" ] || continue   # skip if glob didn't match
    [ -d "$f" ] && continue   # skip directories
    name="${f##*/}"
    ln -sf "$f" "/usr/local/bin/$name"
done
