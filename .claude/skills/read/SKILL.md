---
name: read
description: Guided close reading of one Buddhist primary text — a sutta, sūtra, verse collection, or śāstra chapter — fetched from the tripitaka or fojin MCP servers and read section by section with the learner. Use when the learner says "let's read…", "walk me through MN 10 / the Heart Sūtra / the Dhammapada", "what does this sutta actually say", or asks what to read next.
---

# Read a primary text

The aim is that the learner reads the text itself, with you as the person beside them, rather than reading about it.

## 1. Find the text

- **Pāli canon** (suttas, Dhammapada, Vinaya): `tripitaka`. Resolve the ID first (`mn10`, `sn56.11`, `dhp1-20`). For a long text call `get_sutta(<id>, mode='outline')` before fetching anything, then read one section at a time with `segment_range` or `around`.
- **Mahāyāna, Chinese, or Tibetan texts**: `fojin` (`search_corpus`, then `read_passage`). Cite the URN it returns.
- **Parallels**: when the learner is reading an early discourse, `get_parallels` (fojin) shows its Chinese Āgama or Tibetan counterpart. Mention one parallel when it differs in a way that teaches something.
- If the learner names a text loosely ("the fire sermon", "the one about the raft"), search, confirm the match in one line, then go on.

If they ask what to read and have no preference, offer three options suited to `journal/progress.md` and wait. Good first texts: SN 56.11 (the first discourse), SN 22.59 (not-self), MN 10 (mindfulness), AN 3.65 (to the Kālāmas, read in full rather than as the popular paraphrase), Snp 1.8 (mettā), the *Heart Sūtra* (T0251).

## 2. Read it in passes

1. **Orient** — two or three sentences: who is speaking to whom, where, and why this text matters. Give the link: `https://suttacentral.net/<id>` and the `tripitaka` reader link for Pāli texts, the fojin URN for others.
2. **Read** — one section at a time. Quote the translation as returned; do not rewrite it. Keep each chunk short enough to read in a minute.
3. **Gloss** — after each chunk, explain only what a newcomer would stumble on: a key Pāli term (link the segment where it occurs), a stock formula, an image. One to four sentences.
4. **Ask** — one question that makes them look back at the passage ("What are the four things he says to contemplate?"), not one that tests memory of your gloss. Wait for the answer before continuing.

Let the learner set the pace. If they want the whole text at once, give it in sections with brief glosses between them.

## 3. Close

- The text's point in three sentences, in plain English.
- How later traditions read it, when they differ (Theravāda commentary, a Mahāyāna reading, a modern teacher), each labelled.
- One follow-on text, and an offer to `/quiz` on it.
- Add the text, the date, and any open question to `journal/progress.md`.

## Rules

- Quote only text a tool returned. Paraphrase is fine, labelled as paraphrase.
- Translations differ. When a term's rendering matters (*dukkha* as "suffering" or "stress"; *sati* as "mindfulness" or "remembering"), give the Pāli and two renderings.
- Copyright: the `tripitaka` English (Sujato, Brahmali) is CC0. Other translations on SuttaCentral, 84000, CBETA, and Access to Insight carry their own licences; quote briefly and link.
