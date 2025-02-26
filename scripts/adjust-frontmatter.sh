#!/bin/bash

set -euo pipefail

usage() {
  echo "Usage: $0 [options] <language-code>"
  echo ""
  echo "Options:"
  echo "  -d, --draft        Also adjust the draft state"
  echo "  -p, --path <path>  Specify a partial path to filter files"
}

has_argument() {
    [[ ("$1" == *=* && -n ${1#*=}) || ( ! -z "$2" && "$2" != -*)  ]];
}

extract_argument() {
  echo "${2:-${1#*=}}"
}

update_frontmatter() {
  local file="$1"
  local lang_file="$2"
  local key="$3"

  local value

  value=$(awk -v key="$key" '
    BEGIN { FS=": "; in_front_matter=0 }
    /^---$/ { in_front_matter = !in_front_matter; next }
    in_front_matter && $1 == key { print $2; exit }
  ' "$file")

  awk -v key="$key" -v new_value="$value" '
    BEGIN { FS=": "; OFS=": "; in_front_matter=0 }
    /^---$/ { in_front_matter = !in_front_matter; print; next }
    in_front_matter && $1 == key { $2 = new_value }
    { print }
  ' "$lang_file" > "$lang_file.tmp" && mv "$lang_file.tmp" "$lang_file"
}

DRAFT=false
LANGUAGE_CODE=""
PARTIAL_PATH=""

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    -h | --help)
      usage
      exit 0
      ;;
    -d | --draft)
      DRAFT=true
      ;;
    -p | --path*)
      if ! has_argument "$@"; then
        echo "Missing argument for $1" >&2
        usage
        exit 1
      fi

      PARTIAL_PATH=$(extract_argument "$@")
      shift
      ;;
    *)
      if [[ -z "$LANGUAGE_CODE" ]]; then
        LANGUAGE_CODE=$1
      else
        echo "Unknown argument: $1" >&2
        usage
        exit 1
      fi
      ;;
  esac
  shift
done

if [[ -z $LANGUAGE_CODE ]]; then
  echo "Missing language code" >&2
  usage
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" && pwd)"

find "$ROOT_DIR/content/docs" -type f -name "*.md" | while read -r file; do
  if [[ -n "$PARTIAL_PATH" && "$file" != *"$PARTIAL_PATH"* ]]; then
    continue
  fi

  RELATIVE_PATH=$(realpath --relative-to="$ROOT_DIR/content/docs" "$file")
  LANG_FILE="$ROOT_DIR/content/$LANGUAGE_CODE/docs/$RELATIVE_PATH"

  if [[ ! -f "$LANG_FILE" ]]; then
    continue
  fi

  update_frontmatter "$file" "$LANG_FILE" "weight"
  update_frontmatter "$file" "$LANG_FILE" "icon"
  update_frontmatter "$file" "$LANG_FILE" "toc"

  if [[ $DRAFT ]]; then
    update_frontmatter "$file" "$LANG_FILE" "draft"
  fi
done
