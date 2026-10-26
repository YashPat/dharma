# dharma

A study companion for Buddhism. Open this folder in Claude Code and ask anything, from the four noble truths to Huayan's jewelled net to which mental factors can share a single moment of mind. Answers name their tradition and cite primary texts you can click through to read.

It is assembled almost entirely from established public tools. The only original parts are the tutor's instructions and a Theravāda Abhidhamma skill built on the reference sheets from [abhidhamma](https://github.com/YashPat/abhidhamma).

## Start

```bash
git clone https://github.com/YashPat/dharma && cd dharma
claude
```

On first launch Claude Code asks you to:

1. **Trust the folder.**
2. **Approve two MCP servers**, `tripitaka` and `fojin`. Both are hosted, read-only, and need no keys.
3. **Install the Master-skill plugin** from its marketplace. If you skip the prompt, run `/plugin marketplace add xr843/Master-skill`, then `/plugin install master-skill@master-skill`.

Then talk to it in plain English.

## Try

- "What did the Buddha actually teach in the first sermon? Let's read it." → `/read`
- "Is 'pain is inevitable, suffering is optional' really a Buddhist quote?"
- "How do Theravāda and Zen differ on what awakening is?"
- "How would Nāgārjuna answer: if nothing has inherent existence, does anything matter?" → `/master-nagarjuna`
- "Compare how Huineng and Tsongkhapa understand meditation." → `/compare-masters`
- "I snapped at a coworker who interrupted me. Take that apart." → `/abhidhamma`
- "Why can't compassion and appreciative joy arise in the same mind-moment?" → `/abhidhamma`
- "Quiz me on the five aggregates." → `/quiz`
- "I'm new. Where do I start?"

## What's inside

| Piece | Source | Gives the tutor |
| --- | --- | --- |
| [`tripitaka`](https://github.com/dhamma-seeker/tripitaka-mcp) MCP | Public, MIT, official MCP registry | The full Pāli canon with English, search, `verify_quote`, translation comparison, dictionaries |
| [`fojin`](https://github.com/xr843/fojin) MCP | Public, Apache-2.0, official MCP registry | Chinese, Pāli, and Tibetan canons, cross-canon parallels, 30+ dictionaries |
| [Master-skill](https://github.com/xr843/Master-skill) plugin | Public, MIT code / CC BY-NC-SA content | 16 historical-master personas across Indian, Chinese, Tibetan, and Theravāda traditions; compare, debate, and curriculum modes |
| Built-in WebFetch | Claude Code | SuttaCentral and Digital Pāli Dictionary JSON APIs, CBETA, Access to Insight |
| [`/abhidhamma`](.claude/skills/abhidhamma/SKILL.md) | This repo | Theravāda Abhidhamma: deconstruct a moment, find the antidote, choose a practice, learn the system |
| [`/read`](.claude/skills/read/SKILL.md) | This repo | Guided close reading of one text, section by section |
| [`/quiz`](.claude/skills/quiz/SKILL.md) | This repo | Spaced retrieval practice, logged to your journal |

The three skills exist because no maintained tool covers their job. No public skill pack has an Abhidhamma curriculum, a guided-reading workflow over these MCP servers, or a quiz mode. [`reports/Buddhist MCP servers and skills.md`](reports/Buddhist%20MCP%20servers%20and%20skills.md) records how the tools were chosen and what was left out.

## Layout

```
AGENTS.md               the tutor's instructions (CLAUDE.md imports it)
ETHICS.md               boundaries, licences, and why SuttaCentral-derived tools are used
.mcp.json               tripitaka + fojin
.claude/settings.json   enables the servers and the Master-skill marketplace
.claude/skills/         abhidhamma, read, quiz
references/abhidhamma/  citta, cetasika, sampayoga, vīthi sheets + output format
journal/                your progress, quiz log, analyses (git-ignored)
reports/, research_notes/  the research behind the tool choices
scripts/sync-abhidhamma.sh  refresh the sheets from ../abhidharma
```

## Running without hosted servers

Both MCP servers have local modes if you would rather not send queries to a third party. Replace the entries in `.mcp.json`:

```jsonc
// tripitaka: pipx install tripitaka-mcp && tripitaka-mcp init   (~120 MB; no semantic search offline)
"tripitaka": { "command": "tripitaka-mcp", "args": ["serve"] }

// fojin: runs locally but still calls the fojin.app API
"fojin": { "command": "uvx", "args": ["fojin-mcp"] }
```

For deep CBETA, SAT, and Tibetan work, [sinryo/buddha-cli](https://github.com/sinryo/buddha-cli) is an option. It builds from source with Rust and downloads several gigabytes of local corpora.

## Other agents

`AGENTS.md` works in Cursor, Codex, and other agents that read it. They can use `.mcp.json`'s servers if configured. Master-skill installs there with `npx skills add xr843/Master-skill --full-depth`. The skills in `.claude/skills/` are plain `SKILL.md` files.

## Boundaries

This is a study aid, not a teacher. It will not judge your attainments, give personal practice direction, or speak as the Buddha or a living teacher. Quotations come from retrieved text or are marked as paraphrase. See [ETHICS.md](ETHICS.md).
