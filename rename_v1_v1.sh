#!/bin/bash
TARGET_DIR="${1:-.}"
DRY_RUN=false

find "$TARGET_DIR" -type f \
  -not -path "*/.git/*" \
  -not -path "*/.ipynb_checkpoints/*" \
  -not -path "*/__pycache__/*" \
  -not -path "*/data/raw/*" \
  -not -path "*/data/Glove/*" \
  -not -name ".gitignore" \
  -not -name "README.md" \
  -not -name ".DS_Store" \
  | while read -r file; do
    dir=$(dirname "$file")
    base=$(basename "$file")

    if [[ "$base" == *.* && "$base" != .* ]]; then
      name="${base%.*}"
      ext="${base##*.}"
      newname="${name}_v1.${ext}"
    else
      newname="${base}_v1"
    fi

    if [ "$DRY_RUN" = true ]; then
      echo "WOULD RENAME: $file  ->  $dir/$newname"
    else
      mv -- "$file" "$dir/$newname"
      echo "renamed: $file -> $dir/$newname"
    fi
  done
