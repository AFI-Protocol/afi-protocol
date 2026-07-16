# AFI Protocol

**Agentic Financial Intelligence (AFI)** is an open protocol for turning trading
signals — produced by human or agentic analysts — into scored, auditable,
replayable evidence. Every signal is normalized to a canonical form, scored by
version-pinned rules, and persisted with full provenance, designed so that any
independent party can verify exactly how a score was produced.

This repository is the **navigation map for the AFI organization**: what
defines the protocol, what implements it, what may be replaced, what exists
today, and where to begin. It is deliberately thin and carries no authority of
its own.

## Authority

Protocol authority lives in exactly three repositories:

| | Repository | What it holds |
|---|---|---|
| 1 | [afi-governance](https://github.com/AFI-Protocol/afi-governance) | Accepted protocol decisions — protocol law. Start at [`decisions/`](https://github.com/AFI-Protocol/afi-governance/tree/main/decisions). |
| 2 | [afi-config](https://github.com/AFI-Protocol/afi-config) | Canonical schemas, registries, conventions, and known-answer tests ([`kats/`](https://github.com/AFI-Protocol/afi-config/tree/main/kats)). |
| 3 | [afi-math](https://github.com/AFI-Protocol/afi-math) | Canonical deterministic math kernels and their golden vectors. |

Authority is exactly what the accepted decisions expressly delegate —
self-labeling confers nothing. If anything in this repository disagrees with a
governed artifact in those repositories, the governed artifact wins. This map
is not the schema home, not the math home, not a runtime, and not a substitute
for [afi-docs](https://github.com/AFI-Protocol/afi-docs).

## The protocol in brief

- **`signalId` is the canonical join key.** Every artifact about a signal —
  canonical form, score, evidence record — joins on it.
- **Strategy identity is the triple `analystId + strategyId + strategyVersion`**
  ([object-identity-v0.1](https://github.com/AFI-Protocol/afi-governance/blob/main/decisions/object-identity-v0.1.md)).
- **Canonical inbound signal form** is the Universal Signal Schema (USS) v1.1
  ([`schemas/usignal/`](https://github.com/AFI-Protocol/afi-config/tree/main/schemas/usignal)).
- **Scoring** runs the governed UWR (Universal Weighting Rule) engine. The
  protocol-recognized profile is version-pinned (testnet-provisional) in
  [`registries/uwr-profiles/`](https://github.com/AFI-Protocol/afi-config/tree/main/registries/uwr-profiles).
  Analysts may configure and run conforming UWR profiles, decay/Greeks
  surfaces, and strategy pipelines **without bespoke governance permission**;
  a profile becomes *protocol-recognized* only when registered and
  version-pinned in afi-config — a governed registry change.
- **Persistence** — the current canonical chain is
  **Gateway → Reactor → afi-infra → MongoDB**. Protocol law fixes the single
  write path: afi-infra owns the sole canonical persistence interface. The
  Gateway authenticates and routes to the Reactor; it never constructs or
  writes canonical evidence (guardrail-enforced).
- **Lifecycle** is the governed state machine
  `INGESTED → VALIDATED → SCORED → CERTIFIED → QUALIFIED → CHALLENGE_OPEN → [CONTESTED →] FINALIZED → EPOCH_ELIGIBLE`.
  **The implemented lifecycle currently reaches `SCORED`** — see
  [Implemented today](#implemented-today).

## Repository map

The organization is exactly 22 repositories.

### Protocol definition — independent implementations must conform (3)

| Repository | Role |
|---|---|
| [afi-governance](https://github.com/AFI-Protocol/afi-governance) | Accepted protocol decisions (`decisions/`) |
| [afi-config](https://github.com/AFI-Protocol/afi-config) | Canonical schemas, registries, conventions, KATs |
| [afi-math](https://github.com/AFI-Protocol/afi-math) | Canonical deterministic math kernels + golden vectors |

### Governed implementation — replaceable via the same contracts (6)

| Repository | Role |
|---|---|
| [afi-core](https://github.com/AFI-Protocol/afi-core) | Scoring library: governed UWR engine, profile loader, decay surfaces |
| [afi-reactor](https://github.com/AFI-Protocol/afi-reactor) | Scoring runtime: ingest → USS validation → scoring → UWR resolution → evidence construction → submission |
| [afi-infra](https://github.com/AFI-Protocol/afi-infra) | Canonical evidence store: `scored_signal_evidence` on MongoDB — unique `signalId`, append-once, transactional supersession |
| [afi-gateway](https://github.com/AFI-Protocol/afi-gateway) | External submission boundary: authenticates and routes to the Reactor; never writes evidence |
| [afi-mint](https://github.com/AFI-Protocol/afi-mint) | Mint/reward execution home (delegated; not live — see status) |
| [afi-token](https://github.com/AFI-Protocol/afi-token) | On-chain token enforcement (86B hard cap; testnet-proven) |

### Support and reference — optional, replaceable (6)

| Repository | Role |
|---|---|
| [afi-docs](https://github.com/AFI-Protocol/afi-docs) | Documentation hub |
| [afi-factory](https://github.com/AFI-Protocol/afi-factory) | Analyst-config types and fixtures |
| [afi-cli-framework](https://github.com/AFI-Protocol/afi-cli-framework) | CLI framework used by the gateway |
| [afi-skills](https://github.com/AFI-Protocol/afi-skills) | Skills content library |
| [afi-xerc20](https://github.com/AFI-Protocol/afi-xerc20) | Vendored xERC20 standard (dependency of afi-token) |
| afi-tiny-brains *(private)* | Optional fail-soft ML enrichment sidecar |

### Research and records — non-canonical (4)

| Repository | Role |
|---|---|
| [afi-econ](https://github.com/AFI-Protocol/afi-econ) | Economic research kit (non-canonical unless promoted by governance) |
| [afi-benchkit](https://github.com/AFI-Protocol/afi-benchkit) | Evaluation and benchmark harness |
| [afi-artifacts](https://github.com/AFI-Protocol/afi-artifacts) | Frozen, DOI-minted paper reproducibility bundle |
| afi-labs *(private)* | Research and prototyping |

### Organization surfaces (3)

| Repository | Role |
|---|---|
| afi-protocol | This map |
| [.github](https://github.com/AFI-Protocol/.github) | Organization profile and defaults |
| afi-ops *(private)* | Operational scripting |

## For independent implementers

A conforming AFI implementation must:

1. **Honor the accepted decisions** in
   [afi-governance/decisions/](https://github.com/AFI-Protocol/afi-governance/tree/main/decisions)
   — object identity (`signalId`, USS v1.1, the strategy triple), lifecycle,
   persistence, scoring pins, math authority, and economic law.
2. **Validate against the afi-config contracts** — the
   [`scored-signal-evidence` v1 schema](https://github.com/AFI-Protocol/afi-config/tree/main/schemas/scored-signal-evidence)
   and its published
   [valid/invalid vectors](https://github.com/AFI-Protocol/afi-config/tree/main/examples/scored-signal-evidence/v1/vectors),
   the pinned UWR profile values (testnet-provisional), and the
   [KAT vectors](https://github.com/AFI-Protocol/afi-config/tree/main/kats).
3. **Match the canonical math kernel outputs** for any component computing
   emissions, decay, or time value — the
   [afi-math](https://github.com/AFI-Protocol/afi-math) golden vectors and the
   afi-config KAT vectors (scoring and time decay).

Everything else may be replaced: any runtime honoring the same contracts and
handoffs, any store honoring `signalId`-keyed evidence semantics, any
submission boundary that submits rather than writes, and every support and
research component.

## Implemented today

The pipeline through scoring and persistence is implemented and proven by CI
against real infrastructure:

```
ingest → USS v1.1 validation → scoring (governed UWR engine, pinned profile)
       → thin evidence construction → submission
       → canonical store (unique signalId, append-once, transactional supersession)
```

**The implemented lifecycle currently reaches `SCORED`.**

Deliberately not implemented, or not yet governed:

- **Post-`SCORED` transitions** (`CERTIFIED`, `QUALIFIED`, challenge,
  `FINALIZED`) — the single finality writer is defined in law but
  intentionally unimplemented pending new authorization.
- **Epoch accounting and rewards** — no implemented owner.
- **Live mint orchestration** — governance-blocked: role weights and the
  settlement/epoch layer are not yet governed.
- **Mainnet settlement** — not yet governed.
- **An external read/API surface (“API Atlas”)** — reserved for future
  governance and not started. **There is no canonical API Atlas yet.**

## Districts

Exactly two Districts are formally registered
([authority-districts-v0.1](https://github.com/AFI-Protocol/afi-governance/blob/main/decisions/authority-districts-v0.1.md),
Part D); both are non-production:

- **District 1** — the pipehead proof-of-concept hosted in
  [afi-reactor](https://github.com/AFI-Protocol/afi-reactor).
- **District 2** — the data/provenance boundary: its M1 schema family is homed
  in [afi-config](https://github.com/AFI-Protocol/afi-config)
  ([`schemas/provenance/`](https://github.com/AFI-Protocol/afi-config/tree/main/schemas/provenance)),
  and its M2 surface in afi-reactor is prospectively ratified. The registry
  keeps District 2’s M1 authorization instrument
  ([D-17](https://github.com/AFI-Protocol/afi-docs/blob/main/reports/district-2-d17-implementation-authorization.md),
  homed in afi-docs) in force.

## Where to begin

| You are a… | Start with |
|---|---|
| **Developer** | [afi-reactor](https://github.com/AFI-Protocol/afi-reactor) (runtime) and [afi-core](https://github.com/AFI-Protocol/afi-core) (scoring library), then the contracts in [afi-config](https://github.com/AFI-Protocol/afi-config) |
| **Analyst / strategy author** | the [UWR profile registry](https://github.com/AFI-Protocol/afi-config/tree/main/registries/uwr-profiles) and [KATs](https://github.com/AFI-Protocol/afi-config/tree/main/kats) in afi-config; identity and configurability rules in [afi-governance decisions](https://github.com/AFI-Protocol/afi-governance/tree/main/decisions) |
| **Validator** | the [`scored-signal-evidence` v1 schema](https://github.com/AFI-Protocol/afi-config/tree/main/schemas/scored-signal-evidence) and its [vectors](https://github.com/AFI-Protocol/afi-config/tree/main/examples/scored-signal-evidence/v1/vectors) in afi-config; store semantics in [afi-infra](https://github.com/AFI-Protocol/afi-infra) |
| **Operator** | [afi-gateway](https://github.com/AFI-Protocol/afi-gateway) (submission boundary) and [afi-infra](https://github.com/AFI-Protocol/afi-infra) (canonical store); persistence decisions in [afi-governance](https://github.com/AFI-Protocol/afi-governance) |
| **Researcher** | [afi-docs](https://github.com/AFI-Protocol/afi-docs), [afi-econ](https://github.com/AFI-Protocol/afi-econ), [afi-benchkit](https://github.com/AFI-Protocol/afi-benchkit), and the frozen record in [afi-artifacts](https://github.com/AFI-Protocol/afi-artifacts) |

Contributions are welcome by fork and pull request in any public repository.
Conforming analyst pipelines need no permission — conformance is defined by the
contracts, registries, and KATs above.

## License

MIT — see [LICENSE](LICENSE).
