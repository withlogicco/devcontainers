#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

curl -fsSL -o git.tar.xz https://www.kernel.org/pub/software/scm/git/git-$TOOL_VERSION.tar.xz

tar -xJf git.tar.xz
rm git.tar.xz