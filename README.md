# dharma

A study companion for Buddhism. Open this folder in Claude Code and ask anything: the four noble truths, emptiness, how Zen differs from Theravāda, or which mental factors can share one moment of mind. Answers name their tradition and link to the primary texts.

## Start

```bash
cd dharma && claude
```

Approve the two MCP servers when asked. Then ask in plain English:

- "What did the Buddha teach in the first sermon? Let's read it."
- "Is 'pain is inevitable, suffering is optional' really a Buddhist quote?"
- "How do Theravāda and Zen differ on awakening?"
- "I snapped at a coworker who interrupted me. Take that apart."
- "Quiz me on the five aggregates."

## What's inside

| | |
| --- | --- |
| [`tripitaka`](https://github.com/dhamma-seeker/tripitaka-mcp) MCP | The Pāli canon with English, search, and quote verification |
| [`fojin`](https://github.com/xr843/fojin) MCP | Chinese, Pāli, and Tibetan canons, parallels, dictionaries |
| `/abhidhamma` | Theravāda Abhidhamma, grounded in the sheets in `references/abhidhamma/` |
| `/read` | Read one text together, section by section |
| `/quiz` | Spaced retrieval practice |

Both servers are public and hosted, and need no keys. The three skills cover what no existing tool does. `AGENTS.md` tells the tutor how to use all of it. `journal/` holds your progress and is git-ignored.

The Abhidhamma sheets come from [abhidhamma](https://github.com/YashPat/abhidhamma); refresh them with `scripts/sync-abhidhamma.sh`.

## Optional

- **Tradition personas:** [Master-skill](https://github.com/xr843/Master-skill) adds 16 historical masters and compare and debate modes (Chinese-first). Install it with `/plugin marketplace add xr843/Master-skill`, then `/plugin install master-skill@master-skill`.
- **Run offline:** `pipx install tripitaka-mcp && tripitaka-mcp init`, then set `.mcp.json` to `"tripitaka": {"command": "tripitaka-mcp", "args": ["serve"]}`.

## Boundaries

This is a study aid, not a teacher. It will not judge attainments or speak as the Buddha or a living teacher, and it quotes only text it has retrieved. See [ETHICS.md](ETHICS.md). The research behind the tool choices is in [`reports/`](reports/).
