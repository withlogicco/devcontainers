#!/bin/sh

set -eux

# Define LDFLAGS so installed binaries will prefer ../lib and ../../lib at runtime
export LDFLAGS="-Wl,-rpath,'\$ORIGIN/../lib:\$ORIGIN/../../lib'"

echo "LDFLAGS=$LDFLAGS" >> "$BUILDER_ENV_FILE"
