#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

cd postgresql-$TOOL_VERSION

# Configure to install under $TOOL_DIR and enable useful client features
./configure --prefix=$TOOL_DIR --with-openssl --with-icu --with-libxml --with-libxslt --without-ldap

# Build and install only libpq and client binaries (psql, pg_dump, etc.)
make -C src/interfaces/libpq all 
make -C src/interfaces/libpq install
make -C src/bin all
make -C src/bin install
