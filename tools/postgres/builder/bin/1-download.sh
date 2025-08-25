#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

curl -fsSL -o postgresql.tar.gz https://ftp.postgresql.org/pub/source/v${TOOL_VERSION}/postgresql-${TOOL_VERSION}.tar.gz
tar -xzf postgresql.tar.gz
rm postgresql.tar.gz