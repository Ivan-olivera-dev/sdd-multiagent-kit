#!/usr/bin/env bash
set -euo pipefail

OPENCODE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
AGENTS_SKILLS_DIR="$HOME/.agents/skills"

echo "🧹 Desinstalando SDD Multiagent Kit..."

rm -rf "$AGENTS_SKILLS_DIR/init-sdd"
rm -rf "$OPENCODE_CONFIG_DIR/skills/init-sdd"
rm -f "$OPENCODE_CONFIG_DIR/agents/bootstrapper.md"
rm -f "$OPENCODE_CONFIG_DIR/commands/init-sdd.md"

echo "✅ Desinstalación completada."
