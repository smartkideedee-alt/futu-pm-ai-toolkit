#!/bin/bash
# Render a Mermaid DSL file to PNG or SVG using Mermaid CLI (mmdc)
# Usage: render-mermaid.sh <input.mmd> [output.png|output.svg]
# Output: path to the rendered file (stdout)
# Dependency: mmdc — npm install -g @mermaid-js/mermaid-cli

set -e

INPUT_FILE="${1}"
OUTPUT_DIR="/tmp/pm-diagrams"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="${2:-${OUTPUT_DIR}/diagram_${TIMESTAMP}.png}"

if [ -z "$INPUT_FILE" ]; then
  echo "Usage: $0 <input.mmd> [output.png]" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

MMDC_BIN="${MMDC_BIN:-mmdc}"
if ! command -v "$MMDC_BIN" &>/dev/null; then
  MMDC_BIN="/Users/admin/.node24/bin/mmdc"
fi

if ! command -v "$MMDC_BIN" &>/dev/null && [ ! -x "$MMDC_BIN" ]; then
  echo "Error: Mermaid CLI not found. Install with: npm install -g @mermaid-js/mermaid-cli" >&2
  exit 1
fi

"$MMDC_BIN" \
  --input "$INPUT_FILE" \
  --output "$OUTPUT_FILE" \
  --theme neutral \
  --backgroundColor white \
  --width 1400 \
  --height 900 \
  --scale 2

echo "✅ Rendered: $OUTPUT_FILE" >&2
echo "$OUTPUT_FILE"
