#!/bin/sh

set -eux

# Accept zero or one argument: path to a packages file. Default to ./Aptfile when omitted.
if [ "$#" -gt 1 ]; then
	echo "Usage: $0 [aptfile_path]" >&2
	exit 2
fi

if [ "$#" -eq 0 ]; then
	PKG_FILE="./Aptfile"
else
	PKG_FILE="$1"
fi

if [ ! -f "$PKG_FILE" ]; then
	echo "Aptfile not found: $PKG_FILE" >&2
	exit 3
fi

# Read file, ignore blank lines and lines starting with #, join words into a single list
PACKAGES=""
while IFS= read -r line || [ -n "$line" ]; do
	# Trim leading/trailing whitespace
	pkg=$(printf '%s' "$line" | awk '{$1=$1;print}')

	# Skip empty or comment lines
	case "$pkg" in
		''|\#*) continue ;;
	esac

	PACKAGES="$PACKAGES $pkg"
done < "$PKG_FILE"

# If no packages found, exit
if [ -z "$(printf '%s' "$PACKAGES" | tr -d ' ')" ]; then
	echo "No packages to install (empty or comments-only file)." >&2
	exit 0
fi

apt-get update
apt-get install -y --no-install-recommends $PACKAGES
