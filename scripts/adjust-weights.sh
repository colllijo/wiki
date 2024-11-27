#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <language-code>"
  exit 1
fi

LANGUAGE_CODE=$1

ROOT_DIR="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" && pwd)"

find "$ROOT_DIR/content/docs" -type f -name "*.md" | while read -r file; do
  RELATIVE_PATH=$(realpath --relative-to="$ROOT_DIR/content/docs" "$file")
  LANG_FILE="$ROOT_DIR/content/$LANGUAGE_CODE/docs/$RELATIVE_PATH"

  if [[ ! -f "$LANG_FILE" ]]; then
    continue
  fi

  WEIGHT=$(awk -v key="weight" '
    BEGIN { FS=": "; in_front_matter=0 }
    /^---$/ { in_front_matter = !in_front_matter; next }
    in_front_matter && $1 == key { print $2; exit }
  ' "$file")

  awk -v key="weight" -v new_value="$WEIGHT" '
    BEGIN { FS=": "; OFS=": "; in_front_matter=0 }
    /^---$/ { in_front_matter = !in_front_matter; print; next }
    in_front_matter && $1 == key { $2 = new_value }
    { print }
  ' "$LANG_FILE" > "$LANG_FILE.tmp" && mv "$LANG_FILE.tmp" "$LANG_FILE"
done
