# Open APIs and Datasets for Buddhist Texts and Dictionaries (for MCP use), as of 26 Oct 2026

Method: I tested every endpoint marked **[LIVE-TESTED 2026-10-26]** with curl from this machine. I pulled GitHub repo metadata (size, license, last push) from the GitHub API on the same day. Anything I did not test is marked **[UNTESTED]**.

## Q0 (priority): Do existing, maintained MCP servers already wrap these sources?

### Takeaway
Existing MCP servers already cover the Pāli canon (SuttaCentral), the DPD dictionary and CBETA. None of them is "popular" yet: the most-starred has 12 stars. The best-maintained is **dhamma-seeker/tripitaka-mcp**, which is MIT-licensed, has a hosted endpoint and was pushed 2026-10-24. Any SuttaCentral JSON endpoint (Q1) can also be called through the official, widely used **`mcp-server-fetch`** reference server, because the API needs no auth and is plain GET. I found no MCP server for 84000, SAT or the DDB. Only 84000 needs a small custom wrapper, and even that is optional, since `fetch` cannot POST GraphQL but a custom tool could.

### Cited Findings
**Pāli canon / SuttaCentral**
- **dhamma-seeker/tripitaka-mcp**: 12 stars, 5 forks, created 2026-04-11, last push 2026-10-24, MIT code. It covers about 444K segments of the whole Tipiṭaka, built from SuttaCentral bilara-data. The English is Sujato (DN/MN/SN/AN/most of KN), Brahmali (Vinaya), and Kelly, Kovilo and others for some KN books. Abhidhamma is Pāli only. It has 14 tools, including `search_hybrid`, `search_by_keyword`, `survey_corpus`, `search_semantic`, `verify_quote`, `get_sutta` (with outline, slice and `around` modes), `open_sutta_viewer` (MCP Apps), `get_reference` and `compare_translations`. — [README](https://github.com/dhamma-seeker/tripitaka-mcp)
  - Hosted at `https://mcp.tripitaka-mcp.com/mcp` (Streamable HTTP) and `/sse`. The README gives a Claude Desktop config using `npx -y mcp-remote https://mcp.tripitaka-mcp.com/mcp`. It is also listed on [Glama](https://glama.ai/mcp/servers/dhamma-seeker/tripitaka-mcp) and Smithery. — [README](https://github.com/dhamma-seeker/tripitaka-mcp)
  - The local stdio mode (`tripitaka-mcp serve`) exposes only 11–12 tools. Semantic and hybrid search are hosted-only because they need Postgres, pgvector and a ~1 GB embedding model. — [README](https://github.com/dhamma-seeker/tripitaka-mcp)
  - Data notice: bilara-data is CC0. A bundled Payutto Dictionary of Buddhism is "Dhamma Dāna, non-commercial only". — [NOTICE.md](https://github.com/dhamma-seeker/tripitaka-mcp/blob/main/NOTICE.md)
- **nbkhoi/sutta-mcp** (TypeScript, 0 stars, push 2026-10-24) is a thin live wrapper over the SuttaCentral API. Tools: `search_topic` (`/api/search/instant`), `get_sutta`, `get_sutta_meta`, `get_parallels`, `list_divisions`. Install is git clone, then `npm install && npm run build`. The docs are in Vietnamese. — [README](https://github.com/nbkhoi/sutta-mcp)

**Digital Pāli Dictionary**
- **thiravadhano/DPD-MCP-Server** (Node ≥18, 1 star, created and last pushed 2026-03-16) has tools `lookup_pali_word` (handles inflections, compounds and sandhi), `search_pali_meaning` and `lookup_pali_root`. `npm run setup` downloads a "dpd_lite.db" and builds indexes (~500 MB). Its README states the data license as CC BY-NC 4.0, but upstream DPD is CC BY-NC-SA 4.0 (see Q3). — [README](https://github.com/thiravadhano/DPD-MCP-Server)

**CBETA (Chinese canon)**
- **wedreamer/cbeta-cli** (Rust, MIT, 0 stars, push 2026-10-14) is an offline CBETA search CLI that also runs as an MCP server. It supports keyword, proximity and quote-verify search, and has v0.2.0 releases with prebuilt macOS binaries. Corpus setup is `cbeta fetch --release 2026R2 --scope taisho`. — [README](https://github.com/wedreamer/cbeta-cli)
- **tendayspace/CbetaMCP** (Python/FastAPI, MIT, 4 stars, last push 2025-04-11, stale) is a generic FastAPI-MCP aggregator with CBETA tools. — [README](https://github.com/tendayspace/CbetaMCP)
- hiing/CbetaMCP (GPL-3.0, 0 stars, push 2026-02-10). I did not review it. — [GitHub search](https://github.com/hiing/CbetaMCP)

**Generic / established**
- The official `modelcontextprotocol/servers` repo currently ships these reference servers: everything, fetch, filesystem, git, memory, sequentialthinking, time (from GitHub API listing of `src/`). — [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers/tree/main/src)
- No MCP server turned up for 84000, SAT Daizōkyō or the DDB. Searches run: GitHub repo search "84000 mcp" (0 results), "buddhist mcp" and "dharma mcp". — [GitHub search](https://github.com/search?q=84000+mcp&type=repositories)

### Inferences
- **Lowest-friction stack, with no custom code:**
  1. tripitaka-mcp, hosted via `mcp-remote`, for Pāli and English sutta search, fetch and quote verification.
  2. DPD-MCP-Server (local), or `mcp-server-fetch` against `https://www.dpdict.net/search_json?q=<word>`, for Pāli lookup.
  3. `mcp-server-fetch` for any ad-hoc SuttaCentral GET (suttaplex, bilarasuttas, dictionary_full).
- All these community servers are young and low-star. "Established" applies only to `mcp-server-fetch`. Pin to a commit if you adopt them.
- `mcp-server-fetch` converts HTML to markdown, but SC's bilarasuttas JSON is ~97 KB per sutta. `fetch` paginates with `max_length` and `start_index`, so a long sutta can take several calls.
- A custom MCP is justified only for (a) 84000 GraphQL, since `fetch` is GET-only, or (b) a fully offline bundle of bilara-data plus DPD sqlite.

### Gaps
- I did not install or run tripitaka-mcp, DPD-MCP-Server or cbeta-cli, and I did not call the hosted tripitaka endpoint. The tools and transports listed come from their READMEs.
- I did not check `mcp-server-fetch`'s exact current flags (e.g. `max_length`) against its README this session.

## Q1: SuttaCentral API — exact endpoints, live examples, rate limits, license

### Takeaway
The public SuttaCentral JSON API at `https://suttacentral.net/api/...` needs no auth and sits behind a Cloudflare cache. I confirmed four endpoints live: bilarasuttas (segmented text), suttas (including legacy HTML translations), suttaplex (metadata and translation list) and search/instant. Sujato and Brahmali translations are CC0. "Legacy" translations such as Horner's keep their third-party copyright. SC also explicitly asks that its content not be scraped for generative-AI datasets.

### Cited Findings
**Segmented text (Pāli root plus translation, aligned by segment ID)** [LIVE-TESTED 2026-10-26]
```
GET https://suttacentral.net/api/bilarasuttas/mn10/sujato?lang=en
```
- The response is about 97 KB of JSON with keys `comment_text`, `html_text`, `root_text`, `translation_text`, `variant_text`, `reference_text`, `keys_order`. Each is a map from segment ID to string, e.g. `root_text["mn10:0.2"] = "Satipaṭṭhānasutta "` and `translation_text["mn10:0.2"] = "Mindfulness Meditation "`. `html_text` holds templates such as `"<h1 class='sutta-title'>{}</h1></header>"`. Response headers: `server: cloudflare`, `cache-control: max-age=172800`, `cf-cache-status: HIT`. — [live endpoint](https://suttacentral.net/api/bilarasuttas/mn10/sujato?lang=en)

**Sutta, any translator including legacy** [LIVE-TESTED]
```
GET https://suttacentral.net/api/suttas/mn10/sujato?lang=en
GET https://suttacentral.net/api/suttas/mn10/horner?lang=en
```
- Keys: `root_text`, `translation`, `segmented`, `suttaplex`, `bilara_root_text`, `bilara_translated_text`, `candidate_authors`. For mn10, `candidate_authors = ['suddhaso','horner','nyanamoli-thera']`. — [live](https://suttacentral.net/api/suttas/mn10/sujato?lang=en)
- For legacy translators, `translation.text` is a full HTML document, e.g. Horner: `title: 'Discourse on the Applications of Mindfulness'`, `<meta name='author' content='I.B. Horner'>`. — [live](https://suttacentral.net/api/suttas/mn10/horner?lang=en)
- `/api/suttas/mn10/bodhi` returned `translation: null`. **Bhikkhu Bodhi's MN translation is not on SuttaCentral**, and `/api/suttas/mn10/thanissaro` also returned no translation. — [live](https://suttacentral.net/api/suttas/mn10/bodhi?lang=en)

**Suttaplex (metadata, translations, parallels card)** [LIVE-TESTED]
```
GET https://suttacentral.net/api/suttaplex/mn10
```
- Returns an array of objects with `acronym: "MN 10"`, `volpages: "PTS MN 1.55..."`, `uid`, `blurb`, `difficulty: {name:"intermediate", level:2}`, `original_title: "Satipaṭṭhānasutta"`, `root_lang: "pli"`, `translated_title`, and `translations: [{lang, author, author_uid, id, segmented, has_comment, ...}]`. — [live](https://suttacentral.net/api/suttaplex/mn10)

**Search** [LIVE-TESTED]
```
GET  https://suttacentral.net/api/search/instant?query=mindfulness&language=en&limit=2
POST https://suttacentral.net/api/search/instant?limit=3&query=mindfulness&language=en&restrict=all&matchpartial=false   (body: [] , Content-Type: application/json)
```
- Both forms returned `{"total": 1462|1471, "hits": [{acronym, uid, lang, author, author_uid, is_bilara_text, url: "/an1.296-305/en/sujato", highlight: {content: [...<strong class="highlight">Mindfulness</strong>...]}, root_name}]}`. — [live](https://suttacentral.net/api/search/instant?query=mindfulness&language=en&limit=2)
- `GET /api/search?query=...` returns 404. Use `/api/search/instant`. — [live](https://suttacentral.net/api/search?query=mindfulness&language=en&limit=3)

**Dictionary (via SC)** [LIVE-TESTED]
```
GET https://suttacentral.net/api/dictionary_full/sati?language=en
```
- Returns entries from three dictionaries, `dictname ∈ {dpd, ncped, pts}`, so it covers DPD, the New Concise Pāli-English Dictionary and the PTS dictionary. Example: `{"dictname":"ncped","entry":"sati","grammar":"feminine","definition":"memory; mindfulness"}`, plus DPD senses such as "sati 1.2: fem. mindfulness; presence; recollection; awareness [√sar + ti]". — [live](https://suttacentral.net/api/dictionary_full/sati?language=en)
- `GET /api/dictionaries/lookup?from=pli&to=en&word=sati` returned an alphabetical word list starting at "ababo", so it does not appear to filter by `word`. Avoid it. — [live](https://suttacentral.net/api/dictionaries/lookup?from=pli&to=en&word=sati)

**Menu / navigation** [LIVE-TESTED]: `GET https://suttacentral.net/api/menu/mn?language=en` returns `[{uid:"mn", root_name:"Majjhimanikāya", translated_name, node_type:"branch", blurb, ...}]`. — [live](https://suttacentral.net/api/menu/mn?language=en)

**License / terms** (from SC's own licensing strings, `licensing_en.json`)
- "All original material created by SuttaCentral is dedicated to the Public Domain by means of Creative Commons Zero (CC0 1.0 Universal)." — [SC licensing strings](https://suttacentral.net/localization/elements/licensing_en.json)
- "...copyright has been asserted by third parties. This includes many of the 'legacy' translated texts... the terms of the copyright are specified by the copyright asserter." — [same](https://suttacentral.net/localization/elements/licensing_en.json)
- Reference data such as parallels "does not fall within the scope of copyright". — [same](https://suttacentral.net/localization/elements/licensing_en.json)
- **AI request:** "We politely request that our content not be scraped or used in any way for the creation of datasets for generative AI or similar. This request applies to those who create applications directly, and those who build apps downstream of AI models..." — [same](https://suttacentral.net/localization/elements/licensing_en.json)
- I found no documented rate limit and no API docs page. Responses are Cloudflare-cached for 48 h (`max-age=172800`). — [live headers](https://suttacentral.net/api/bilarasuttas/mn10/sujato?lang=en)

### Inferences
- MCP tool mapping: `search_suttas` → `/api/search/instant`; `get_sutta(uid, translator)` → `/api/bilarasuttas/{uid}/{translator}?lang=en` for segmented Sujato/Brahmali text, falling back to `/api/suttas/{uid}/{translator}` for legacy HTML; `get_sutta_meta` → `/api/suttaplex/{uid}`; `lookup_pali_word` → `/api/dictionary_full/{word}?language=en`.
- On-demand reading in a personal tool is arguably not "creation of datasets", but bulk-embedding SC content (as tripitaka-mcp does) sits uneasily with SC's AI request, even though the CC0 license itself permits it. Flag this to the user.

### Gaps
- There is no official API documentation, so endpoint stability is not guaranteed.
- I found no stated rate limit. I sent only a handful of requests and did not probe the limits.

## Q2: bilara-data / sc-data on GitHub (offline segment JSON)

### Takeaway
`suttacentral/bilara-data` (branch `published`) holds the CC0 segment JSON for root texts and SC translations. Its raw files are fetchable directly. The repo is about 1 GB, so a sparse checkout of `root/pli/ms/sutta` plus `translation/en/sujato` is the practical offline route.

### Cited Findings
- LICENSE.md: "All translations created in Bilara and supported by SuttaCentral are dedicated to the Public Domain by means of the ... (CC0) license." — [LICENSE.md](https://github.com/suttacentral/bilara-data/blob/published/LICENSE.md)
- The repo is 992,595 KB (~0.99 GB) per GitHub's size field, default branch `published`, last push 2026-10-25. — [GitHub API](https://api.github.com/repos/suttacentral/bilara-data)
- Top-level dirs: `root`, `translation`, `comment`, `html`, `reference`, `variant`, plus `_author.json` and `_publication.json`. English translators in `translation/en/`: anandajoti, brahmali, kelly, kovilo, patton, soma, suddhaso, sujato. — [GitHub contents API](https://api.github.com/repos/suttacentral/bilara-data/contents/translation/en)
- Raw file example [LIVE-TESTED]: `https://raw.githubusercontent.com/suttacentral/bilara-data/published/translation/en/sujato/sutta/mn/mn10_translation-en-sujato.json` returns `{"mn10:0.1": "Middle Discourses 10 ", "mn10:1.1": "So I have heard. ", ...}`. — [raw](https://raw.githubusercontent.com/suttacentral/bilara-data/published/translation/en/sujato/sutta/mn/mn10_translation-en-sujato.json)
- `suttacentral/sc-data` (~825 MB, branch `main`) contains `dictionaries/` (subdirs complex, glossaries, jargon, simple), `relationship` (parallels), `structure`, `html_text` (legacy texts) and more. — [GitHub API](https://api.github.com/repos/suttacentral/sc-data/contents/)

### Inferences
- The file path pattern is `{root|translation}/{lang}/{author}/sutta/{nikaya}/{uid}_{type}-{lang}-{author}.json`. A custom server can join root and translation by segment key.

### Gaps
- I did not measure the size of a sparse checkout of just Pāli root plus Sujato English.

## Q3: Digital Pāli Dictionary (DPD)

### Takeaway
DPD publishes monthly releases (latest v0.4.20260926) with a SQLite DB (`dpd.db.tar.xz`, 170 MB compressed) and many dictionary formats. **dpdict.net** also exposes an undocumented-but-public FastAPI JSON endpoint, `/search_json?q=`. The license is CC BY-NC-SA 4.0.

### Cited Findings
- Release v0.4.20260926 (2026-09-26) assets: `dpd.db.tar.xz` 169.6 MB; `dpd-goldendict.zip` 270.6 MB; `dpd-mdict.zip` 318.4 MB; `dpd-slob.zip` 294.1 MB; `dpd-mobile-db.zip` 209.9 MB; `dpd-txt.zip` 4.3 MB; `dpd-anki.apkg` 13.6 MB; plus Kindle, Kobo, Apple and PDF builds. — [GitHub releases API](https://api.github.com/repos/digitalpalidictionary/dpd-db/releases/latest)
- LICENSE: "Copyright (c) Bodhirasa Bhikkhu. SPDX-License-Identifier: CC-BY-NC-SA-4.0". — [LICENSE](https://github.com/digitalpalidictionary/dpd-db/blob/main/LICENSE)
- [LIVE-TESTED] `GET https://www.dpdict.net/search_json?q=sati` returns `{"summary_html": "...sati 1.1 fem. memory; remembering...", "dpd_html": "<~331 KB html>", "license": {"name":"CC BY-NC-SA 4.0","attribution":"Digital Pāḷi Dictionary by Bodhirasa Bhikkhu CC BY-NC-SA 4.0","note":"Non-commercial use only. Derivatives must be shared alike."}}`. — [live](https://www.dpdict.net/search_json?q=sati)
- dpdict.net is a FastAPI/uvicorn app with a public OpenAPI spec. Its paths include `/search_html?q`, `/search_json?q`, `/gd?search` (GoldenDict), `/bd_search?q1&q2&option` (bold-definitions search), `/tt_search?q&book&lang`, `/audio/{headword}`, `/{headword_id}` and `/status`. — [openapi.json](https://www.dpdict.net/openapi.json)
- DPD data is also served through SuttaCentral's `/api/dictionary_full/{word}` (see Q1). — [live](https://suttacentral.net/api/dictionary_full/sati?language=en)

### Inferences
- The `summary_html` field (~3 KB) is the right payload for an LLM tool. `dpd_html` (~330 KB) is too large to pass through unless it is stripped.
- For offline use, `dpd.db` (SQLite) lets you query headwords directly. DPD-MCP-Server already does this with a lite DB.

### Gaps
- I did not inspect the dpd.db schema or its uncompressed size.
- The dpdict.net JSON API has no stated rate limit or stability promise.

## Q4: Access to Insight (ATI)

### Takeaway
ATI offers a single offline zip of the whole site (~77 MB). Individual texts carry per-document licenses; Thanissaro's ATI suttas are CC BY-NC. ATI's versions are frozen, and the updated Thanissaro translations are on dhammatalks.org.

### Cited Findings
- [LIVE-TESTED] `HEAD https://accesstoinsight.org/tech/download/ati.zip` returns 200 with `content-length: 76982736` (~77 MB). It is served by Netlify, and `www.` redirects to the apex. — [ati.zip](https://accesstoinsight.org/tech/download/ati.zip)
- The bulk download page itself is licensed CC BY 4.0, with the note "Documents linked from this page may be subject to other restrictions." — [bulk.html](https://accesstoinsight.org/tech/download/bulk.html)
- MN 10 (Thanissaro) page metadata has `[LICENSE]={CC-BY-NC}`, "© 2008", and a note that "This version of the text might be out of date... The updated version is freely available at" dhammatalks.org. — [mn.010.than.html](https://accesstoinsight.org/tipitaka/mn/mn.010.than.html)
- Thanissaro's newer books are CC BY-NC 4.0; older ones use a "free distribution" license. — [dhammatalks.org book copyright page](https://www.dhammatalks.org/books/ParadoxOfBecoming/Section0002.html); [Mind Like Fire](https://www.dhammatalks.org/books/MindLikeFire/Section0002.html)

### Inferences
- ATI has no API. Its value is the offline HTML corpus (Thanissaro, Bodhi Wheel essays, Ñāṇamoli and others) for a local grep or index tool. The license varies per file, so read each file's `[LICENSE]` metadata.

### Gaps
- `/terms.html` and `/termsofuse.html` both returned 404, so I could not cite ATI's site-wide terms page.

## Q5: Dhammatalks.org and Bhikkhu Bodhi translation availability

### Takeaway
Dhammatalks.org serves Thanissaro's current sutta translations as static HTML (e.g. `/suttas/MN/MN10.html`), with no API. Bhikkhu Bodhi's Nikāya translations (Wisdom Publications) are copyrighted and not on SuttaCentral. Only a few older Bodhi pieces appear on ATI.

### Cited Findings
- [LIVE-TESTED] `https://www.dhammatalks.org/suttas/MN/MN10.html` returns 200, page title "MN 10 The Establishing of Mindfulness Discourse | Satipaṭṭhāna Sutta". — [MN10](https://www.dhammatalks.org/suttas/MN/MN10.html)
- The SuttaCentral API has no Bodhi MN10 translation (`/api/suttas/mn10/bodhi` returns `translation: null`). — [live](https://suttacentral.net/api/suttas/mn10/bodhi?lang=en)

### Inferences
- An existing `fetch` MCP can read dhammatalks.org pages on demand. A custom scraper is not justified. Thanissaro's translations are CC BY-NC (books) per the copyright pages above.

### Gaps
- I could not find a license statement on the dhammatalks.org sutta pages themselves; my scan of MN10's text found no "copyright" or "license" string.
- I did not verify Bodhi's publisher terms or which Bodhi texts ATI hosts.

## Q6: 84000 (Tibetan Kangyur/Tengyur translations)

### Takeaway
84000 has a **public, unauthenticated GraphQL API** at `https://graphql.84000.co/api/graphql` (verified live) and TEI XML on GitHub (`84000/data-tei`, ~282 MB). Both are CC BY-NC-ND 3.0. The old `read.84000.co/translation/tohX.json/.xml` endpoints now return Next.js HTML, not data. No MCP server exists for it.

### Cited Findings
- [LIVE-TESTED] `POST https://graphql.84000.co/api/graphql` with body `{"query":"{ version }"}` returns `{"data":{"version":"1.0.0"}}`. — [schema URL from 84000/docs .graphqlrc.json](https://github.com/84000/docs/blob/main/.graphqlrc.json)
- [LIVE-TESTED] `{"query":"{ works(limit:2){ totalCount items{ uuid toh title restriction publicationDate } } }"}` returns `totalCount: 4250`, with items such as `{"uuid":"49ca79af-...","toh":["toh2088"],"title":"A Bathing Ritual, Purifying Defilements and Eliminating Interruptions","restriction":false}`. — [graphql endpoint](https://graphql.84000.co/api/graphql)
- Introspection works. Query fields include `works(cursor, limit, filter)`, `work(uuid, toh)`, `passage(uuid)`, `search(query, workUuid, toh, types, limit)`, `lookup(toh, uuid, xmlId, type)`, `glossaryInstance` and `glossaryTermPassages`. `Work` fields include `title`, `toh`, `toc`, `passages`, `glossaryTerms`, `searchGlossaryTerms`, `bibliography` and `folios`. — [docs repo, graphql/02-operations/07-queries](https://github.com/84000/docs/tree/main/src/content/graphql)
- Two calls failed: `work(toh:"toh1-1")` and `work(toh:"toh8")` returned `null`, and `search(query:"emptiness")` returned `[]`. The correct toh string format and the search `types` argument still need work. — [graphql endpoint](https://graphql.84000.co/api/graphql)
- `https://api.84000.co/rest/v1/` returns "No API key found in request". That is a separate keyed REST (Supabase-style) API, not public. — [live](https://api.84000.co/rest/v1/)
- data-tei README: "provided under the protection of a Creative Commons CC BY-NC-ND (Attribution - Non-commercial - No-derivatives) 3.0 copyright." The repo is ~282 MB and was last pushed 2025-02-16. `translations/kangyur/translations` holds 396 XML files, e.g. `001-001_toh1-1_chapter_on_going_forth.xml`, which is 1.4 MB. — [data-tei README](https://github.com/84000/data-tei); [contents API](https://api.github.com/repos/84000/data-tei/contents/translations/kangyur/translations)
- Inside each TEI file is `<licence>` with the same CC BY-NC-ND 3.0 text (verified in toh1-1). — [raw TEI](https://raw.githubusercontent.com/84000/data-tei/master/translations/kangyur/translations/001-001_toh1-1_chapter_on_going_forth.xml)
- The 84000 org also has `data-rdf` (LOD metadata, push 2026-09-19) and `etext-repo` (push 2026-10-09). — [84000 org repos](https://github.com/84000)

### Inferences
- data-tei has not been pushed since Feb 2025, while the GraphQL API is live, so GraphQL is probably the current source of truth.
- ND (no-derivatives) allows displaying and quoting passages in a personal tool, but rules out redistributing modified or derived text.
- This is the one source where a small custom MCP (2–3 tools: `list_84000_works`, `get_84000_passage`, `search_84000_glossary`) adds value, because `mcp-server-fetch` cannot send GraphQL POSTs.

### Gaps
- I did not get a working `work(toh:...)` or `search` call. I need to inspect the `WorkFilter` and `LookupResult` types.
- I found no rate limits or terms of use specific to the GraphQL API.

## Q7: CBETA (Chinese canon)

### Takeaway
The CBETA API at `cbdata.dila.edu.tw/stable` is public and returns JSON (verified for works, juans and search, including KWIC). The full TEI P5 XML is in `cbeta-org/xml-p5` (~1.45 GB). The license is CC BY-NC-SA 3.0 TW, with some collections excluded. The text is Classical Chinese, so it adds little for an English-only learner.

### Cited Findings
- [LIVE-TESTED] `GET https://cbdata.dila.edu.tw/stable/works?work=T0235` returns `{"num_found":1,"results":[{"work":"T0235","title":"金剛般若波羅蜜經","byline":"後秦 鳩摩羅什譯","juan":1,"cjk_chars":5191,"time_from":402,...}]}`. — [live](https://cbdata.dila.edu.tw/stable/works?work=T0235)
- [LIVE-TESTED] `GET /stable/juans?work=T0235&juan=1&work_info=1` returns `results: ["<html>...<div id='body' data-punc='CBETA'>..."]` (HTML text with line-break IDs such as `T08n0235_p0748c15`). — [live](https://cbdata.dila.edu.tw/stable/juans?work=T0235&juan=1&work_info=1)
- [LIVE-TESTED] `GET /stable/search?q=般若&rows=2` (URL-encoded) returns `num_found: 10668`, with results carrying canon, file, work, juan, title and byline. Unencoded CJK returned "invalid URL". — [live](https://cbdata.dila.edu.tw/stable/search?q=%E8%88%AC%E8%8B%A5&rows=2)
- [LIVE-TESTED] `GET /stable/search/kwic?q=如是我聞&work=T0235&juan=1` returns `{"results":[{"vol":"T08","lb":"0748c20","kwic":"鳩摩羅什譯如是我聞：一時，佛"}]}`. — [live](https://cbdata.dila.edu.tw/stable/search/kwic?q=%E5%A6%82%E6%98%AF%E6%88%91%E8%81%9E&work=T0235&juan=1)
- `cbeta-org/xml-p5` is 1,448,704 KB (~1.45 GB), last pushed 2026-09-05. Its README defers copyright to cbeta.org/copyright.php. — [xml-p5](https://github.com/cbeta-org/xml-p5)
- CBETA copyright: use is limited to non-profit purposes. Anything not otherwise stated is licensed "Creative Commons 姓名標示-非商業性-相同方式分享 3.0 台灣" (CC BY-NC-SA 3.0 TW). Some works (Yinshun, Taixu, Lü Cheng collections) are excluded from CC. — [CBETA copyright](https://www.cbeta.org/copyright.php)

### Gaps
- I did not check CBETA API rate limits or the official API docs page.

## Q8: SAT Daizōkyō, DDB, PTS dictionary, other glossaries

### Takeaway
SAT has no public JSON API that I could find. The DDB needs a login: guest access is limited to 10 searches/day (some sources say 20), so it is unsuitable for MCP. The PTS Pāli-English dictionary is already exposed through SuttaCentral's `dictionary_full` endpoint.

### Cited Findings
- SAT: `https://21dzk.l.u-tokyo.ac.jp/SAT2018/master30.php` and `/SAT2018/T0235.html` both return HTTP 200 (HTML web app). I did not explore an API. **[UNTESTED as API]** — [SAT2018](https://21dzk.l.u-tokyo.ac.jp/SAT2018/master30.php)
- DDB homepage (live): "DDB Entry Total (2026/9/31): 79,550" and "[non-members can log in with 'guest']". — [buddhism-dict.net/ddb](http://www.buddhism-dict.net/ddb/)
- Guest limit: 10 searches/day per [Wikipedia](https://en.wikipedia.org/wiki/Digital_Dictionary_of_Buddhism), the [TEI project page](https://tei-c.org/activities/projects/digital-dictionary-of-buddhism-and-cjkv-e-dictionary/) and a [UWest library guide](https://lib.uwest.edu/guides/topic/buddhist-studies/general-buddhism). This is contradicted by a 2021 interview with editor Charles Muller, which says 20 searches/day without membership, and full access for 2 years if you contribute a 350+ word entry. — [Digital Orientalist](https://digitalorientalist.com/2021/12/21/online-resources-for-buddhist-studies-and-the-development-of-digital-humanities-past-present-and-future-an-interview-with-charles-muller-editor-of-the-ddb-and-cjkv-e-dictionaries/)
- PTS dictionary: `dictname: "pts"` is among the entries returned by `https://suttacentral.net/api/dictionary_full/sati?language=en` [LIVE-TESTED]. SC's `sc-data/dictionaries` also has `glossaries` and `jargon` folders. — [live](https://suttacentral.net/api/dictionary_full/sati?language=en); [sc-data](https://github.com/suttacentral/sc-data/tree/main/dictionaries)

### Gaps
- I did not check SAT's terms or whether it exposes IIIF or a text API.
- I did not verify the PTS dictionary's license as served by SC.
- I did not research other glossaries (e.g. Nyanatiloka's Buddhist Dictionary, the 84000 glossary via GraphQL `glossaryTerms`) in depth.

## Q9: Best 2–3 sources for a learner, lowest friction; data sizes; client libraries

### Takeaway
For an English-speaking learner, the cheapest-to-set-up and most valuable trio is: (1) SuttaCentral, via the hosted tripitaka-mcp or via `mcp-server-fetch` on the SC API (Pāli canon in English, CC0 Sujato); (2) DPD, via DPD-MCP-Server or `fetch` on dpdict.net or the SC `dictionary_full` endpoint; (3) 84000 GraphQL for Mahāyāna sūtras in English, translated from Tibetan. Only (3) needs custom code. CBETA is Chinese-only and useful only for advanced study.

### Cited Findings (sizes)
- bilara-data ~0.99 GB; sc-data ~825 MB — [GitHub API](https://api.github.com/repos/suttacentral/bilara-data)
- DPD: `dpd.db.tar.xz` 170 MB; `dpd-goldendict.zip` 271 MB — [releases](https://api.github.com/repos/digitalpalidictionary/dpd-db/releases/latest)
- ATI offline zip ~77 MB — [ati.zip](https://accesstoinsight.org/tech/download/ati.zip)
- 84000 data-tei ~282 MB — [GitHub API](https://api.github.com/repos/84000/data-tei)
- CBETA xml-p5 ~1.45 GB — [GitHub API](https://api.github.com/repos/cbeta-org/xml-p5)
- The GitHub `size` field is the repo's packed size in KB, so working-tree checkouts may differ.

### Cited Findings (client libraries)
- I found no standalone, maintained Python or JS client library for the SuttaCentral API. The closest working code is in nbkhoi/sutta-mcp (TS) and tripitaka-mcp (Python). — [sutta-mcp](https://github.com/nbkhoi/sutta-mcp); [tripitaka-mcp](https://github.com/dhamma-seeker/tripitaka-mcp)
- Generic: `@graphql-tools/url-loader` is what 84000's own docs tooling uses against the schema. — [.graphqlrc.json](https://github.com/84000/docs/blob/main/.graphqlrc.json)

### Inferences
- License fit for personal, non-commercial learning: SC (CC0) is free of restrictions. DPD (BY-NC-SA), 84000 (BY-NC-ND) and CBETA (BY-NC-SA) are all fine for personal non-commercial use but block commercial use. 84000 also blocks derivatives. SC's AI-dataset request is a soft norm to respect: fetch on demand, don't bulk-embed.
- Recommended minimal setup, in order:
  1. Add `mcp-server-fetch`, which is established and covers SC, dpdict.net and dhammatalks.org GETs.
  2. Add the hosted tripitaka-mcp for search and quote verification.
  3. Optionally add DPD-MCP-Server for offline Pāli lookups.
  4. Write a custom ~100-line MCP only for 84000 GraphQL.

### Gaps
- No popularity or stability metrics exist beyond GitHub stars. All Buddhist-specific MCPs found have 12 stars or fewer and are under one year old.
- I did not check PyPI or npm for packages such as "suttacentral" or "pali-dictionary".
