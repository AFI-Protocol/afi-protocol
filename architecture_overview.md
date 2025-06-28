# AFI Protocol – Architecture Overview

Welcome, human or droid!  
This document gives you the 10 000‑ft view of how the **Agentic Financial Intelligence (AFI)** repos inter‑operate.

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
| **Agents/CLI** | Command entrypoints & persona logic       | `afi-agents`            |
| **Core**       | Validators, mentors, DAG logic            | `afi-core`              |
| **Infra**      | Signal templates & simulators             | `afi-infra`             |
| **Config**     | Codex definitions & persona schemas       | `afi-config`            |
| **Ops**        | Deployment scripts & health checks        | `afi-ops`               |
| **Docs**       | Human & droid documentation               | `afi-docs`              |

Droids should read `factory/agent_manifest.json` next. Happy hacking!
