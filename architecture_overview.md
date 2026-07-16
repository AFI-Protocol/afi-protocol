# AFI Protocol – Architecture Overview

Welcome, human or droid!  
This document gives you the 10 000‑ft view of how the **Agentic Financial Intelligence (AFI)** repos inter‑operate.

> **Orchestration:** AFI Reactor is a **custom, deterministic TypeScript DAG orchestrator** (`afi-reactor/src/dag/` — `DAGBuilder`, `DAGExecutor`, `PluginRegistry`). Signals flow through typed **pipeheads** (`afi-reactor/src/pipeheads/`) with explicit `PipelineState` (`afi-reactor/src/types/dag.ts`), dependency ordering, and Codex-configured replay for auditability and reproducibility. See [`afi-docs/ARCHITECTURE_STATUS.md`](https://github.com/AFI-Protocol/afi-docs/blob/main/ARCHITECTURE_STATUS.md).

```
afi-protocol/
├─ contributor-manifest/      ← human‑facing governance & onboarding
├─ factory/                   ← droid/agent manifests live here
├─ diagrams/                  ← high level PNG/SVG diagrams (add as you build)
├─ *.md                       ← spec & overview docs
└─ README.md                  ← start here
```

Key Concepts
------------

| Layer          | Purpose                                   | Key Repos               |
| -------------- | ----------------------------------------- | ----------------------- |
| **Gateway**    | Optional Eliza client (not orchestrator)  | `afi-gateway`           |
| **Reactor**    | DAG orchestration (source of truth)       | `afi-reactor`           |
| **Core**       | Validators, mentors, scoring              | `afi-core`              |
| **Infra**      | Signal templates & simulators             | `afi-infra`             |
| **Config**     | Codex definitions & persona schemas       | `afi-config`            |
| **Ops**        | Deployment scripts & health checks        | `afi-ops`               |
| **Docs**       | Human & droid documentation               | `afi-docs`              |

Droids should read `factory/agent_manifest.json` next. Happy hacking!
