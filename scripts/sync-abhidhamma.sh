#!/usr/bin/env bash
# Refresh references/abhidhamma/ from the learner's abhidhamma repo.
# Usage: scripts/sync-abhidhamma.sh [path-to-abhidhamma-repo]
set -euo pipefail

src="${1:-$(dirname "$0")/../../abhidharma}"
dest="$(dirname "$0")/../references/abhidhamma"

for f in citta.md cetasika.md sampayoga.md vithi.md output.md; do
  cp "$src/$f" "$dest/$f"
done

rev="$(git -C "$src" rev-parse --short HEAD 2>/dev/null || echo unknown)"
echo "Synced from $src at $rev"
