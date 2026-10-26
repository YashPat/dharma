# MCP servers for Buddhist scriptures, texts, and dictionaries (as of 2026-10-26)

Method: GitHub repo + code search via `gh` (terms: buddhism, buddhist, sutta, suttacentral, pali, tipitaka, dharma, dhamma, sutra, cbeta, 84000, tibetan, abhidhamma, zen, meditation); the official MCP registry API (`registry.modelcontextprotocol.io/v0/servers?search=`); Smithery registry API; PyPI/npm JSON APIs and pypistats; web search for glama/lobehub/mcp.so/pulsemcp listings. I read READMEs directly from the repos. For the hosted servers I sent a live `initialize` + `tools/list` from curl on 2026-10-26, so the tool names below for hosted servers are **observed**, not copied from the docs. Glama's API needs a key, so I did not query Glama directly. Every stats figure below is as of 2026-10-26.

Coordinator priority update applied: the user wants **only public, popular, established open-source** servers. Recommendations are weighted toward stars/contributors/registry presence/licence, and generic established servers (official `fetch`) are covered as a fallback.

## Q1. Inventory: repo, author, stars, activity, license, language, tools, corpus

### Takeaway
Nothing in the Buddhist niche is "popular" by general MCP standards. The most-starred repo is fojin (353 stars, 3 contributors), and every dedicated text server has 1 to 3 contributors. Two are serious, actively maintained and open source: **dhamma-seeker/tripitaka-mcp** (Pāli canon, MIT, 12 stars, but the most-used Buddhist server on Smithery) and **xr843/fojin** (cross-canon Chinese/Pāli/Tibetan plus dictionaries, Apache-2.0). **sinryo/buddha-cli** (formerly `daizo-mcp`) is the only one covering CBETA, SAT and Tibetan locally, but it has a single author. Nothing dedicated exists for 84000, Access to Insight, SAT alone, or a live DPD.

### Cited Findings

**A. Dedicated text/canon servers (substantive)**

