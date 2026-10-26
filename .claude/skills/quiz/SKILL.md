---
name: quiz
description: Retrieval-practice quiz on Buddhism and the Abhidhamma, drawn from what the learner has studied and spaced by what they have missed before. Use when the learner says "quiz me", "test me", "drill me on…", "flashcards", or "do I actually know this", or at the end of a lesson when they accept an offer to be quizzed.
---

# Quiz

Retrieval beats rereading. Ask, wait, then correct. One question at a time.

## Choose the questions

1. Read `journal/quiz.md` (create it if missing) and `journal/progress.md`.
2. Draw the set from, in order of priority:
   - items marked **missed** whose `due` date has passed,
   - the topic the learner names,
   - topics in `progress.md` covered recently but never quizzed.
3. Five questions by default. Mix types:
   - **Recall** — "Name the seven universal cetasikas."
   - **Discriminate** — "Can lobha and dosa arise in one citta? Why not?"
   - **Apply** — "Someone is envious of a friend's promotion. Which root, and which factor that arises singly?"
   - **Source** — "Which sutta gives the first teaching of the four noble truths?"
   - **Tradition** — "Who holds that dharmas exist in all three times?"

## Ground every answer

- Abhidhamma answers come from `references/abhidhamma/`. Read the sheet before marking. A count must match the sheet, with its reckoning (89 or 121) stated.
- Sutta and doctrine answers: check with `tripitaka` (`define_from_suttas`, `search_hybrid`) or `fojin` when the fact is not trivially certain.
- If you cannot verify the answer, drop the question.

## Run it

- Ask the question. Do not show the answer or options unless it is multiple choice by design.
- On an answer: say right, partly right, or not yet. Give the correct answer in one or two sentences with its source (sheet and section, or sutta link). For a partly right answer, name exactly what was missing.
- Do not move on until they reply. If they say "skip" or "I don't know", give the answer and mark it missed.
- At the end: score, the one distinction most worth revisiting, and a pointer to read it.

## Log it

Append to `journal/quiz.md`, one line per question:

```
| date | topic | question (short) | result | due |
```

`result` is `ok`, `partial`, or `missed`. Set `due`: missed → tomorrow, partial → 3 days, ok after a previous miss → 7 days, ok twice in a row → 21 days, otherwise 30 days.
