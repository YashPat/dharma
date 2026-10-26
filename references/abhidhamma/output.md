# Output Reference Sheet

## What This File Is

The other four sheets are the source. This one is only the shape.

`citta.md`, `cetasika.md`, `sampayoga.md`, and `vithi.md` say what is true. This file says how to lay an answer out so it can be read by someone still building the vocabulary. Nothing here is doctrine, and nothing here may be cited as the basis for a structural claim. Every count, rule, and exclusion in a finished artifact must be verified against the four sheets.

Abhidhamma is dense; an answer does not have to be. An artifact should preserve the few structural facts that explain the experience, not every relevant fact in the system. It is a short explanation the reader can return to, while the chat becomes a pointer to it.

## Chat Versus Artifact

Not every question deserves a file. Writing one for "what does māna mean" is friction with no payoff.

| Ask | Response |
| --- | --- |
| A scenario to deconstruct | Artifact, plus a short chat summary |
| An affliction with a request for the antidote and a practice | Artifact, plus a short chat summary |
| "Teach me this" — a concept, a section, a sheet | Artifact, plus a short chat summary |
| A single factor, count, or definition | Chat only, a few sentences |
| A follow-up question about an artifact already written | Chat only, unless the answer is long enough to belong in the file, in which case amend the file |
| Thinking out loud — talk it through, brainstorm | Chat only. Follow the thread. Do not open an artifact. |

When an artifact is written, the chat response is at most four sentences: what happened structurally, what to do, and a link to the file. Use plain English, with no Pāli, citations, tables, or section-by-section recap.

In chat-only answers, give the Pāli first with a plain-English gloss on first use — `dosa` (hatred), for example — then use the Pāli. Cite a relevant sheet with a light pointer the reader can follow.

Artifacts go in `analyses/`, named `YYYY-MM-DD-slug.md`, where the slug is a few words naming the scenario or concept. Never write into the four source sheets.

## How to Write One

**Write for someone meeting the vocabulary for the first time.** The short version uses ordinary English only. Put the small glossary before the technical explanation so the reader learns each necessary Pāli term before encountering it. In the body, say the plain-language point first and name the Pāli once only when the name helps.

**Keep sources out of the prose.** Verify every structural claim and count against the four sheets, but put artifact citations only in the glossary and the closing reading list. If the source matters to the meaning — for example, the sheets are silent and the claim comes from elsewhere — say that plainly in the body.

**Explain the link, then stop.** Do not merely name a structural fact: state why it matters in this experience. In the short version, that explanation is one sentence on what the breakdown lets the reader do. Where other people will see the response, the practice names the words and what a bystander registers. If wisdom was absent, explain what that changes about the interpretation; do not continue into every other factor that was also absent. Length is not thoroughness; cut adjacent facts and any claim that needs a long detour before it helps.

**Use plain language for certainty.** Do not use `[partition]`, `[rule]`, `[function]`, or `[inference]` tags. Say instead, where relevant: "this follows automatically because the two classes do not overlap," "the sheets state this specific rule," or "this is an inference from your description."

**Respect the budget.**

- Aim for **1,200–1,800 words**. The ceiling is **2,000 words**.
- The short version is at most **8 sentences**.
- The glossary has **5–8 terms**, with at most **2 sentences** per term.
- The deconstruction is at most **800 words** and may use at most **one short table**.
- Give **1–3 practices**.
- Include at most **one caveat**, and only when it changes what the reader should do.
- State a count only when the number changes or sharpens the argument.

### What Makes an Artifact Too Long

- Splitting one deconstruction into separate sections for the process, citta, factors, and exclusions.
- Repeating citations and counts inside explanatory sentences.
- Proving why every unused interpretation or practice was rejected.
- Cataloguing every factor that could have been present instead of selecting the two or three that explain the experience.
- Re-explaining a term in the body after defining it in the glossary.

## Template — Analysis

For a scenario deconstructed, an affliction answered, or both. Keep these five sections in this order. The glossary comes before the deconstruction so the body never assumes vocabulary the reader has not met.

```markdown
# <Scenario in a few plain words>

*<date> · <five-door | mind-door> · <dominant root, in plain English>*

## The short version

Six to eight sentences in plain English, with no Pāli, counts, or citations.
Say what happened, where the reaction was added, and what the decisive
counterweight is. One sentence says why the breakdown is worth knowing:
what it lets the reader do that the feeling by itself does not. End with
the response they can actually carry out. Where other people will see it,
that ending is the words to say and what a bystander registers, not only
an instruction to leave both bad reactions. Someone who reads only this
section should have the full practical answer.

## Words you'll need

| Term | What it means here | Source |
| --- | --- | --- |
| <Pāli> | One or two plain sentences. Explain the term's job in this experience, not merely its dictionary gloss. | `<sheet>`, "<section>" |

Use five to eight terms, only those needed below. This is where definitions
and their citations live.

## What happened

Give the deconstruction as one continuous explanation:

1. What bare sensing gave, if a sense door matters, and what later mind-door
   processes added.
2. Where the mind determined how to take the object.
3. The dominant citta: root, feeling, view or knowledge, and prompting only
   where the description settles them.
4. The two or three factors that explain the experience.
5. The one or two absences or exclusions that change how it should be
   understood.

Use at most one short table if the sequence is clearer than prose. If a
variable is unresolved, state that in one sentence and say what detail would
settle it. For an extended event, say once that this describes its repeating
pattern rather than pretending the whole event was one mind-moment.

## The practice

Open with one sentence connecting the practice to the leverage point. Do not
compare it with practices not chosen. Give one to three practices. When
other people will see the response, or the same person will do this again,
one practice is the line to say. Add the two bullets below to that practice.
The wording and the audience effect sit outside the sheets; say so in one
clause. Leaving both bad reactions is the inner half of that practice. A
silence the room will read as acceptance is not the move.

### <Practice in plain words>

- **Object** —
- **When and how long** —
- **Instruction** — the actual phrase or noting instruction
- **What you say** — the sentence, once, when other people will hear it. Omit this bullet when nobody will.
- **What others see** — what a bystander registers. Omit this bullet when nobody will. One clause that the sheets are silent on the social effect.
- **What will go wrong** —
- **Factor this builds** —
- **Citta this occasions** —

Include at most one caveat, only if it changes how the reader should use the
practice.

## Where to read this in the sheets

Three or four numbered pointers, in reading order. Each points to a specific
sheet and section and says which claim or count above it supports. This is
where citations not already in the glossary live.
```

## Template — Lesson

For "explain this to me." Use the same budget as an analysis. A lesson has four sections, not a deconstruction disguised as one.

```markdown
# <Concept>

*<date> · lesson*

## The short version

At most eight sentences in plain English. State what problem the concept
solves, what it means, the distinction most likely to be confused, and what
it gives the reader in practice if the sheets support a practical use.

## Words you'll need

| Term | What it means here | Source |
| --- | --- | --- |
| <Pāli> | One or two plain sentences that prepare the walkthrough below. | `<sheet>`, "<section>" |

Use no more than eight terms.

## The concept worked through

Start with the problem the concept solves, then explain its structure through
one concrete case. For a factor, show one mind-moment where it is present and
one where it is absent, and explain why. For a rule, show one case it forbids
and one it permits. Include the common confusion as a direct contrast inside
the walkthrough. State counts only where the case needs them, and keep the
whole section under 1,000 words.

## Where to read next

Three or four specific sections in reading order. Say what each will clarify
and use this list to source any structural claim or count not already sourced
in the glossary.
```