1. **dhamma-seeker/tripitaka-mcp** (author "Dhamma Seeker", pseudonymous)
   - 12 stars, 5 forks, 1 contributor, about 318 commits, created 2026-04-11, last push 2026-10-24, Python (FastMCP), code MIT; data mostly CC0 (bilara-data), with a non-commercial-only Payutto dictionary component. — [repo](https://github.com/dhamma-seeker/tripitaka-mcp), [LICENSE](https://github.com/dhamma-seeker/tripitaka-mcp/blob/main/LICENSE), README "Data sources & license" table
   - Corpus: full Tipiṭaka, about 444K segments "at parity with SuttaCentral". Sutta: Pāli plus English from bilara-data (Sujato for DN/MN/SN/AN and most of KN). Vinaya: Pāli plus Brahmali's English. Abhidhamma: Pāli only. Dictionaries: 20,000+ entries (Payutto, PTS, DPPN). The manual-setup step says it loads "DPD, PTS, DPPN, and the Payutto dictionary", but the `get_word_definition` description lists only PTS, DPPN and Payutto. — [README](https://github.com/dhamma-seeker/tripitaka-mcp)
   - 14 tools on the hosted server. Observed live on 2026-10-26: `search_by_keyword, survey_corpus, get_sutta, search_semantic, search_hybrid, list_structure, get_reference, list_editions, compare_translations, get_word_definition, verify_quote, define_from_suttas, parse_pali_word, open_sutta_viewer`. It also exposes resources `tripitaka://structure`, `tripitaka://sutta/{id}`, `tripitaka://word/{w}`. — live probe of `https://mcp.tripitaka-mcp.com/mcp`; [README tool table](https://github.com/dhamma-seeker/tripitaka-mcp)
   - The local pipx edition has 11 tools (12 with `TRIPITAKA_MCP_APP=1`). `search_semantic` and `search_hybrid` are hosted-only. — README "Hosted vs local"
   - Registry presence: official MCP registry as `io.github.dhamma-seeker/tripitaka-mcp` v1.3.0 with remotes `/mcp` and `/sse` ([registry API](https://registry.modelcontextprotocol.io/v0/servers?search=tripitaka)). Smithery shows useCount **1131**, the highest of any Buddhist server there ([Smithery](https://smithery.ai/server/dhamma-seeker/tripitaka-mcp)). It is also listed on Glama (README badge), [mcp.so](https://mcp.so/zh/servers/tripitaka-mcp), [mcpservers.org](https://mcpservers.org/vi/servers/dhamma-seeker/tripitaka-mcp) and [cursor.directory](https://cursor.directory/plugins/tripitaka-mcp).
   - PyPI `tripitaka-mcp` 1.1.0 (uploaded 2026-09-08, Python ≥3.10, MIT), 185 downloads in the last month. — [PyPI](https://pypi.org/project/tripitaka-mcp/), [pypistats](https://pypistats.org/packages/tripitaka-mcp)
   - Version numbers disagree across sources: PyPI 1.1.0, registry 1.3.0, and the live server reports `serverInfo.version` "4.1.1". The PyPI build may therefore lag the hosted server. — PyPI JSON, registry API, live probe
   - Rate limits on the hosted server: 10 req/10 s and 60 req/min per IP. Its privacy policy says nothing is logged. — README

2. **xr843/fojin** (subdirectory `mcp-server/`; author xr843, brand "fojin (佛津)")
   - **353 stars**, 66 forks, 3 contributors, about 2,217 commits, created 2026-03-10, last push 2026-10-24, Python, Apache-2.0. — [repo](https://github.com/xr843/fojin)
   - Platform corpus: "10,500+ texts, 613 sources, trilingual cross-canon", covering CBETA, SuttaCentral (`sc/`), 84000 (`84k/toh`), GRETIL and VRI numbering through URNs. It also has 32 dictionaries and a knowledge graph. — [repo description](https://github.com/xr843/fojin), [mcp-server README](https://github.com/xr843/fojin/blob/main/mcp-server/README.md)
   - Tools observed live on 2026-10-26: `search_corpus, read_passage, get_parallels, lookup_dictionary, lookup_entity, resolve_urn, verify_quote, commentaries` (8). The README lists 7 tools and says "the six fojin tools", so the docs lag the server. — live probe of `https://mcp.fojin.ai/mcp`; README
   - It is a thin read-only client: "it only issues GETs against fojin's public API" (`https://fojin.app/api`, which `FOJIN_API_BASE_URL` can override). Even the stdio install depends on fojin.app being online. — README
   - Registry: official registry `app.fojin/fojin-mcp` v0.4.0 with remote `https://mcp.fojin.ai/mcp` ([registry API](https://registry.modelcontextprotocol.io/v0/servers?search=fojin)). PyPI `fojin-mcp` 0.4.0 (2026-08-10, Apache-2.0) has 74 downloads in the last month ([PyPI](https://pypi.org/project/fojin-mcp/)).
   - A sibling repo, xr843/Master-skill (472 stars), is a "FoJin-powered Buddhist AI persona framework". It is a skill, not an MCP server. — gh search

3. **sinryo/buddha-cli** (the `daizo-mcp` lead; author Shinryo Taniguchi)
   - `github.com/sinryo/daizo-mcp` now redirects to `sinryo/buddha-cli`. The README says the "former project/binary names (`daizo`, `daizo-cli`, `daizo-mcp`) are kept as compatibility aliases". — [repo](https://github.com/sinryo/buddha-cli), gh API redirect
   - 12 stars, 2 forks, 1 contributor, about 57 commits, created 2025-08-30, latest release v0.6.18 (2026-10-20), Rust, licence "MIT OR Apache-2.0" per the README (GitHub shows NOASSERTION). — gh API; README
   - Corpus: CBETA (local), Pāli Tipiṭaka romanized (local, from the VRI tipitaka-xml), GRETIL, SARIT, MUKTABODHA, 真言宗全書 (SHINZEN / SHOKU_SHINZEN), plus online-and-cached SAT Daizōkyō, Jōdo Shū Zensho, and Tibetan full-text search (BUDA/BDRC, Adarshah). — README "What It Covers"
   - Unified tools by default: `fetch, search, work_catalog, title_search, pipeline, resolve, tibetan_search`. Legacy tools (`cbeta_fetch`, `cbeta_search`, `sat_detail`, `jozen_fetch`, …) come back with `BUDDHA_UNIFIED_TOOLS=0`. — README "MCP Tools"
   - The data directory is `BUDDHA_DIR` (default `~/.buddha`), with legacy `DAIZO_DIR`/`~/.daizo` as fallback. — README
   - It is **not** published on crates.io: `crate buddha does not exist` ([crates.io API](https://crates.io/api/v1/crates/buddha)). You install it by building from source. It also has a [LobeHub listing](https://lobehub.com/mcp/sinryo-daizo-mcp) under the old name.

4. **nbkhoi/sutta-mcp** (SuttaCentral live API, Vietnamese/English)
   - 0 stars, 1 contributor, about 51 commits, created 2026-07-05, last push 2026-10-24, TypeScript, **PolyForm Noncommercial 1.0.0**, which is source-available but not OSI open source. — [repo](https://github.com/nbkhoi/sutta-mcp)
   - Tools: `search_topic, get_sutta, get_sutta_meta, get_parallels, list_divisions`. They call the SuttaCentral API in real time with no cache. Not published to npm, so you clone and `npm run build`. — README

5. **dhammagift/dg-node** (Dhamma.Gift; Pāli canon with Russian and English)
   - Official registry entry `gift.dhamma/pali-canon` v1.0.0, remote `https://api.dhamma.gift/mcp` (streamable-http). Tools observed live: `search, get_text, compare_translations, list_structure`. — [registry API](https://registry.modelcontextprotocol.io/v0/servers?search=dhamma), live probe
   - The repo has 1 star, no licence, and is JavaScript. Its own plan document calls itself a re-implementation inspired by tripitaka-mcp and describes Russian Tipiṭaka as its niche. — [repo](https://github.com/dhammagift/dg-node), `docs/MCP_PLAN.md`

6. **hiing/CbetaMCP** (CBETA on Cloudflare Workers) and **tendayspace/CbetaMCP** (the Python original)
   - hiing: 0 stars, 2 contributors, 14 commits, last push 2026-02-10, GPL-3.0, TypeScript. You **must deploy it yourself** to Cloudflare Workers with a custom domain ("workers.dev 域名无法使用"), then run a `mcp-bridge.js` stdio bridge with `SERVER_URL`. — [repo README](https://github.com/hiing/CbetaMCP)
   - Glama/LobeHub list its tools as `search_sutra, get_sutra_content, get_work_info, browse_catalog` — [Glama](https://glama.ai/mcp/servers/@hiing/Cbeta-MCP/tree/c514b671d9c3829c6c4e27cc69d79c7802c47496) (directory listing, not verified in source)
   - tendayspace: 4 stars, MIT, Python, last push 2025-04-11. The README was a 404 when fetched and the repo looks abandoned. — [repo](https://github.com/tendayspace/CbetaMCP)

7. **liminalism/SinoRAG**: local CBETA/classical-Chinese research backend (Rust) with `sinorag mcp`. `sinorag init` downloads a prebuilt CBETA pack, and index builds can take "up to several hours". 0 stars, last push 2026-07-25. — [repo](https://github.com/liminalism/SinoRAG)

8. **fsnow/cst**: the Chaṭṭha Saṅgāyana Tipiṭaka desktop reader (C#, 14 stars, last push 2026-10-24, no licence). It has a built-in loopback-only MCP ("Settings ▸ AI ▸ Access for AI Clients"). It is an app feature, not a standalone server. — [repo README](https://github.com/fsnow/cst)

9. **digitalpalidictionary/dpd-db**: DPD had an MCP server, but its README says it was **"Archived 2026-09-27"** and is "no longer part of the project". Running it means a full dpd-db checkout plus `uv run python exporter/mcp/server.py`. — [archive/exporter/mcp/README.md](https://github.com/digitalpalidictionary/dpd-db/blob/main/archive/exporter/mcp/README.md)

**B. Small or narrow Buddhist servers (toys or single-purpose)**
- **assetgrid-llc/jueban-buddhist-companion**: registry entry `io.github.assetgrid-llc/jueban-buddhist-companion`, remote `https://jueban.online/mcp`. Live tools: `search_buddhist_canon, find_passages_for_situation, explain_buddhist_passage, get_daily_practice`. The repo has 0 stars, is Apache-2.0, and its language is Shell, so the server source does not appear to be in it (unverified). — [registry API](https://registry.modelcontextprotocol.io/v0/servers?search=buddh), live probe, [repo](https://github.com/assetgrid-llc/jueban-buddhist-companion)
- **app.wonbuddhism/scripture**: Won Buddhism scriptures (Korean), remote `https://scripture.wonbuddhism.app/api/mcp`. Live tools: `list_books, search_scripture, get_passage, get_outline, get_related, lookup_dictionary, search_sungga`. — registry API, live probe
- **alex-deus/mcp-dharmamitra**: OCR for Tibetan/Sanskrit/Devanagari images through Dharmamitra (`uvx mcp-dharmamitra`, optional `DHARMAMITRA_COOKIE`). 0 stars, no licence. — [registry API](https://registry.modelcontextprotocol.io/v0/servers?search=dharma)
- **Traves-Theberge/sacred-scriptures-mcp**: multi-religion server whose Buddhism content is only the Dhammapada (423 verses). 2 stars, MIT, last push 2025-07-09, so effectively abandoned. — [repo](https://github.com/Traves-Theberge/sacred-scriptures-mcp)
- **Daisuke134/life-manager `apps/monk-mcp`**: Dhammapada-only (Sujato, CC0) on Cloudflare Workers. Tools: `search_teachings, get_teaching, daily_dhamma`. It sits inside an unrelated "money printer" repo. — [README](https://github.com/Daisuke134/life-manager/tree/main/apps/monk-mcp)

**C. Contemplative "reasoning" servers (no scripture content)**
- **linxule/lotus-wisdom-mcp**: 36 stars, 10 forks, 3 contributors, about 120 commits, created 2025-04-09, last push 2026-10-19, TypeScript, MIT. npm `lotus-wisdom-mcp` 0.8.5 (457 downloads in the last month). Smithery useCount 859. Official registry `io.github.linxule/lotus-wisdom`. Tools: `lotuswisdom, lotuswisdom_summary`, plus prompts `contemplate` and `deep-inquiry`. It is a structured-thinking scaffold "inspired by the Lotus Sutra" and returns **no canonical text**. It is also hosted at `https://lotus-wisdom-mcp.linxule.workers.dev/mcp`, and its README says "the hosted worker records usage analytics". — [repo](https://github.com/linxule/lotus-wisdom-mcp), [npm](https://www.npmjs.com/package/lotus-wisdom-mcp), live probe

**D. False positives (names only, not Buddhist content)**: butterflyskies/pali (agent memory), SecurityRonin/alaya (memory engine), shivnathtathe/sutra (memory), shivayanamahom/dharma-mcp (Joomla), CSOAI-ORG/meditation-guide-ai-mcp (generic wellness), sadri-dridi buddhist-yr/buddhist-ok (Buddhist-era calendar year). — gh search, registry API

**E. Not found**: no MCP server dedicated to 84000 (fojin reaches 84000 only through `84k/toh` URNs), Access to Insight, SAT on its own (buddha-cli covers SAT online), a maintained DPD, or Abhidhamma specifically. — gh search; [web search](https://mcp.so/ja/servers/tripitaka-mcp) returned only tripitaka-mcp for "84000 MCP". No PulseMCP listing turned up in web search results.

### Inferences
- Every dedicated Buddhist server has 1 to 3 contributors and a bus factor of 1. "Popular" here means relative to a niche: tripitaka-mcp leads on usage (Smithery 1131 uses, PyPI 185/month), and fojin leads on GitHub stars and development activity.
- Many repos were created in 2026 and push almost daily, which looks like heavy AI-assisted development. Treat docs as possibly ahead of or behind the code. The version and tool-count mismatches above are concrete examples.

### Gaps
- Glama scores and Glama-only listings were not checked (the API needs a key).
- I could not confirm whether jueban's server source is public.
- The tool list for hiing/CbetaMCP comes from directory listings, not from reading its source.

## Q2. Exact install/run, transport, keys, data downloads

### Takeaway
None of the servers needs an API key or account. The hosted options (tripitaka-mcp, fojin, dhamma.gift, lotus-wisdom) are anonymous streamable HTTP. The local options are pipx for tripitaka-mcp (one-time download of about 120 MB), uvx for fojin (still calls fojin.app over the network), npx for lotus-wisdom, and a Rust source build for buddha-cli (multi-GB local corpora).

### Cited Findings
- **tripitaka-mcp**
  - Hosted endpoints: `https://mcp.tripitaka-mcp.com/mcp` (Streamable HTTP, spec 2025-03-26) and `https://mcp.tripitaka-mcp.com/sse` (legacy SSE). — README
  - The README's Claude Desktop snippet goes through `mcp-remote`: `"command": "YOUR_NPX_PATH", "args": ["-y", "mcp-remote", "https://mcp.tripitaka-mcp.com/mcp"]`. Claude Code supports HTTP natively, so it does not need that bridge. — README
  - Local install: `pipx install tripitaka-mcp`, then `tripitaka-mcp init` ("downloads the SQLite database", about 120 MB), then `tripitaka-mcp serve` (stdio). The README's config is `{"command": "tripitaka-mcp", "args": ["serve"]}`. `serve --http` binds `http://127.0.0.1:8765/mcp`. — README
  - Full self-host is Docker with PostgreSQL + pgvector, restored from a Hugging Face dump ([dhamma-seeker/tripitaka-mcp-dump](https://huggingface.co/datasets/dhamma-seeker/tripitaka-mcp-dump)). Semantic search needs a model of about 1 GB. — README
- **fojin**
  - The README's Claude Code command is `claude mcp add --transport http fojin https://mcp.fojin.ai/mcp` (stateless JSON, anonymous, rate-limited).
  - Stdio config: `{"command": "uvx", "args": ["fojin-mcp"]}`. There is no local data; it calls `https://fojin.app/api`.
  - Self-hosting HTTP: `pip install 'fojin-mcp[http]'`. — [README](https://github.com/xr843/fojin/blob/main/mcp-server/README.md)
- **buddha-cli**
  - Install with `curl -fsSL https://raw.githubusercontent.com/sinryo/buddha-cli/main/scripts/bootstrap.sh | bash -s -- --yes --write-path`, or build with `cargo build --release -p buddha && scripts/install.sh --prefix "$HOME/.buddha" --write-path`.
  - Claude Code: `claude mcp add buddha "$HOME/.buddha/bin/buddha" mcp`. Needs Git and Rust/Cargo. — README
  - Data size: the install pulls the upstream corpora. GitHub repo sizes are cbeta-org/xml-p5 about 1.45 GB and VipassanaTech/tipitaka-xml about 0.79 GB ([gh API](https://github.com/cbeta-org/xml-p5)), so expect roughly 2+ GB on disk before GRETIL/SARIT (my estimate; buddha-cli may fetch less than the full git history).
- **lotus-wisdom**: `claude mcp add lotus-wisdom -- npx -y lotus-wisdom-mcp`, or `{"command": "npx", "args": ["-y", "lotus-wisdom-mcp"]}`. — README
- **dhamma.gift**: remote `https://api.dhamma.gift/mcp` (streamable-http), no install. — registry
- **sutta-mcp (nbkhoi)**: `git clone … && npm install && npm run build`, then `{"command":"node","args":["/abs/path/sutta-mcp/dist/index.js"]}`. — README

### Inferences
- In Claude Code `.mcp.json`, use `{"type":"http","url":...}` directly. The `mcp-remote` bridge in tripitaka's README exists only for Claude Desktop.

### Gaps
- I did not measure buddha-cli's actual on-disk footprint.

## Q3. Maintenance, popularity, security

### Takeaway
Actively maintained (pushed within the last week): tripitaka-mcp, fojin, buddha-cli, lotus-wisdom, sutta-mcp, dg-node. Abandoned: tendayspace/CbetaMCP and sacred-scriptures-mcp. DPD's MCP was archived on purpose. The main trust issue is that the hosted endpoints are run by pseudonymous single maintainers. Their tools are read-only text lookups, so the risk is limited to query privacy, availability, and prompt-injection text in responses. It is not credential or file access.

### Cited Findings
- Activity, contributor and star figures are as listed in Q1 (gh API, 2026-10-26).
- tripitaka-mcp production setup: read-only DB user, read-only filesystem, `cap_drop: ALL`, Caddy plus Cloudflare. Its privacy policy says queries are not logged. — README
- fojin hosted: read-only GETs, per-IP rate limit, Host-header validation, and it logs "one JSON line per request … and per tool call". — fojin mcp-server README
- lotus-wisdom hosted worker "records usage analytics". — README
- SuttaCentral asks that its content not be used to train AI (quoted in the sutta-mcp README). That concerns training, not live retrieval. — [sutta-mcp README](https://github.com/nbkhoi/sutta-mcp)
- tripitaka-mcp includes the Payutto dictionary under non-commercial-only terms. — README

### Inferences
- For "established, trustworthy" sourcing, prefer configurations where you can audit the code and run it locally: tripitaka-mcp pipx (MIT) and fojin via uvx (Apache-2.0, but it still calls the fojin.app API). Use the hosted endpoints for convenience.

### Gaps
- No independent security audit exists for any of these.

## Q4. Established generic fallback (coordinator request) and recommendations

### Takeaway
The only truly "popular and established" option is the official **`mcp-server-fetch`** from modelcontextprotocol/servers. It can reach SuttaCentral's JSON API, Access to Insight, and dpdict.net. Recommended set, in priority order: (1) official fetch, (2) tripitaka-mcp, (3) fojin, (4) optionally buddha-cli if CBETA/SAT/Tibetan depth is needed and a source build is acceptable. lotus-wisdom is optional and serves no scripture.

### Cited Findings
- modelcontextprotocol/servers has **91,564 stars**, 100+ contributors and 11,868 forks, last pushed 2026-10-25. PyPI `mcp-server-fetch` 2026.10.24 (MIT) had 506,506 downloads in the last month. — [repo](https://github.com/modelcontextprotocol/servers), [pypistats](https://pypistats.org/packages/mcp-server-fetch)
- Fetch config: `{"command": "uvx", "args": ["mcp-server-fetch"]}`. It obeys robots.txt for model-initiated fetches unless given `--ignore-robots-txt`. The default `max_length` is 5000 characters. — [fetch README](https://github.com/modelcontextprotocol/servers/tree/main/src/fetch)
- Reachability checks on 2026-10-26:
  - SuttaCentral robots.txt is `User-agent: * / Disallow:` (empty, so everything is allowed).
  - The SuttaCentral HTML page `suttacentral.net/mn1/en/sujato` is a JS app shell of about 9 KB. The JSON API `https://suttacentral.net/api/bilarasuttas/mn1/sujato?lang=en` returns the text and notes (HTTP 200), so point fetch at the API rather than the HTML.
  - Access to Insight pages return 200 (e.g. `/tipitaka/mn/mn.010.soma.html`). Its robots.txt URL serves a "Lost in samsara" 404 HTML page, so I could not confirm robots behaviour.
  - `dpdict.net/?q=sati` returns 200.

**Ready-to-paste `.mcp.json` (Claude Code)**:

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

Local/offline alternatives (auditable, no third-party host for tripitaka):

```json
{
  "mcpServers": {
    "tripitaka": { "command": "tripitaka-mcp", "args": ["serve"] },
    "fojin": { "command": "uvx", "args": ["fojin-mcp"] }
  }
}
```
(The tripitaka entry first needs `pipx install tripitaka-mcp && tripitaka-mcp init`. The fojin stdio entry still calls fojin.app.)

Optional, for CBETA/SAT/Tibetan depth (single-author Rust source build):

```json
{
  "mcpServers": {
    "buddha": { "command": "/Users/YOU/.buddha/bin/buddha", "args": ["mcp"] }
  }
}
```

Optional, for a contemplative-reasoning scaffold (no scripture):

```json
{
  "mcpServers": {
    "lotus-wisdom": { "command": "npx", "args": ["-y", "lotus-wisdom-mcp"] }
  }
}
```

### Inferences
- With the user's "popular/established only" constraint, a strict reading admits only `fetch`. A pragmatic reading adds tripitaka-mcp (MIT, official registry, highest Buddhist usage) and fojin (Apache-2.0, most stars, official registry), each with a single small team behind it. Both have a `verify_quote` tool, which suits an anti-hallucination tutor.
- Coverage map for a tutor:
  - Pāli/SuttaCentral: tripitaka (or fetch on the SC API).
  - Chinese, Tibetan and cross-canon parallels, plus glossaries and dictionaries: fojin.
  - Access to Insight and DPD: fetch only.
  - Full local CBETA/SAT: buddha-cli.
- `.mcp.json` HTTP entries prompt for project-scope approval in Claude Code. This is expected.

### Gaps
- I did not test Claude Code's actual connection to each HTTP endpoint. I only did raw JSON-RPC probes, which succeeded for tripitaka, fojin, dhamma.gift, jueban, wonbuddhism and lotus-wisdom.
- Access to Insight robots.txt status is unclear.
