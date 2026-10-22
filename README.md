# sdd-multiagent-kit

Herramienta para inicializar proyectos con Spec-Driven Development (SDD) y un sistema de cuatro agentes en OpenCode, Antigravity, Claude Code o Cursor.

En lugar de usar plantillas genéricas, el comando `/init-sdd` te hace una entrevista breve por rondas sobre tu idea (stack, reglas de negocio, runner de tests y modelos de IA que prefieres usar) y genera los archivos de contexto y los agentes adaptados a ese proyecto.

## Instalación

Para instalar la skill global `init-sdd`, el agente `@bootstrapper` y el comando `/init-sdd` en OpenCode y `~/.agents/skills`:

```bash
curl -fsSL https://raw.githubusercontent.com/Ivan-olivera-dev/sdd-multiagent-kit/main/install.sh | bash
```

Si prefieres clonar el repositorio antes de instalarlo:

```bash
git clone https://github.com/Ivan-olivera-dev/sdd-multiagent-kit.git
cd sdd-multiagent-kit
./install.sh
```

También puedes instalar únicamente la skill con el CLI de Agent Skills:

```bash
npx skills add Ivan-olivera-dev/sdd-multiagent-kit -g
```

Para desinstalarlo en cualquier momento, ejecuta `./uninstall.sh`.

## Cómo funciona

1. Creas una carpeta para tu nuevo proyecto y abres OpenCode:
   ```bash
   mkdir mi-proyecto && cd mi-proyecto
   git init
   opencode
   ```
2. Ejecutas `/init-sdd` con una descripción de lo que quieres construir:
   ```text
   /init-sdd Quiero hacer una aplicación web de gestión de inventario con Next.js, SQLite y Drizzle
   ```
   Si usas Antigravity, Claude Code o Cursor, pídele al asistente que cargue la skill `init-sdd`.
3. El agente te hace preguntas organizadas en tres rondas (producto, stack técnico y estrategia de tests junto con los modelos que quieres asignar a cada agente). Cada pregunta incluye una recomendación para que puedas responder "sí" o cambiar lo que necesites.
4. Al confirmar el resumen, genera la estructura del proyecto:
   - `docs/constitution.md`: reglas de negocio, estructura de carpetas, convenciones de nombres, comando de tests y restricciones del proyecto.
   - `AGENTS.md` y `MEMORY.md`: definición de los roles, flujo de trabajo y registro de decisiones.
   - `opencode.jsonc`: configuración del proyecto con `coordinator` como agente principal.
   - `.opencode/agents/`: cuatro agentes con permisos separados y los modelos que hayas elegido en la entrevista.
5. Por último, te pregunta si quieres que cree también el código base inicial (archivos de configuración, carpetas y primer test funcionando) y la primera especificación en `specs/001-mvp/spec.md`.

## Los cuatro agentes generados

El flujo de trabajo separa la conversación, el diseño, la programación y la revisión en cuatro agentes independientes:

| Agente | Rol | Permisos | Modelo recomendado |
| :--- | :--- | :--- | :--- |
| `coordinator` | Habla con el usuario y pasa el contexto entre fases. | Solo puede invocar a los tres subagentes. No edita archivos ni ejecuta comandos. | Modelo rápido (ej. Gemini 3.8 Flash, Claude Haiku, GPT-5 Mini). |
| `planner` | Redacta `spec.md` (formato EARS), `plan.md` y `tasks.md`. | Solo puede escribir dentro de `specs/**`. | Modelo de razonamiento (ej. Gemini 4 Argon, Claude Sonnet/Opus, GPT-5.2). |
| `implementer` | Ejecuta una única tarea de `tasks.md` por turno escribiendo primero los tests. | Puede editar código y ejecutar tests y builds. | Modelo de código potente (ej. Gemini 4 Argon, Claude Sonnet/Opus, GPT-5.2). |
| `reviewer` | Audita la spec en busca de casos límite y valida cada requisito sobre `git diff` y los tests. | Solo lectura, ejecución de tests y `git diff`. | Modelo de razonamiento (ej. Gemini 4 Argon, Claude Sonnet/Opus, GPT-5.2). |

## English guide

`sdd-multiagent-kit` sets up a Spec-Driven Development (SDD) workflow and a four-agent system for a new repository. Instead of copying static boilerplate rules, it interviews you in short rounds about your project, tech stack, test runner, and preferred AI models, then writes the configuration files and agent definitions for that specific setup.

### Installation

Install the global `init-sdd` skill, the `@bootstrapper` agent, and the `/init-sdd` slash command:

```bash
curl -fsSL https://raw.githubusercontent.com/Ivan-olivera-dev/sdd-multiagent-kit/main/install.sh | bash
```

Or install the skill alone through the Agent Skills CLI:

```bash
npx skills add Ivan-olivera-dev/sdd-multiagent-kit -g
```

### Usage

Open a new project folder in OpenCode and run:

```text
/init-sdd I want to build a local habit tracker with React, Express, and SQLite
```

The agent walks through three short rounds of questions:
1. Product scope and core domain rules.
2. Tech stack, database, and folder layout.
3. Test runner command, project constraints, and which models to assign to each agent (`coordinator`, `planner`, `implementer`, and `reviewer`).

Once you confirm the summary, it generates `docs/constitution.md`, `AGENTS.md`, `MEMORY.md`, `opencode.jsonc`, and the four agents under `.opencode/agents/`. It then asks if you also want the initial project scaffolding and `specs/001-mvp/spec.md`.

## Estructura del repositorio

```text
sdd-multiagent-kit/
├── skills/init-sdd/SKILL.md       # Skill para npx skills, OpenCode y Antigravity
├── init-sdd/SKILL.md              # Copia para el catálogo HTTP de OpenCode
├── opencode/
│   ├── agents/bootstrapper.md     # Agente global @bootstrapper
│   └── commands/init-sdd.md       # Comando /init-sdd para OpenCode
├── index.json                     # Índice del catálogo HTTP para OpenCode V2
├── install.sh                     # Script de instalación
├── uninstall.sh                   # Script de desinstalación
└── LICENSE                        # Licencia MIT
```

## Licencia

MIT © [Iván Olivera González](https://github.com/Ivan-olivera-dev)
