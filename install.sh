#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/Ivan-olivera-dev/sdd-multiagent-kit/main"

OPENCODE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
AGENTS_SKILLS_DIR="$HOME/.agents/skills"

echo "🚀 Instalando SDD Multiagent Kit (OpenCode + Agent Skills)..."
echo ""

mkdir -p "$OPENCODE_CONFIG_DIR/agents"
mkdir -p "$OPENCODE_CONFIG_DIR/commands"
mkdir -p "$OPENCODE_CONFIG_DIR/skills/init-sdd"
mkdir -p "$AGENTS_SKILLS_DIR/init-sdd"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || pwd)"

if [ -f "$SCRIPT_DIR/skills/init-sdd/SKILL.md" ]; then
  echo "📦 Copiando archivos desde el repositorio local..."
  cp "$SCRIPT_DIR/skills/init-sdd/SKILL.md" "$AGENTS_SKILLS_DIR/init-sdd/SKILL.md"
  cp "$SCRIPT_DIR/skills/init-sdd/SKILL.md" "$OPENCODE_CONFIG_DIR/skills/init-sdd/SKILL.md"
  cp "$SCRIPT_DIR/opencode/agents/bootstrapper.md" "$OPENCODE_CONFIG_DIR/agents/bootstrapper.md"
  cp "$SCRIPT_DIR/opencode/commands/init-sdd.md" "$OPENCODE_CONFIG_DIR/commands/init-sdd.md"
else
  echo "🌐 Descargando archivos desde GitHub ($REPO_RAW_URL)..."
  curl -fsSL "$REPO_RAW_URL/skills/init-sdd/SKILL.md" -o "$AGENTS_SKILLS_DIR/init-sdd/SKILL.md"
  cp "$AGENTS_SKILLS_DIR/init-sdd/SKILL.md" "$OPENCODE_CONFIG_DIR/skills/init-sdd/SKILL.md"
  curl -fsSL "$REPO_RAW_URL/opencode/agents/bootstrapper.md" -o "$OPENCODE_CONFIG_DIR/agents/bootstrapper.md"
  curl -fsSL "$REPO_RAW_URL/opencode/commands/init-sdd.md" -o "$OPENCODE_CONFIG_DIR/commands/init-sdd.md"
fi

echo ""
echo "✅ Instalación completada con éxito:"
echo "   • Skill global (Universal): $AGENTS_SKILLS_DIR/init-sdd/SKILL.md"
echo "   • Skill global (OpenCode):  $OPENCODE_CONFIG_DIR/skills/init-sdd/SKILL.md"
echo "   • Agente @bootstrapper:     $OPENCODE_CONFIG_DIR/agents/bootstrapper.md"
echo "   • Comando /init-sdd:        $OPENCODE_CONFIG_DIR/commands/init-sdd.md"
echo ""
echo "💡 ¿Cómo empezar un proyecto nuevo?"
echo "   1. mkdir mi-proyecto && cd mi-proyecto && opencode"
echo "   2. Escribe: /init-sdd Quiero crear una app de..."
