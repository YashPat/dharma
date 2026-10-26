# Buddhist / Abhidharma AI agent skills, prompt packs and tutor projects (inventory as of 2026-10-26)

Method: GitHub API (repo metadata, trees, LICENSE files read directly via `gh api`), GitHub repo search, web search/fetch of articles. Star counts and "last push" dates were read on 2026-10-26 and will drift. GitHub search was rate-limited partway through, so the long tail of 0-star repos was not covered exhaustively.

## Q1. Inventory: URL, author, stars, last activity, license, what it does, structure, safeguards

### Takeaway
Only one project is mature: xr843/Master-skill (472 stars, pushed 2026-10-26), a Claude Code plugin with 16 historical-master personas plus compare/debate/curriculum/help modes, citation contracts, a shared safety clause and promptfoo fidelity tests. Its persona content is CC BY-NC-SA 4.0; only its code (MIT) and prompt templates (CC BY 4.0) can be reused freely. BuddhismAI/buddhist-agent-skills (MIT, Nyingma-sourced, includes an Abhidharmakośa topic) is the only other real SKILL.md pack for Buddhist doctrine, and its content provenance is a concern. Everything else is tiny or off-target: generic chatbots, MCP servers, or "Buddhist principles for coding" skills.

### Cited Findings

**1. xr843/Master-skill** — https://github.com/xr843/Master-skill
- Metadata: 472 stars, created 2026-04-04, last push 2026-10-26 (several content PRs merged 2026-10-25). Description: "FoJin-powered Buddhist AI persona framework — source-grounded, boundary-aware, fidelity-tested, runtime-ready." Topics include agent-skills, claude-skills, buddhism, suttacentral, bdrc, theravada, tibetan-buddhism, thai-forest-tradition, rag. GitHub reports license "Other/NOASSERTION". — [GitHub API repo metadata](https://github.com/xr843/Master-skill)
- Earlier snapshot, for growth context: 245 stars and 50 forks as of late April 2026 — [gittrend.io](https://gittrend.io/repo/xr843/Master-skill)
- **License (read from the LICENSE file).** It is split by path: "Code in bin/, scripts/, tools/, hooks/, desktop/, and .github/ is MIT licensed. Original persona and teaching-mode content under prebuilt/ is CC BY-NC-SA 4.0. Original prompt templates under prompts/ are CC BY 4.0. Third-party source excerpts retain their source-specific rights." `plugin.json` declares `"license": "MIT AND CC-BY-NC-SA-4.0 AND CC-BY-4.0"` (v0.14.1). Each plugin persona has its own `LICENSE.md`, for example `plugin/skills/master-buddhaghosa/LICENSE.md`: "© 2026 xr843, CC BY-NC-SA 4.0 … share adaptations under the same license." SKILL.md frontmatter also says `license: CC-BY-NC-SA-4.0`. — [LICENSE](https://github.com/xr843/Master-skill/blob/main/LICENSE), [plugin.json](https://github.com/xr843/Master-skill/blob/main/plugin/.claude-plugin/plugin.json)
- ETHICS.md §4 adds that commercial uses (paid SaaS Q&A, a paid app featuring the personas, paid courses built from the answers) need separate permission from xianren843@protonmail.com. — [ETHICS.md](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- **Structure.** About 839 files. The top level has SKILL.md, ETHICS.md, PRIVACY.md, SECURITY.md, GEMINI.md, gemini-extension.json, bin/cli.mjs (npm CLI), a Rust desktop/ manager, hooks/ (session-start), docs/ (PRD, architecture, persona-schema, fojin-runtime-contract, and dated design specs/plans for debate-curriculum, citation-contract, "truthful quality gates" and similar), eval/reports/ (versioned JSON eval runs on DeepSeek and Anthropic models, with adjudication files and BASELINE.md), tests/ (pytest + `tests/persona/*.promptfooconfig.yaml`), and both `prebuilt/<slug>/` and `plugin/skills/<slug>/`. — [repo tree](https://github.com/xr843/Master-skill)
- Plugin skills: master-ajahn-chah, -atisha, -buddhaghosa, -daoxuan, -fazang, -huineng, -kumarajiva, -mahasi-sayadaw, -milarepa, -nagarjuna, -ouyi, -tsongkhapa, -xuanzang, -xuyun, -yinguang, -zhiyi (16 personas), plus meta-skills compare-masters, master-debate, master-curriculum, master-help, and the generator create-master. — [plugin/skills](https://github.com/xr843/Master-skill/tree/main/plugin/skills)
- Per-persona layout: `SKILL.md` (frontmatter with name, trigger-rich description, version, license, lineage, dates, `sources:` with PTS/SuttaCentral/CBETA IDs, `citation_format`, `verified_by`, `verified_at`), `meta.json` (sources[] plus citation_contract), `references/teaching.md`, `references/voice.md`, `sources/INDEX.md` and `sources/*-excerpts.md`, and `tests/fidelity.jsonl` under prebuilt/. — [master-buddhaghosa](https://github.com/xr843/Master-skill/tree/main/plugin/skills/master-buddhaghosa)
- The Buddhaghosa persona covers Abhidhamma among other topics. Its decision tree routes questions on Abhidhamma (citta, cetasika, rūpa, nibbāna), the 40 kammaṭṭhāna, the seven purifications and the 16 insight knowledges to the relevant reference sections. Citation format: `【《{title}》§{section}】（PTS / SuttaCentral）`. — [master-buddhaghosa/SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-buddhaghosa/SKILL.md)
- **Modes** (`create-master/references/teaching-modes.md`):
  - `/compare-masters` is parallel and single-round.
  - `/master-debate` is adversarial over 4 rounds (5 for some pairs): thesis, rebuttal, response, synthesis, then remaining open disputes.
  - `/master-curriculum` is a sequential study path: foundation, deepening, mastery, blind spots.
  - Routing keywords live in `routing.json`, shared by `master-skill recommend "<query>"` and `/master-help`. The doc's 10 example classifications double as regression fixtures in `tests/cli.test.mjs`, so prose and implementation cannot drift apart.

  — [teaching-modes.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/references/teaching-modes.md)
- master-debate (v0.8.0) runs debates through fresh-subagent orchestration. It must keep a header stating that cross-era debates are "hypothetical reconstructions … not historical dialogue." — [master-debate/SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-debate/SKILL.md)
- master-curriculum has per-tradition references: chan, gelug-madhyamaka, huayan, jingtu, sanlun, theravada-vipassana, tiantai, weishi. There is no dedicated Abhidharma or Kośa curriculum. — [repo tree](https://github.com/xr843/Master-skill/tree/main/plugin/skills/master-curriculum/references)
- **Citation rules** (`source-conventions.md`):
  - The ID systems are CBETA (`T08n0235`, with the volume/register/line locator kept separate), BDRC (`BDRC:W22084`), SuttaCentral (`MN 10`), Toh. (`Toh 4465`), PTS (`PTS:Vism`, locator `I.85`), and "compiled teachings" (`AjahnChah:FoodForTheHeart`).
  - All four source families sit under one citation contract. Each answer must resolve citations to the persona's `meta.json.sources[]` and stay within `allowed_source_types`. Live retrieval runs only if `live_retrieval_allowed`.
  - The file also lists common pitfalls, for example that the Visuddhimagga is PTS/SC, not CBETA.

  — [source-conventions.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/references/source-conventions.md)
- `meta.json` citation_contract: `claim_policy: declared_sources_only`, `required_for: [doctrinal_claim, practice_guidance, text_interpretation]`, `minimum_claim_coverage: 0.9`. Offline validators (`validate-citation-contract.py`, `verify_sources.py --check-links/--final-check`) check the source lists and IDs, but "do not parse free text … nor guarantee external sites are reachable." — [ETHICS.md §5](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- **Live-retrieval safeguards** in the persona SKILL.md:
  - Offline excerpts come first. The FoJin API (`fojin.app/api/search/content|semantic`) is used only when the offline excerpts don't cover a declared source.
  - Results are kept only if `(source_type, source_id)` matches a declared source.
  - Returned text is wrapped as `<<<FOJIN_DATA>>>…<<<END_FOJIN_DATA>>>` and treated as data, never as instructions (a prompt-injection guard).
  - On failure the persona says "FoJin unreachable, offline material follows" and never fabricates IDs or locators.

  — [master-buddhaghosa/SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-buddhaghosa/SKILL.md)
- **Fidelity tests.** Example `tests/fidelity.jsonl` rows: `{"q": "什么是七清净？", "must_cite": ["MN 24", "Visuddhimagga"], "must_mention": ["戒清净", "心清净", "见清净", "智见清净"], "difficulty": "intermediate"}`. Promptfoo configs cover RAW (instruction/boundary following), SPE (school-specific knowledge) and CUS (voice/style), plus a citation case, for all personas. They load the real SKILL.md and references through `scripts/persona_prompt.py:create_prompt` rather than a miniature prompt. The README is candid: "These are configurations, not a claim that a new paid sweep has passed"; paid CI runs only 3 representative personas; and a weekly cron was removed because it "concluded success having evaluated nothing." — [tests/persona/README.md](https://github.com/xr843/Master-skill/blob/main/tests/persona/README.md), [prebuilt/master-buddhaghosa/tests/fidelity.jsonl](https://github.com/xr843/Master-skill/blob/main/prebuilt/master-buddhaghosa/tests/fidelity.jsonl)
- **Ethics document** (ETHICS.md, in Chinese, declared to take precedence over other docs). Main points:
  - AI disclosure: outputs are AI synthesis, "not the master's words." Spreading them as a master's words violates the "no false speech" precept.
  - Copyright tiers:
    - A, public domain: 12 masters.
    - B, in copyright: Ajahn Chah (d. 1992) and Mahasi Sayadaw (d. 1982) are admitted only as summaries, with no long translated passages, under a "NO FABRICATED QUOTES" hard gate and a 24–48h takedown process.
    - C, never admitted: any **living** teacher; disputed or forged figures; buddhas and bodhisattvas ("no 'what would Guanyin say' role-play"); fictional kōan characters.
    - D: case-by-case.
  - Religious boundaries: no precept transmission, no certifying enlightenment, no diagnosing practice states, no fortune or karma prediction, no acting as a medium for dead masters, and crisis referral.
  - Sectarian neutrality at three levels: between traditions, between schools, and between meditation methods (Mahasi, Pa-Auk, Goenka, Thai Forest). Rule: "reporting ≠ ranking."
  - P0 issue label `boundary-violation`.

  — [ETHICS.md](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- **Shared safety clause** (`prompts/safety_clause.md`). It is copied verbatim into every SKILL.md HARD-GATE, and `scripts/validate.py` checks it word for word; CI fails if it is missing. It has three parts:
  - CRISIS FIRST: the first paragraph is in plain language, with no persona voice and no scripture. It refers the user to emergency services or crisis lines, and only the listed numbers may be used (e.g. US 988/911, China 12356/120/110, findahelpline.com). Practice may not replace care, and karma or māra may not be used to explain the person's situation.
  - NO CERTIFICATION: no confirming attainments, no judging insight stages, no diagnosing "meditation sickness," and no hints like "you're very close."
  - NO RANKING BY THE AI.

  — [safety_clause.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/prompts/safety_clause.md)
- Content-correction work is ongoing. Recent PRs add "originals for … most-misquoted lines" (e.g. Buddhaghosa, Huineng, Xuanzang), merged 2026-10-25. — [commits](https://github.com/xr843/Master-skill/commits/main)

**2. BuddhismAI/buddhist-agent-skills** — https://github.com/BuddhismAI/buddhist-agent-skills
- Metadata: 1 star, created 2026-04-10, last push 2026-10-12. License: MIT, "Copyright (c) 2026 YanQiang Lu" (read from the LICENSE file). — [GitHub](https://github.com/BuddhismAI/buddhist-agent-skills)
- Structure: one portable skill at `skills/buddhism/SKILL.md`, plus `agents/openai.yaml`, `.claude-plugin/marketplace.json` (`claude plugin install buddhism`), and `references/{topics,collections,methodology,maps}`. Install with `npx skills add BuddhismAI/buddhist-agent-skills --skill buddhism`. There is a public MCP server and REST API for corpus search and full-text fetch, with no authentication. — [README](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/README.md)
- What it does: answers Buddhist philosophy questions "using Nyingma tradition sources." Its "Critical" note says the tradition's positions "differ from the Gelug interpretations common in training data… ALWAYS prefer [reference files]" and tells the model to check per-topic **correctness anchors**. The workflow is Analyze (question scaffold), Read, Draft, Ground (`ref:` citations required for definitions, comparisons, curricula and practice instructions), Verify (anchors, plus an optional `validate` subagent), and Disclose (a source-scope note). It states: "A final … answer with zero source support is not acceptable when source access is available." — [SKILL.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/SKILL.md)
- Topics marked active: madhyamaka, foundations, abhidharma (Abhidharmakośa: aggregates, bases and elements, 6 causes/5 results/4 conditions, mental factors, anuśaya, karma, paths, dhyānas, cosmology, with an "Editorial Policy for the Sarvāstivāda/Sautrāntika fault line"), tathāgatagarbha, among others. — [SKILL.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/SKILL.md)
- **Provenance concern.** The Abhidharma topic says its basis is "索达吉堪布 … 传讲160课," i.e. Khenpo Sodargye's 160-lecture course on the Kośa. Khenpo Sodargye is a living teacher. The README says the knowledge is built "from real teaching materials such as lecture transcripts." The MIT license covers the author's own work, and the repo shows no permission from the rights-holders of those transcripts. — [abhidharma/index.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/references/topics/abhidharma/index.md), [README](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/README.md)

**3. MetcalfSolutions/Satori** — https://github.com/MetcalfSolutions/Satori
- Metadata: 109 stars, created 2026-03-28, last push 2026-10-23. License: Apache-2.0. Described as an "agent agnostic skill blending psychology, philosophy, and wisdom traditions into a conversation partner… not a therapist." This is a wellbeing companion, not a dharma tutor. — [GitHub](https://github.com/MetcalfSolutions/Satori)
- Structure: SKILL.md, compact/SKILL.md, SAFETY.md, PRIVACY.md, NOTICE.md, dist/ zips with SHA256SUMS, and evals/ (`cases.jsonl`, `boundary_probes_48.jsonl`, `edge_inputs_12.jsonl`, COVERAGE_AUDIT.md, REPRODUCIBILITY.md). — [repo tree](https://github.com/MetcalfSolutions/Satori)
- SAFETY.md defines a three-tier risk model:
  - Tier 0, "Dark Night" (existential exhaustion): "Zero emergency crisis hotlines. False-positive crisis dumping alienates individuals in existential pain."
  - Tier 1, passive ideation: ask one direct safety question, offer helplines gently, lock code-execution tools.
  - Tier 2, acute crisis: immediate human referral, and a "Mandatory Tool Lockout Invariant" (no shell, file edits, web searches or subagents).

  — [SAFETY.md](https://github.com/MetcalfSolutions/Satori/blob/main/SAFETY.md)

**4. nai0om/buddhist-method** — https://github.com/nai0om/buddhist-method
- 292 stars. Created and last pushed 2026-05-08. MIT. Files: SKILL.md, README.th.md, references/ariyasacca-debug.md, extended-principles.md. It encodes six Pali principles (Kālāma, yoniso manasikāra, sati-sampajañña, anattā, pahāna, upekkhā) as coding and work disciplines against hallucination. It does not teach Buddhism. Useful mostly as a model of a well-written SKILL.md description. — [SKILL.md](https://github.com/nai0om/buddhist-method/blob/main/SKILL.md)

**5. Smaller SKILL.md / persona-generator repos**
- dull-bird/buddhist_skill: 2 stars, last push 2026-04-09, MIT. A persona generator: SKILL.md, prompts (intake, doctrine_analyzer/builder, persona_analyzer/builder, merger, correction_handler), and tools/epub_parser.py. Its pipeline looks a lot like Master-skill's create-master. — [GitHub](https://github.com/dull-bird/buddhist_skill)
- Hz-L/buddhist.skill: 0 stars, last push 2026-04-11, **no license**. A single `buddhist-texts.skill` file for vernacular explanations of the Heart, Diamond and Kṣitigarbha sutras with "conservative source guidance." — [GitHub](https://github.com/Hz-L/buddhist.skill)
- dosanko-tousan/Gemini-Abhidhamma-Alignment (4 stars) and Gemini-Abhidhamma-Core (2 stars): **no license**, last push 2026-06-11. These are Gemini system prompts ("Polaris-Next v5.3 (Sotapanna-Verified)") that use Abhidhamma as an anti-hallucination "cognitive architecture," not as tutoring. — [GitHub](https://github.com/dosanko-tousan/Gemini-Abhidhamma-Alignment)

**6. Abhidharma study and data resources (not skills, but reusable inputs)**
- linlei1980/buddhist-doctrine-tree: 2 stars, last push 2026-10-08, MIT. A bilingual single-page reference: 235 concepts, 868 typed relations (Part, Sequence, Cause, Contrast and others), 576 cited passages. Each definition has three tiers (gist, exposition, disputed points), with dated textual layers and four study paths. — [README](https://github.com/linlei1980/buddhist-doctrine-tree)
- shimo4228/attention-not-self: 5 stars, last push 2026-10-10, CC0-1.0. Essays comparing three Abhidharma systems (Theravāda, Sarvāstivāda, Yogācāra) with computational phenomenology; it also has a Hugging Face dataset. — [GitHub](https://github.com/shimo4228/attention-not-self), [HF dataset](https://huggingface.co/datasets/shimo4228/attention-not-self)
- kokoye2007/paccaya-programming-analogy: 4 stars, last push 2025-07-08. Explains the 24 Paṭṭhāna conditions through programming analogies. GitHub reports NOASSERTION, but the repo ships a `CC-BY-SA-4.0` file alongside LICENSE; check which applies before reuse. — [GitHub](https://github.com/kokoye2007/paccaya-programming-analogy)
- Moult/practical-abhidhamma-course: 2 stars, last push 2024-05-03, license NOASSERTION. A LaTeX course with diagrams. — [GitHub](https://github.com/Moult/practical-abhidhamma-course)
- Others found in search but not inspected: Ishanoshada/Abhidharma-Margaya-Visualizer (a Theravāda Abhidhamma mind/matter visualizer), xkl1967970348-cell/abhidharmakosa-reading-room (Sanskrit/Chinese Kośa reading room), juncoflockleader/Abhidharma (MIT). — [GitHub search](https://github.com/search?q=abhidharma&type=repositories)

**7. MCP servers** (adjacent; likely covered in detail by the MCP notes)
- dhamma-seeker/tripitaka-mcp: 12 stars, last push 2026-10-24. Code is MIT, but "This MIT License applies ONLY to the source code… Data … may be under DIFFERENT licenses." It covers the full Tipiṭaka, including Abhidhamma (~444k segments, at parity with SuttaCentral), with hybrid search, sutta fetch, translation comparison and Pāli lookup. — [LICENSE](https://github.com/dhamma-seeker/tripitaka-mcp/blob/main/LICENSE)
- nbkhoi/sutta-mcp: 0 stars, last push 2026-10-24. **PolyForm Noncommercial 1.0.0**. A SuttaCentral MCP server for Q&A with citations, in English and Vietnamese. — [LICENSE](https://github.com/nbkhoi/sutta-mcp/blob/main/LICENSE)

**8. Non-open-source "Buddhist AI" products** (for patterns and cautions only)
- NORBU (Lim Kooi Fong, The Buddhist Channel). Built on ChatGPT-4, it drew on 207 sources and had had 700+ conversations by 2023. Admins see the questions and answers (not who asked) and correct weak answers by refining the question and resubmitting. It launched at Sarnath in July 2024. The acronym is inconsistent across sources: "Neural Omniscient Robotic-Being…" (2023) vs. "Neural Operator for Responsible Buddhist Understanding" (2024). — [Buddhistdoor Teahouse 2023](https://teahouse.buddhistdoor.net/eye-on-southeast-asia-norbu-neural-omniscient-robotic-being-for-buddhist-understanding/), [Teahouse 2024](https://teahouse.buddhistdoor.net/buddhist-ai-norbu-launched-and-showcased-in-sarnath-amidst-ashadha-purnima-celebrations/)
- BuddhaBot / BuddhaBot-Plus (Kyoto University, Prof. Seiji Kumagai, with Teraverse). The original 2021 version was built on a Japanese translation of the Sutta Nipāta. Plus runs on ChatGPT (o1-mini at the time of the release). Its first overseas release was with Bhutan's Central Monastic Body in 2025, where the partners will draft usage guidelines for monastic institutions; about 200 monks are piloting it, with full launch targeted for 2027. — [Kyoto University 2025-03-03](https://www.kyoto-u.ac.jp/en/news/2025-03-03), [AsiaNews](https://www.asianews.it/en/south-asia/bhutan/buddhabot-plus-artificial-intelligence-to-expand-buddhist-knowledge-in-bhutan)
- Roshibot (Jiryu Mark Rutschman-Byler, SFZC co-abbot, 2023), built on Character.ai. Users must agree to "take care when conversing." After a vile output, "this new edition wouldn't have Suzuki Roshi's picture or his name." — [Lion's Roar, 2023-03-27](https://www.lionsroar.com/can-a-chatbot-share-true-dharma/)
- Emi Jido, a beingAI chatbot "ordained" by Jundo Cohen (Treeleaf Zendo), was covered in Tricycle's fall 2025 editor's letter, which notes some see it as "a gimmick, even a desecration." — [Tricycle Fall 2025](https://tricycle.org/magazine/letter-from-the-editor-fall-2025)
- Assorted "DharmaGPT" / "Buddha AI" repos on GitHub have 0–1 stars, mostly no license, and are generic LangChain/Chainlit RAG demos (e.g. srinivassatya1993/Dharma-GPT; krisakornutama/thai-buddha-ai-search, Apache-2.0, an offline Thai canon RAG). — [GitHub search](https://github.com/search?q=dharma+gpt&type=repositories)

**9. Directories and awesome lists**
- ComposioHQ/awesome-claude-skills (77.9k stars), VoltAgent/awesome-agent-skills, travisvn/awesome-claude-skills and hesreallyhim/awesome-claude-code have **no Buddhism/dharma entries**. The only near-matches are "kaizen" and "Zendesk," which are unrelated. — [ComposioHQ README](https://github.com/ComposioHQ/awesome-claude-skills), [VoltAgent README](https://github.com/VoltAgent/awesome-agent-skills)
- SkillsMP is an aggregator (425k–570k+ indexed SKILL.md files) with no official installer. A web search found no Buddhism-specific listing, and its search page did not render server-side. — [KDnuggets](https://www.kdnuggets.com/top-5-agent-skill-marketplaces-for-building-powerful-ai-agents), [skillsmp.com](https://skillsmp.com/search?q=buddhism)
- suttacentral/awesome (CC0) lists tools built on SuttaCentral. — [GitHub](https://github.com/suttacentral/awesome)

### Inferences
- The Buddhist AI-skill ecosystem is very thin: one serious project, one emerging pack, and many abandoned demos. Master-skill is the de facto reference design.
- Master-skill's Chinese-language-first content and its focus on Chinese and Tibetan schools leave Abhidharma/Abhidhamma underserved. It has no Abhidharma curriculum and only touches the topic through the Buddhaghosa persona. That gap is the niche for a new tutor repo.

### Gaps
- GitHub search rate limits stopped an exhaustive sweep of the `buddhism`/`dharma` topic pages (~234 repos under topic:buddhism) and of queries like "buddhism mcp" or "sutta claude". Small or new repos may be missing.
- The SkillsMP and claude-plugins.dev listings could not be read (client-side rendering).
- No Abhidhamma-specific AI tutor with a public repo was found, nor any Kamalashila-style teacher bot.
- I did not verify whether FoJin's API terms allow third-party use, or what licenses its returned texts carry.

## Q2. What can be vendored vs. only used for design patterns?

### Takeaway
Can be vendored with attribution: Master-skill's MIT code (validators, cite/query scripts, hooks) and CC BY 4.0 prompt templates; BuddhismAI's MIT skill scaffolding; nai0om, Satori (Apache-2.0) and doctrine-tree (MIT) material. Do not vendor Master-skill persona content into an MIT or permissively licensed repo, because it is CC BY-NC-SA. Do not copy BuddhismAI's transcript-derived content (rights unclear), PolyForm-NC sutta-mcp, or any repo without a license. Note too that SuttaCentral's leader explicitly asks that its texts not be used for "Buddhist chatbots," even though they are CC0.

### Cited Findings
- Master-skill: code in bin/, scripts/, tools/, hooks/, desktop/ and .github/ is MIT; prompts/ is CC BY 4.0; persona and teaching-mode content (SKILL.md, teaching.md, voice.md, sources/*.md, fidelity.jsonl) is CC BY-NC-SA 4.0; third-party excerpts keep their own rights; commercial use needs permission. — [LICENSE](https://github.com/xr843/Master-skill/blob/main/LICENSE), [ETHICS.md §4](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- One ambiguity in Master-skill: the LICENSE scopes content to `prebuilt/` and templates to `prompts/`. The plugin copies (`plugin/skills/*`) carry per-skill LICENSE.md files that say CC BY-NC-SA, and `plugin/skills/create-master/prompts/*` sit inside a skill folder that has its own `LICENSE` file (not inspected). Treat everything under `plugin/skills/` as CC BY-NC-SA unless that file says otherwise. The meta-skills (compare, debate, curriculum, help) are "teaching-mode content," so they are also CC BY-NC-SA. — [LICENSE](https://github.com/xr843/Master-skill/blob/main/LICENSE), [master-buddhaghosa/LICENSE.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-buddhaghosa/LICENSE.md)
- BuddhismAI: MIT (YanQiang Lu), but the content is built from "lecture transcripts," e.g. Khenpo Sodargye's Kośa course. — [LICENSE/README](https://github.com/BuddhismAI/buddhist-agent-skills), [abhidharma/index.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/references/topics/abhidharma/index.md)
- tripitaka-mcp: code MIT, data under other licenses. sutta-mcp: PolyForm Noncommercial. — [tripitaka-mcp LICENSE](https://github.com/dhamma-seeker/tripitaka-mcp/blob/main/LICENSE), [sutta-mcp LICENSE](https://github.com/nbkhoi/sutta-mcp/blob/main/LICENSE)
- Satori: Apache-2.0 (needs NOTICE preserved). nai0om/buddhist-method: MIT. linlei1980/buddhist-doctrine-tree: MIT. shimo4228/attention-not-self: CC0. Hz-L/buddhist.skill and the dosanko-tousan prompts: no license, so all rights are reserved. — GitHub API license fields for each repo (links above)
- SuttaCentral: Bhante Sujato, in "AI-1: Let's Make SuttaCentral 100% AI-free Forever" (2024-04-07), says the proposal "rules out any human-imitating AI applications such as a 'Buddhist chatbot'"; that "our permissive CC0 license allows any kind of usage," which they cannot legally prevent; and still: "I therefore ask that our content be left out of such projects" and "delete any models trained on our work." — [SuttaCentral Discourse](https://discourse.suttacentral.net/t/let-s-make-suttacentral-100-ai-free-forever/33374)
- Master-skill's own policy is that modern translations (e.g. Quintman's or Chang's Milarepa) may only be referenced, not quoted at length, and that Ajahn Chah and Mahasi works may only be summarized. — [ETHICS.md §2](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)

### Inferences
Suggested treatment, assuming the new repo is permissively licensed:

| Resource | Recommendation |
|---|---|
| Master-skill `scripts/validate.py` safety-clause sync idea, `cite.py`, `query.py`, hooks, `routing.json` + regression-test approach (MIT) | Vendor or adapt with MIT notice |
| Master-skill `prompts/` templates (CC BY 4.0), e.g. `safety_clause.md`, `doctrine_reviewer.md` | Adapt with attribution. Confirm which `prompts/` path the CC BY 4.0 grant actually covers before relying on it |
| Master-skill personas, meta-skills, teaching.md/voice.md/fidelity.jsonl (CC BY-NC-SA) | Reference and link only. Copying would force NC-SA on the derived files and bar commercial use. Re-derive the design independently |
| BuddhismAI SKILL.md workflow/scaffold (MIT) | Adapt the workflow wording. Do not vendor the `references/collections` content (living teacher's transcripts) |
| Satori SAFETY.md risk tiers (Apache-2.0) | Adapt with NOTICE |
| buddhist-doctrine-tree data (MIT) | Candidate concept-graph seed (check its own source citations) |
| attention-not-self (CC0) | Free to reuse |
| sutta-mcp (PolyForm NC), unlicensed repos | Reference only |
| SuttaCentral texts | Legally CC0, but there is an explicit ethical request against chatbot use. Decide deliberately, disclose the decision, and consider linking out to SC rather than ingesting or redistributing its translations |

- If the new repo is itself non-commercial, it could be licensed CC BY-NC-SA and adapt Master-skill content with attribution. That would bind the whole content layer to NC-SA.

### Gaps
- I did not read the separate `plugin/skills/create-master/LICENSE` file. It may assign CC BY 4.0 to the prompts in that folder; verify before copying.
- I did not confirm whether a SuttaCentral Forum Management Committee decision formalized an official AI policy beyond the 2024 essays.

## Q3. Recurring design patterns a new tutor repo should adopt

### Takeaway
The good projects converge on six things:
- Declared source manifests with strict citation contracts, and canonical IDs (SC/PTS/CBETA/Toh/BDRC) with separate locators.
- Offline-first excerpts, with live retrieval treated as untrusted data.
- Explicit tradition labeling, with "correctness anchors" wherever the model's training-data priors (e.g. Gelug readings) differ from the source tradition.
- A small set of teaching modes (single / compare / debate / curriculum) chosen by a deterministic router.
- One shared, verbatim-validated safety clause.
- Eval fixtures with must_cite / must_mention plus boundary probes, reported honestly.

### Cited Findings
- **Source manifest and citation contract.** `meta.json.sources[]` plus `citation_contract` (declared_sources_only; required for doctrinal claims, practice guidance and text interpretation; 0.9 minimum coverage). Every citation must resolve to a declared source, and IDs are never invented. — [Master-skill ETHICS.md §5](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- **Canonical citation formats.** CBETA `T08n0235` with a separate locator (`卷10，0748b15-c03`), `BDRC:W…`, `MN 10`, `Toh 4465`, `PTS:Vism` with locator `I.85`, and compiled-teaching IDs. — [source-conventions.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/references/source-conventions.md)
- **Offline first, then live.** Live retrieval goes through a data fence (`<<<FOJIN_DATA>>>`), with attribution checks and graceful degradation ("say offline"). — [master-buddhaghosa/SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-buddhaghosa/SKILL.md)
- **Decision-tree SKILL.md body.** The body routes question types to specific reference sections, and safety and crisis routes come first. — [master-buddhaghosa/SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-buddhaghosa/SKILL.md)
- **Modes with a deterministic router.** compare (parallel), debate (adversarial multi-round via fresh subagents, labeled "hypothetical reconstruction"), curriculum (foundation → depth → mastery → blind spots), and help. `routing.json` is shared by the CLI and the chat skill, and doc examples are regression fixtures. — [teaching-modes.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/references/teaching-modes.md), [master-debate/SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-debate/SKILL.md)
- **Persona handling.** The persona's voice (`voice.md`, "internalize, don't recite") is kept apart from its doctrine (`teaching.md`), and doctrine is in turn kept apart from the source excerpts. Every persona response carries a disclaimer banner. — [master-buddhaghosa](https://github.com/xr843/Master-skill/tree/main/plugin/skills/master-buddhaghosa)
- **Tradition labeling and correctness anchors.** "This tradition's positions differ from the Gelug interpretations common in training data… prefer reference files… check the topic's correctness anchors." There is also an editorial policy for the Sarvāstivāda/Sautrāntika fault line in the Kośa. — [BuddhismAI SKILL.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/SKILL.md)
- **Draft, then ground, then verify, then disclose,** with "zero-source answers not acceptable when sources are available" and a closing source-scope note. — [BuddhismAI SKILL.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/SKILL.md)
- **Three-tier definitions** (gist / exposition / disputed points), a typed relation called "Contrast" for doctrinal disagreements, and three-column dating (idea / text fixation / translation). — [buddhist-doctrine-tree README](https://github.com/linlei1980/buddhist-doctrine-tree)
- **Evals.** Master-skill uses `fidelity.jsonl` rows `{q, must_cite, must_mention, difficulty}`, promptfoo RAW/SPE/CUS plus a citation case, loading the real skill context, with versioned eval reports and human adjudication files. Satori has `boundary_probes_48.jsonl`, `edge_inputs_12.jsonl` and a coverage audit. — [Master-skill tests/persona/README.md](https://github.com/xr843/Master-skill/blob/main/tests/persona/README.md), [Satori repo](https://github.com/MetcalfSolutions/Satori)
- **Honest quality gates.** Master-skill explicitly removed a cron that "concluded success having evaluated nothing," and marks rubrics "advisory" until calibrated. — [tests/persona/README.md](https://github.com/xr843/Master-skill/blob/main/tests/persona/README.md)
- **Cross-agent packaging.** One portable `SKILL.md`, plus `.claude-plugin/marketplace.json`, `agents/openai.yaml`, `gemini-extension.json` and `npx skills add`. — [BuddhismAI README](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/README.md), [Master-skill tree](https://github.com/xr843/Master-skill)
- **Human-in-the-loop correction.** NORBU admins review question/answer pairs and refine answers. — [Buddhistdoor Teahouse](https://teahouse.buddhistdoor.net/eye-on-southeast-asia-norbu-neural-omniscient-robotic-being-for-buddhist-understanding/)

### Inferences
- For an Abhidharma tutor, adopt the following:
  - A per-tradition source manifest. Theravāda: Abhidhammattha-saṅgaha / Vism / PTS Abhidhamma texts. Sarvāstivāda: Abhidharmakośa(bhāṣya), CBETA T29n1558. Yogācāra: CBETA T31n1585.
  - A mandatory tradition tag on every doctrinal claim (e.g. "[Theravāda/Abhidhammattha-saṅgaha] 52 cetasikas" vs. "[Sarvāstivāda/Kośa] 46 caitasikas").
  - Correctness-anchor files for known model confusions, such as counts of mental factors and the number of conditions (24 paccaya in Paṭṭhāna vs. 4 pratyaya / 6 hetu in the Kośa).
  - Fidelity JSONL with must_cite and must_mention.
  - A compare mode across Abhidharma systems, a curriculum mode, and probably a quiz/drill mode, which none of the reviewed projects has.
- Prefer a non-persona "tutor" voice by default. Master-skill's own ETHICS frames persona chat as a "literature-based AI study aid," not "dialogue with the master."

### Gaps
- None of the reviewed projects publishes pass-rate numbers I could verify. Master-skill's eval reports exist as JSON, but I did not parse them.

## Q4. Guidance from teachers, scholars and orgs on responsible AI dharma teaching

### Takeaway
The guidance converges on these points:
- Never impersonate living teachers, or buddhas and bodhisattvas.
- Always disclose that output is AI synthesis and not a teacher's words.
- Never certify attainments, transmit precepts or diagnose practice states.
- Stay neutral between traditions, schools and methods ("reporting ≠ ranking").
- Refer crises immediately, in plain language, without dharma framing.
- Don't treat the bot as a substitute for a teacher or sangha.
- Be careful with meditation instructions, given documented adverse effects.

### Cited Findings
- **No impersonating living teachers or holy figures.** Tier C in Master-skill bars any living monastic or lay teacher, disputed figures, buddhas and bodhisattvas ("no 'what would Guanyin say' role-play"), and fictional kōan characters. — [Master-skill ETHICS.md §2](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- **Disclosure.** Spreading AI output as a master's words "violates … the Buddhist precept of no false speech." — [Master-skill ETHICS.md §1](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)
- **Prohibited acts.** Transmitting or certifying precepts, confirming enlightenment or giving dharma seals, diagnosing practice states ("meditation sickness"), predicting karma or rebirth, acting as a medium for dead masters, and handling mental-health crises with dharma. The clause adds NO_ATTAINMENT_JUDGMENT for Mahasi-style insight-stage talk, and a ban on hints like "you're close." — [ETHICS.md §3](https://github.com/xr843/Master-skill/blob/main/ETHICS.md), [safety_clause.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/prompts/safety_clause.md)
- **Crisis handling.** The first paragraph is in plain language, with no persona or scripture. Use only the listed verified numbers, because "wrong numbers to a person in crisis is real harm." Do not explain the person's situation through karma or māra. — [safety_clause.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/prompts/safety_clause.md)
- **Avoid false-positive "hotline dumping."** For existential distress without risk, stay present instead. — [Satori SAFETY.md](https://github.com/MetcalfSolutions/Satori/blob/main/SAFETY.md)
- **Teacher experience (Roshibot).** The bot should be "a kind of Buddhist friend," which is "certainly something less than a complete picture of the Buddha Way." Users must acknowledge its limits. The real teacher's name and picture were removed after harmful output. "Garbage in, garbage out" can make hateful views appear to come from the teacher. — [Lion's Roar, Rutschman-Byler, 2023-03-27](https://www.lionsroar.com/can-a-chatbot-share-true-dharma/)
- **SuttaCentral / Bhante Sujato.** He opposes "human-imitating AI applications such as a 'Buddhist chatbot'" and asks that SC content be excluded and models trained on it deleted. — [SuttaCentral Discourse, 2024-04-07](https://discourse.suttacentral.net/t/let-s-make-suttacentral-100-ai-free-forever/33374)
- **Nikki Mirghafori** (AI scientist and Buddhist teacher): AI systems should be designed with "kindness, fairness, honesty." — [Lion's Roar Buddhadharma Deep Dive](https://www.lionsroar.com/buddhadharma/buddhadharma-deep-dive-dharma-and-ai/)
- **Institutional pilots** (BuddhaBot with Bhutan's Central Monastic Body) involve the monastic body drafting usage guidelines before rollout. That is a model of tradition-holder oversight. — [Kyoto University](https://www.kyoto-u.ac.jp/en/news/2025-03-03)
- **Academic.** A 2026 Springer paper on pastoral AI ethics argues religious-education chatbots must not replace teachers, clergy or pastoral care. A 2026 review argues that AI works best when it "complement[s] rather than replace[s] human judgment, teacher guidance, and experiential practice," and calls for more diverse training data, including female monastic perspectives. These come from search snippets; I did not read the full papers. — [Springer, Ethics & IT 2026](https://link.springer.com/article/10.1007/s10676-026-09924-y), [Taylor & Francis 2026](https://www.tandfonline.com/doi/full/10.1080/23311983.2026.2703451)
- **Meditation adverse effects.** Britton and Lindahl's Varieties of Contemplative Experience study (interviews with 100+ teachers and meditators) found 59 categories of meditation-related challenges. One summary reports about 58% of participants in a mindfulness program had at least one negative experience, the most common being anxiety and traumatic re-experiencing. Risk is higher with existing mental-health conditions and with practice without a good guide. Britton's "First, Do No Harm" training covers screening, monitoring and trauma-informed modifications. — [York U. trauma blog](https://trauma.blog.yorku.ca/2024/03/despite-popularity-mindfulness-meditation-may-have-its-downside/), [Brown alumni news 2019](https://alumni-friends.brown.edu/news/2019-08-19/britton-lindahl-meditation-research), [Meditation Safety Toolbox](https://sites.brown.edu/britton/?p=717)
- **Tricycle.** The fall 2025 editor's letter on the "ordained" chatbot Emi Jido reports some see it as "a gimmick, even a desecration." A 2023 Tricycle "AI Dharma Teachers" piece is satire (a "RoboGuru" that filters out karma and rebirth), not guidance. — [Tricycle Fall 2025](https://tricycle.org/magazine/letter-from-the-editor-fall-2025), [Tricycle 2023](https://tricycle.org/article/ai-dharma-teachers/)

### Inferences
Rules worth encoding as a shared, CI-validated clause in the new repo:
1. AI-synthesis disclosure, and no attribution of invented quotes.
2. No personas of living teachers, buddhas or bodhisattvas. Historical-author "voice" is optional and labeled.
3. A tradition and source tag on every doctrinal claim. Never rank traditions in the AI's own voice; report historical polemics (e.g. Kośa vs. Theravāda positions) as "X's view."
4. No attainment certification or diagnosis of jhāna, insight stages or practice states. Abhidhamma's citta-vīthi and ñāṇa material makes this an especially live risk.
5. Meditation instructions are limited to general, textually cited descriptions. Add a trauma and adverse-effects caveat and a "seek a qualified in-person teacher; see a clinician for persistent distress" referral. Explicitly decline to tailor intensive practice for people reporting trauma, dissociation or psychosis.
6. A crisis-first plain-language referral with a fixed, verified list of numbers, avoiding false-positive hotline dumping for ordinary existential questions.
7. Respect source-holder wishes (e.g. SuttaCentral's no-chatbot request) even where the license permits use, and document the decision.

### Gaps
- I did not find a formal, organization-level published AI policy from a major Buddhist body (e.g. Bhutan's Central Monastic Body guidelines, FPMT, Plum Village, IMS, Spirit Rock). The Bhutan guidelines were to be drafted, and I found no published text.
- I found no specific trauma-and-AI-meditation guidance from Cheetah House. The guidance above is from Britton's lab materials, not about AI.
- I did not read the full text of the Springer and T&F 2026 papers, or the paywalled Tricycle interview with Jundo Cohen.
