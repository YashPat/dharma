# Wire four public tools, build two

The best setup for a Claude Code Buddhism-tutor repo uses four existing open-source pieces: **the official `mcp-server-fetch`** (the only truly established, high-traffic server in the stack), **dhamma-seeker/tripitaka-mcp** (Pāli canon with quote verification, MIT), **xr843/fojin** (Chinese, Pāli and Tibetan canons with dictionaries and parallels, Apache-2.0), and **xr843/Master-skill** as a skill. Install Master-skill for personal use, or study it as the reference design, but don't vendor it, because its content is CC BY-NC-SA. Only two things need custom work. The first is an Abhidharma tutor skill: no existing pack has an Abhidharma curriculum, correctness anchors, or quiz mode. The second, optional, is a roughly 100-line MCP wrapper for 84000's GraphQL API, which `fetch` cannot call. Keep expectations modest. Every Buddhist-specific server has 1 to 3 contributors and at most a few hundred stars, so "popular" here only means popular within a small niche, and you should pin versions. The biggest decision is ethical, not technical. SuttaCentral's texts are legally CC0, but SuttaCentral explicitly asks that they not be used in generative-AI datasets or "Buddhist chatbots," and tripitaka-mcp is built on exactly that corpus. A tutor repo should make a deliberate, documented choice about this. It should also keep non-commercial sources (DPD, 84000, CBETA) out of committed files, since their licenses forbid commercial use and in 84000's case derivatives.

## The niche has one established server and a handful of serious small ones

