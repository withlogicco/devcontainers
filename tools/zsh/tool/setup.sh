#! /bin/sh

set -eux

DEFAULT_TOOL_DIR=${1:-${TOOLS_ROOT}/zsh}

export TOOL_DIR=${TOOL_DIR:-$DEFAULT_TOOL_DIR}

mkdir -p $TOOL_DIR
cp -r ./bin $TOOL_DIR/bin
cp -r ./lib $TOOL_DIR/lib
cp -r ./share $TOOL_DIR/share

for f in "$TOOL_DIR/bin"/*; do
    [ -e "$f" ] || continue   # skip if glob didn't match
    [ -d "$f" ] && continue   # skip directories
    name="${f##*/}"
    ln -sf "$f" "/usr/local/bin/$name"
done

# Install up Oh My Zsh
cp $TOOL_DIR/share/oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
ln -s $TOOL_DIR/share/oh-my-zsh ~/.oh-my-zsh
