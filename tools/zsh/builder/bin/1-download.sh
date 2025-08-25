#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

# Download zsh
curl -fsSL -o zsh.tar.xz https://sourceforge.net/projects/zsh/files/zsh/$ZSH_VERSION/zsh-$ZSH_VERSION.tar.xz/download

tar -xJf zsh.tar.xz
rm zsh.tar.xz

# Download Oh My Zsh!
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git $TOOL_DIR/share/oh-my-zsh