Measured against the general MCP ecosystem, nothing Buddhist is popular. The official **modelcontextprotocol/servers** repo has **91,564 stars and 100+ contributors**, and `mcp-server-fetch` had **506,506 PyPI downloads in the last month** ([repo](https://github.com/modelcontextprotocol/servers), [pypistats](https://pypistats.org/packages/mcp-server-fetch)). The most-starred Buddhist MCP project, fojin, has **353 stars and 3 contributors** ([repo](https://github.com/xr843/fojin)). The most-used, tripitaka-mcp, has **12 stars but 1,131 Smithery uses** and 185 PyPI downloads a month ([Smithery](https://smithery.ai/server/dhamma-seeker/tripitaka-mcp), [pypistats](https://pypistats.org/packages/tripitaka-mcp)). Taken literally, "established and popular" admits only `fetch`. A practical reading also admits the two Buddhist servers that are open source, listed in the official MCP registry, and pushed within the last week.

**tripitaka-mcp** covers the full Tipiṭaka: about **444K segments "at parity with SuttaCentral,"** with Sujato's and Brahmali's English for Sutta and Vinaya, and the Abhidhamma in Pāli only. Its hosted endpoint returned **14 tools** in a live `tools/list` probe on 2026-10-26, including `search_hybrid`, `get_sutta`, `compare_translations`, `get_word_definition`, `parse_pali_word` and, most useful for a tutor that must not hallucinate, **`verify_quote`** ([repo](https://github.com/dhamma-seeker/tripitaka-mcp)). The local pipx edition has 11 tools. Semantic and hybrid search are hosted-only because they need Postgres, pgvector and an embedding model of about 1 GB. The hosted server is rate-limited to 60 requests per minute per IP, and its README says queries are not logged. The project is young and has a single maintainer, and the version numbers don't agree (PyPI 1.1.0, registry 1.3.0, live server 4.1.1), so the docs may not match the code.

**fojin** is a thin, read-only client for fojin.app's public API. Its platform covers **10,500+ texts from 613 sources**, including CBETA, SuttaCentral, 84000 (through `84k/toh` URNs) and GRETIL, plus **32 dictionaries** and a knowledge graph ([repo](https://github.com/xr843/fojin), [mcp-server README](https://github.com/xr843/fojin/blob/main/mcp-server/README.md)). A live probe returned 8 tools: `search_corpus, read_passage, get_parallels, lookup_dictionary, lookup_entity, resolve_urn, verify_quote, commentaries`. Even the stdio install depends on fojin.app being online, and the hosted service logs one JSON line per request. For an Abhidharma tutor, fojin is the route to the Sarvāstivāda and Yogācāra side, meaning the Kośa and Yogācāra treatises in CBETA, which tripitaka-mcp does not cover.

The rest of the field is weaker. **sinryo/buddha-cli** (formerly `daizo-mcp`; MIT OR Apache-2.0; Rust) is the only server that holds CBETA, SAT, GRETIL and Tibetan search locally. It has a single author and isn't on crates.io, and its upstream corpora alone exceed 2 GB ([repo](https://github.com/sinryo/buddha-cli)). The **DPD MCP server was "Archived 2026-09-27"** by the dictionary project itself ([README](https://github.com/digitalpalidictionary/dpd-db/blob/main/archive/exporter/mcp/README.md)). The community thiravadhano/DPD-MCP-Server has 1 star, hasn't been pushed since March, and misstates DPD's license ([README](https://github.com/thiravadhano/DPD-MCP-Server)). **nbkhoi/sutta-mcp** is PolyForm Noncommercial, which is not OSI open source ([repo](https://github.com/nbkhoi/sutta-mcp)). **lotus-wisdom-mcp** (36 stars, MIT) is a structured-thinking scaffold that returns no scripture, and its hosted worker records analytics ([repo](https://github.com/linxule/lotus-wisdom-mcp)). The CBETA wrappers tendayspace/CbetaMCP and hiing/CbetaMCP are abandoned or require you to deploy them on Cloudflare yourself. Nothing exists for 84000, Access to Insight, the DDB, or Abhidhamma specifically.

## Raw APIs fill the gaps without custom code, except 84000

Most primary sources answer plain GET requests, so `fetch` can stand in for a dedicated server. The **SuttaCentral JSON API** needs no auth and is cached by Cloudflare for 48 hours. Four endpoints were confirmed live: `/api/bilarasuttas/{uid}/{translator}?lang=en` (segment-aligned Pāli and English), `/api/suttas/{uid}/{translator}` (including legacy translators such as Horner), `/api/suttaplex/{uid}` (metadata and translation list), and `/api/search/instant?query=...` ([live endpoint](https://suttacentral.net/api/bilarasuttas/mn10/sujato?lang=en)). There is no official documentation, so stability is not promised. `/api/dictionary_full/{word}?language=en` returns entries from **DPD, NCPED and PTS** in one call ([live](https://suttacentral.net/api/dictionary_full/sati?language=en)). Point `fetch` at the API rather than at sutta pages, which are a 9 KB JavaScript shell. A bilarasuttas response is about 97 KB, so with `fetch`'s default `max_length` of 5,000 characters, one sutta takes several paginated calls ([fetch README](https://github.com/modelcontextprotocol/servers/tree/main/src/fetch)).

**dpdict.net** exposes an undocumented but public `/search_json?q=` endpoint. Use its roughly 3 KB `summary_html` field and ignore the roughly 330 KB `dpd_html`. The response carries its own license notice: **CC BY-NC-SA 4.0, "Non-commercial use only"** ([live](https://www.dpdict.net/search_json?q=sati), [openapi.json](https://www.dpdict.net/openapi.json)). **CBETA's API** at `cbdata.dila.edu.tw/stable` returns JSON for works, juans, search and KWIC. CJK queries must be URL-encoded ([live](https://cbdata.dila.edu.tw/stable/search/kwic?q=%E5%A6%82%E6%98%AF%E6%88%91%E8%81%9E&work=T0235&juan=1)). Access to Insight and dhammatalks.org serve static HTML that `fetch` reads directly ([ATI MN 10](https://accesstoinsight.org/tipitaka/mn/mn.010.than.html), [dhammatalks MN 10](https://www.dhammatalks.org/suttas/MN/MN10.html)). The DDB is unusable for this purpose: guests get 10 to 20 searches a day ([buddhism-dict.net](http://www.buddhism-dict.net/ddb/), [Digital Orientalist](https://digitalorientalist.com/2021/12/21/online-resources-for-buddhist-studies-and-the-development-of-digital-humanities-past-present-and-future-an-interview-with-charles-muller-editor-of-the-ddb-and-cjkv-e-dictionaries/)). Bhikkhu Bodhi's Nikāya translations are not on SuttaCentral at all: `/api/suttas/mn10/bodhi` returns `translation: null` ([live](https://suttacentral.net/api/suttas/mn10/bodhi?lang=en)).

**84000 is the one source that justifies custom code.** Its public, unauthenticated GraphQL endpoint at `https://graphql.84000.co/api/graphql` answered live queries, reporting **4,250 works** and supporting introspection with `works`, `work`, `passage`, `search` and glossary queries ([84000 docs](https://github.com/84000/docs/tree/main/src/content/graphql)). `fetch` only sends GET requests and cannot POST GraphQL. A thin wrapper with tools such as `list_works`, `get_passage` and `search_glossary` would add English Mahāyāna sūtras translated from Tibetan. Expect some trial and error: test calls to `work(toh:"toh8")` and `search(query:"emptiness")` returned empty results, so the argument formats still need to be worked out. Because 84000 is **CC BY-NC-ND 3.0**, the wrapper should only display and quote passages, never save altered copies ([data-tei](https://github.com/84000/data-tei)).

## Skills: one mature reference design, and an Abhidharma gap you must fill

**xr843/Master-skill** (472 stars, pushed 2026-10-26) is the only mature Buddhist agent-skill project. It is a Claude Code plugin with **16 historical-master personas** plus compare, debate, curriculum and help modes. It has a citation contract (`claim_policy: declared_sources_only`, 0.9 minimum claim coverage), a shared safety clause checked verbatim in CI, and promptfoo fidelity tests with `must_cite`/`must_mention` fixtures ([repo](https://github.com/xr843/Master-skill), [ETHICS.md](https://github.com/xr843/Master-skill/blob/main/ETHICS.md)). Its handling of live retrieval is worth copying. Offline excerpts come first. Results from the FoJin API are fenced as `<<<FOJIN_DATA>>>` and treated as data, never as instructions, which guards against prompt injection. When FoJin is unreachable, the skill says so instead of inventing IDs ([master-buddhaghosa SKILL.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/master-buddhaghosa/SKILL.md)). It also suits Claude Code well, because its personas already cite the source families that tripitaka-mcp and fojin serve: SuttaCentral, PTS, CBETA, Toh and BDRC.

Its license sets the limits on reuse. Code in `bin/`, `scripts/`, `tools/`, `hooks/` and `.github/` is **MIT**. Templates in `prompts/` are **CC BY 4.0**. Persona and teaching-mode content, including the meta-skills, is **CC BY-NC-SA 4.0**, and commercial use needs separate permission ([LICENSE](https://github.com/xr843/Master-skill/blob/main/LICENSE)). In practice, you can install the plugin for your own non-commercial study and adapt its validators and safety-clause mechanism with an MIT notice. Do not copy persona or teaching files into a permissively licensed repo. Two notes are unresolved: the separate `plugin/skills/create-master/LICENSE` file was not read, and the CC BY 4.0 grant may not cover the copies of the prompts inside the plugin. The content is also Chinese-first and centered on Chinese and Tibetan schools. **There is no Abhidharma or Kośa curriculum**; Abhidhamma appears only through the Buddhaghosa persona's routing to citta, cetasika, rūpa and nibbāna ([teaching-modes.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/references/teaching-modes.md)).

**BuddhismAI/buddhist-agent-skills** (MIT, 1 star) is the only other real doctrine skill. It has an active Abhidharmakośa topic and a useful Draft, Ground, Verify, Disclose workflow with "correctness anchors" for places where the model's training priors (for example Gelug readings) differ from the source tradition ([SKILL.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/SKILL.md)). The provenance of its content is a problem. The Kośa material is based on **Khenpo Sodargye's 160-lecture course**, he is a living teacher, and the repo shows no permission from the transcript rights-holders ([abhidharma/index.md](https://github.com/BuddhismAI/buddhist-agent-skills/blob/main/skills/buddhism/references/topics/abhidharma/index.md)). Borrow the workflow wording and leave the content. None of the major skill directories lists anything Buddhist: ComposioHQ's 77.9k-star list, VoltAgent's and the others have no entries ([ComposioHQ](https://github.com/ComposioHQ/awesome-claude-skills)). The popular nai0om/buddhist-method (292 stars) applies Pāli principles to coding discipline and does not teach Buddhism ([SKILL.md](https://github.com/nai0om/buddhist-method/blob/main/SKILL.md)).

That leaves one component you have to write yourself: an Abhidharma tutor skill. Its main parts would be:

- **A source manifest for each tradition.** Theravāda Abhidhamma comes through tripitaka-mcp, which has the Pāli only. The Sarvāstivāda Kośa (CBETA T29n1558) and Yogācāra (T31n1585) come through fojin or the CBETA API.
- **A mandatory tradition tag on every claim.** For example, Theravāda counts 52 cetasikas where the Kośa counts 46 caitasikas, and the Paṭṭhāna's 24 conditions differ from the Kośa's 4 pratyaya and 6 hetu.
- **Fidelity fixtures in JSONL**, following Master-skill's `must_cite`/`must_mention` pattern.
- **A quiz or drill mode.** None of the reviewed projects has one.

Seed material with clean licenses is available: linlei1980/buddhist-doctrine-tree (MIT; 235 concepts, 868 typed relations) and shimo4228/attention-not-self (CC0; compares three Abhidharma systems) ([doctrine-tree](https://github.com/linlei1980/buddhist-doctrine-tree), [attention-not-self](https://github.com/shimo4228/attention-not-self)). Notice that the tools leave a hole: **no open English translation of the Abhidhamma or the Kośa came up in any of these sources**. The tutor's explanations will therefore come from Pāli and Chinese root texts plus your own summaries, and every summary should be labeled as one.

## SuttaCentral's request is about ethics, not law, and it shapes the whole stack

SuttaCentral's licensing text dedicates its original material to the public domain under CC0. It then adds: "We politely request that our content not be scraped or used in any way for the creation of datasets for generative AI or similar. This request applies to those who create applications directly, and those who build apps downstream of AI models" ([SC licensing strings](https://suttacentral.net/localization/elements/licensing_en.json)). Bhante Sujato goes further. He writes that the policy "rules out any human-imitating AI applications such as a 'Buddhist chatbot'," acknowledges that CC0 means "we cannot legally prevent" such uses, and asks that SC content be left out and that models trained on it be deleted ([SuttaCentral Discourse](https://discourse.suttacentral.net/t/let-s-make-suttacentral-100-ai-free-forever/33374)). tripitaka-mcp is built from bilara-data and serves an embedding index of it. That makes it the tool in this stack that sits closest to the line SC drew. Calling SuttaCentral's API with `fetch` on demand is further from it, but a tutor is still downstream of an AI model.

The honest framing is that **no configuration that uses SuttaCentral texts fully honors Sujato's stated wish**. The question is how far to go. A defensible middle position for a personal, non-commercial study repo has five parts. First, retrieve on demand rather than building or committing any corpus. Second, never fine-tune on retrieved text. Third, use no persona, so the tutor does not imitate a teacher. Fourth, cite and link back to suttacentral.net. Fifth, record the decision in an ETHICS.md. The strict alternative is to drop tripitaka-mcp and SC-API fetches, and get suttas from Access to Insight and dhammatalks.org instead. Thanissaro's translations there are **CC BY-NC**, which is restrictive in other ways ([ATI MN 10](https://accesstoinsight.org/tipitaka/mn/mn.010.than.html)). The cost of the strict route is losing segment-aligned Pāli text and `verify_quote`. Choose deliberately, and say which route you chose.

The other licenses are restrictive but simpler to follow. They are all fine for personal non-commercial use, and none should end up committed to the repo:

| Source | License | Practical rule for the repo |
|---|---|---|
| SuttaCentral / bilara-data (Sujato, Brahmali) | CC0, plus the AI request above; legacy translations keep third-party copyright ([SC](https://suttacentral.net/localization/elements/licensing_en.json)) | Retrieve on demand, link back, document your stance |
| Digital Pāli Dictionary | CC BY-NC-SA 4.0 ([LICENSE](https://github.com/digitalpalidictionary/dpd-db/blob/main/LICENSE)) | No commercial use; attribute; any derivatives must use the same license |
| tripitaka-mcp's Payutto dictionary | "Dhamma Dāna, non-commercial only" ([NOTICE](https://github.com/dhamma-seeker/tripitaka-mcp/blob/main/NOTICE.md)) | Non-commercial only |
| 84000 | CC BY-NC-ND 3.0 ([data-tei](https://github.com/84000/data-tei)) | Quote and display; never commit modified text |
| CBETA | CC BY-NC-SA 3.0 TW, with the Yinshun/Taixu/Lü Cheng collections excluded ([CBETA](https://www.cbeta.org/copyright.php)) | Non-profit only |
| Master-skill personas and modes | CC BY-NC-SA 4.0 ([LICENSE](https://github.com/xr843/Master-skill/blob/main/LICENSE)) | Install or link; don't vendor into an MIT repo |

Gitignore any local cache of retrieved text. Behavior also matters, and the projects reviewed agree on the rules. Disclose that output is AI synthesis. Do not role-play living teachers, buddhas or bodhisattvas. Do not certify attainments or diagnose practice states, which is a real risk given Abhidhamma's material on stages of insight knowledge. Lead with a plain-language crisis referral that uses only verified phone numbers ([safety_clause.md](https://github.com/xr843/Master-skill/blob/main/plugin/skills/create-master/prompts/safety_clause.md)). Avoid "hotline dumping" when someone is in ordinary existential distress ([Satori SAFETY.md](https://github.com/MetcalfSolutions/Satori/blob/main/SAFETY.md)). Britton and Lindahl's research catalogued **59 categories of meditation-related challenges**, so any practice instructions should cite their texts, carry an adverse-effects caveat, and refer users to a qualified teacher ([Brown](https://alumni-friends.brown.edu/news/2019-08-19/britton-lindahl-meditation-research)).

## Ready-to-paste `.mcp.json`

Claude Code supports HTTP servers natively, so the `mcp-remote` bridge in tripitaka-mcp's README is only needed for Claude Desktop. None of these servers needs an API key. Claude Code will ask you to approve project-scoped servers the first time it loads them. "Verified" here has a specific meaning. The hosted endpoints answered raw JSON-RPC `initialize` and `tools/list` probes on 2026-10-26. The stdio commands come from each project's README. **No end-to-end Claude Code connection test was run.**

```json
{
  "mcpServers": {
    "fetch": {
      "command": "uvx",
      "args": ["mcp-server-fetch"]
    },
    "tripitaka": {
      "type": "http",
      "url": "https://mcp.tripitaka-mcp.com/mcp"
    },
    "fojin": {
      "type": "http",
      "url": "https://mcp.fojin.ai/mcp"
    }
  }
}
```

If you prefer local code you can audit, use the stdio variants. tripitaka needs `pipx install tripitaka-mcp && tripitaka-mcp init` first, which downloads about 120 MB of SQLite and drops semantic search. fojin's stdio client still calls fojin.app ([tripitaka README](https://github.com/dhamma-seeker/tripitaka-mcp), [fojin README](https://github.com/xr843/fojin/blob/main/mcp-server/README.md)).

```json
{
  "mcpServers": {
    "tripitaka": { "command": "tripitaka-mcp", "args": ["serve"] },
    "fojin": { "command": "uvx", "args": ["fojin-mcp"] }
  }
}
```

If you need local CBETA, SAT and Tibetan depth, add buddha-cli. You install it with its bootstrap script or a Cargo build, and it adds several GB of corpora ([repo](https://github.com/sinryo/buddha-cli)):

```json
{
  "mcpServers": {
    "buddha": { "command": "/Users/YOU/.buddha/bin/buddha", "args": ["mcp"] }
  }
}
```

Final ranking:

| # | Component | Role | Build or adopt |
|---|---|---|---|
| 1 | `mcp-server-fetch` (MIT) | SC API, dpdict.net, CBETA API, ATI, dhammatalks | Adopt |
| 2 | tripitaka-mcp (MIT code) | Pāli canon, `verify_quote`, Pāli parsing | Adopt, subject to your SC decision |
| 3 | fojin (Apache-2.0) | Kośa/Yogācāra in CBETA, parallels, 32 dictionaries | Adopt |
| 4 | Master-skill (MIT / CC BY / CC BY-NC-SA) | Citation contract, safety clause, eval pattern | Install or study; don't vendor content |
| 5 | Abhidharma tutor skill | Tradition-tagged curriculum, anchors, quizzes | Build (required) |
| 6 | 84000 GraphQL wrapper | English Mahāyāna sūtras from Tibetan | Build (optional, about 100 lines) |

Leave out buddha-cli (single author, heavy install) unless you need CBETA offline. Leave out lotus-wisdom, which serves no scripture. Leave out sutta-mcp (not open source) and the archived or stale DPD servers, since `fetch` already reaches DPD through two live endpoints.

## Conclusion

Most of the stack can be adopted. The scarce part is reliable Abhidharma pedagogy. tripitaka-mcp and fojin already handle retrieval and quote verification as well as a custom server would, and both put verification ahead of generation, which is what a tutor needs. What nobody has built is the layer that knows a Theravāda cetasika count from a Sarvāstivāda one, labels every claim with its tradition, and checks the learner with drills. That skill is where custom effort pays off, and Master-skill's MIT validators and BuddhismAI's workflow give a head start without inheriting their content licenses.

The second takeaway is that "open" in this field is moral as well as legal. The most permissively licensed corpus, SuttaCentral's CC0 texts, comes with the strongest request not to build exactly this kind of tool. A tutor repo that wants to be trustworthy to Buddhist practitioners should treat that request as a design input: write the decision down in ETHICS.md, avoid personas, link back to SuttaCentral, and make dropping the SuttaCentral-derived server a one-line config change if you later decide to.
