# AFI Protocol – Architecture Overview

Welcome, human or droid!  
This document gives you the 10 000‑ft view of how the **Agentic Financial Intelligence (AFI)** repos inter‑operate.

> **Canonical orchestration status:** AFI Reactor uses a **custom deterministic TypeScript DAG** (`afi-reactor/src/dag/`), not LangChain/LangGraph. See [`afi-docs/ARCHITECTURE_STATUS.md`](../afi-docs/ARCHITECTURE_STATUS.md). Superseded LangGraph-era plans live in [`afi-docs/archive/langgraph-migration-2025/`](../afi-docs/archive/langgraph-migration-2025/).

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
