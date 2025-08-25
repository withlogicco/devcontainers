#!/bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

# Define LDFLAGS so installed binaries will prefer ../lib at runtime

LDFLAGS="-Wl,-rpath,'\$ORIGIN/../lib'"

echo "LDFLAGS=$LDFLAGS" >> "$BUILDER_ENV_FILE"
