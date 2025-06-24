#!/bin/bash

# AFI Protocol Folder Scaffolding Script
# Creates canonical folder and file structure for AFI Protocol

mkdir -p AOS
mkdir -p AFI-Codex
mkdir -p agents/scoring-agents/scoring-categories/{technical,pattern,sentiment,news-social,ai-ml}
mkdir -p agents/pipeline-agents
mkdir -p agents/dao-validators
mkdir -p droids
mkdir -p tssd-vault
mkdir -p layerzero/oft
mkdir -p cli/commands
mkdir -p cli/utils
mkdir -p playground/modal
mkdir -p playground/ghost-agent/persona-profiles
mkdir -p schemas
mkdir -p docs

# Optional placeholder files
touch AOS/README.md
touch AFI-Codex/README.md
touch agents/scoring-agents/dual-weight-engine.ts
touch agents/scoring-agents/scoring-agent.droid.yaml
touch agents/pipeline-agents/enrichment-pipeline.droid.yaml
touch agents/pipeline-agents/modular-enrichment-logic.ts
touch agents/dao-validators/tssd-validator.droid.yaml
touch agents/dao-validators/validator-governance-interface.ts
touch agents/dao-validators/validator-constitution.md
touch droids/factory.droid.yaml
touch droids/scoring-agent.droid.yaml
touch droids/pipeline-agent.droid.yaml
touch droids/tssd-validator.droid.yaml
touch droids/manifest.json
touch tssd-vault/vault-logic.ts
touch tssd-vault/signal-indexing-schema.json
touch tssd-vault/vault-access-control.md
touch layerzero/oft/oftv2-token.sol
touch layerzero/oft/minting-logic.ts
touch layerzero/oft/zro-config.json
touch layerzero/cross-chain-agent.md
touch cli/afi-cli.ts
touch cli/commands/deploy-agent.ts
touch cli/commands/signal-submit.ts
touch cli/commands/dao-proposal.ts
touch cli/utils/prompt-helper.ts
touch playground/modal/proof-of-intelligence.ts
touch playground/modal/breach-proof-of-insight.ts
touch playground/modal/demo-scenarios.md
touch playground/ghost-agent/voice-interface.ts
touch playground/ghost-agent/ghost-config.json
touch schemas/universal-signal-schema.json
touch schemas/universal-proposal-schema.json
touch schemas/enrichment-categories.schema.ts
touch schemas/signal-category-weights.schema.ts
touch LICENSE.md
touch README.md

echo "✅ AFI Protocol folder structure created successfully."
