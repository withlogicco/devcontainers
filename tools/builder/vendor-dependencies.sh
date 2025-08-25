#!/bin/sh

set -eux

# Require a single argument: path to tools root
if [ "${1:-}" = "" ]; then
  echo "Usage: $0 <TOOL_DIR>" >&2
  exit 2
fi

TOOL_DIR="$1"

# Ensure destination exists
mkdir -p "$TOOL_DIR/lib"

# Collect candidate binaries and any pre-existing shared libs under tools
bins="$(find "$TOOL_DIR/bin" "$TOOL_DIR/libexec" -type f -perm -u=x 2>/dev/null || true)"
libs="$(find "$TOOL_DIR/lib" -type f -name '*.so*' 2>/dev/null || true)"

# Run ldd on each file (if any) and extract dependency paths.
deps=$(
  {
    # Print one path per line only if variables are non-empty
    [ -n "$bins" ] && printf '%s\n' $bins || true
    [ -n "$libs" ] && printf '%s\n' $libs || true
  } 2>/dev/null \
  | while IFS= read -r f; do
      # Skip empty lines defensively
      [ -n "$f" ] || continue
      # ldd may fail for non-ELF files; ignore errors
      ldd "$f" 2>/dev/null || true
    done \
  | while IFS= read -r line; do
      # If the line contains '=>', the resolved path is typically the third word
      case "$line" in
        *' => '*) set -- $line; p="$3" ;; 
        /lib/*|/usr/lib/*) set -- $line; p="$1" ;;
        *) p="" ;;
      esac
      # print only absolute paths
      [ -n "$p" ] && case "$p" in /*) printf '%s\n' "$p" ;; esac
    done \
  | sort -u
)

# Copy non-glibc dependencies into tools/lib
for so in $deps; do
  case "$so" in
    "$TOOL_DIR"/*) continue ;;
    */ld-linux*.so.*|*/libc.so.*|*/libm.so.*|*/libdl.so.*|*/libpthread.so.*|*/librt.so.*) continue ;;
  esac
  cp -L "$so" "$TOOL_DIR/lib/"
done

# Best-effort strip to reduce size (only when files exist)
find "$TOOL_DIR/lib" -type f -name '*.so*' -exec strip --strip-unneeded {} + 2>/dev/null || true