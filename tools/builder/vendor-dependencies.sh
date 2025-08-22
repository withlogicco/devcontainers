#!/bin/sh

set -eux; \
  mkdir -p $TOOLS_DIR/lib; \
  bins="$(find $TOOLS_DIR/bin $TOOLS_DIR/libexec -type f -perm -u=x 2>/dev/null)"; \
  libs="$(find $TOOLS_DIR/lib -type f -name '*.so*' || true)"; \
  deps="$( (echo "$bins"; echo "$libs") | xargs -r ldd \
      | awk '/=> \\//{print $3} /^\\/(lib|usr\\/lib)\\//{print $1}' \
      | sort -u)"; \
  for so in $deps; do \
    case "$so" in \
      $TOOLS_DIR/*) continue ;; \
      */ld-linux*.so.*|*/libc.so.*|*/libm.so.*|*/libdl.so.*|*/libpthread.so.*|*/librt.so.*) continue ;; \
    esac; \
    cp -L "$so" $TOOLS_DIR/lib/; \
  done; \
  strip --strip-unneeded $TOOLS_DIR/lib/*.so* || true