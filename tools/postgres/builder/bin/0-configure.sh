#!/bin/sh

set -eux

# Define LDFLAGS so installed binaries will prefer ../lib at runtime

LDFLAGS="-Wl,-rpath,'\$ORIGIN/../lib'"

echo "LDFLAGS=$LDFLAGS" >> "$BUILDER_ENV_FILE"
