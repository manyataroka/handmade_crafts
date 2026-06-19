#!/usr/bin/env bash
set -euo pipefail

# Downloads 15 jewelry/craft related images into assets/images/
# Uses Unsplash Source (random images matching the query). These images
# are free to use under Unsplash license, but consider attribution.

# Resolve the assets directory (script lives in assets/scripts)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="$ROOT_DIR/images"
mkdir -p "$OUT_DIR"

queries=(
  "jewelry"
  "handmade+jewelry"
  "necklace"
  "bracelet"
  "earrings"
  "ring"
  "beads"
  "handmade+crafts"
  "silver+jewelry"
  "pearl+jewelry"
  "boho+jewelry"
  "gold+jewelry"
  "pendant"
  "gemstone+jewelry"
  "artisan+jewelry"
)

count=1
for q in "${queries[@]}"; do
  filename=$(printf "%s/img%02d.jpg" "$OUT_DIR" $((count + 4)))
  echo "Downloading image #$count for query '$q' -> $filename"
  # Use picsum.photos with a seed for predictable, unique images per query
  img_url="https://picsum.photos/seed/$(echo ${q} | sed 's/[^a-zA-Z0-9]/_/g')/800/800"
  curl -fSL "$img_url" -o "$filename" || echo "Warning: failed to download ${q}"
  count=$((count + 1))
done

# download a simple placeholder craftybee logo (replace with your real logo)
logo_url="https://picsum.photos/seed/craftybee/600/200"
echo "Downloading placeholder logo -> $OUT_DIR/craftybee_logo.png"
curl -fSL "$logo_url" -o "$OUT_DIR/craftybee_logo.png" || echo "Warning: failed to download logo"

echo "Downloaded $((count - 1)) images into $OUT_DIR"

echo "Tip: run 'flutter pub get' and then rebuild the app to use the new assets."