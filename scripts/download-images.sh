#!/usr/bin/env bash
# Downloads every image from the current WordPress site into ./images.
# Run this BEFORE you shut down your WordPress hosting.
#
#   macOS / Linux:  bash scripts/download-images.sh
#
# Safe to run more than once: files that already exist are skipped.
set -u
cd "$(dirname "$0")/.."

ok=0
failed=0
while read -r path url; do
  [[ -z "${path:-}" || "$path" == \#* ]] && continue
  if [[ -s "$path" ]]; then ok=$((ok + 1)); continue; fi
  mkdir -p "$(dirname "$path")"
  if curl -fsSL --retry 2 -o "$path" "$url"; then
    echo "OK    $path"
    ok=$((ok + 1))
  else
    echo "FAIL  $url"
    rm -f "$path"
    failed=$((failed + 1))
  fi
done < scripts/images.txt

echo
echo "Done: $ok images in place, $failed failed."
[[ $failed -eq 0 ]] || echo "Run the script again to retry the failed ones."
