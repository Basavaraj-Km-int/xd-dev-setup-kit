# Design Prototype Template

A one-command scaffolding tool for Intuit Product Designers to create interactive UI prototypes powered by AI coding agents (Claude Code, Cursor, Windsurf, Copilot).

**No coding experience required.** Write your PRD, run the scaffold, open Claude Code, and start building.

---

## Quick Start

### Option A: Use as GitHub Template (Recommended)

1. Click **"Use this template"** at the top of this repo on GitHub
2. Name your new repo (e.g., `my-prototype`)
3. Clone your new repo and install dependencies:

```bash
git clone https://github.com/YOUR-USERNAME/my-prototype.git
cd my-prototype
npm install
```

### Option B: Scaffold with Script

```bash
git clone https://github.com/Basavaraj-Km-int/design-prototype-template.git
cd design-prototype-template
./scaffold.sh my-prototype-name
```

This creates a full Vite + React + TypeScript project with all template files, folder structure, and dependencies installed.

### Next: Fill in your PRD

Open `docs/PRD.md` and either:

- **Fill in the template sections** directly, or
- **Paste your existing PRD** from Google Docs (File > Download > Markdown) or Confluence

### Then: Start building with Claude Code

```bash
claude
```

Claude Code will:
1. Read your `docs/PRD.md`
2. Generate `docs/design.md` (problem statement, user flows, user stories)
3. Ask you to review before writing any code
4. Build the prototype screen-by-screen following the design system

---

## What You Get

### Project Structure

```
my-prototype-name/
├── CLAUDE.md                 # AI agent instructions (auto-loaded by Claude Code)
├── agents.md                 # Universal agent instructions (Cursor, Windsurf, etc.)
├── docs/
│   ├── PRD.md                # Your product requirements (you fill this in)
│   └── design.md             # Design artifacts (Claude Code helps generate this)
├── src/
│   ├── components/           # Custom prototype components
│   ├── pages/                # Page-level views
│   ├── layouts/              # Layout templates
│   ├── hooks/                # Custom React hooks
│   ├── mocks/
│   │   └── data/             # Mock JSON data (no backend needed)
│   ├── lib/                  # Utility functions
│   └── styles/               # Global styles
├── public/                   # Static assets (images, icons)
└── package.json
```

### Template Files

| File | Purpose | Who fills it in |
|------|---------|----------------|
| `docs/PRD.md` | Product requirements, user scenarios, success metrics | **You (the designer)** |
| `docs/design.md` | Customer problem statement, hypothesis, LOFAs, user flows, user stories | **Claude Code generates, you review** |
| `CLAUDE.md` | Instructions for Claude Code (IDS rules, accessibility, workflow) | **Pre-configured, no changes needed** |
| `agents.md` | Instructions for other agents (Cursor, Windsurf, Copilot) | **Pre-configured, no changes needed** |

---

## The Workflow

```
You write PRD  ──>  Claude Code generates design.md  ──>  You review
                                                              │
                          You iterate  <──  Claude Code builds prototype
```

### Step-by-step

1. **You** fill in `docs/PRD.md` with the user problem, solution vision, and requirements
2. **Claude Code** reads the PRD and generates `docs/design.md`:
   - Customer Problem Statement (D4D format)
   - Hypothesis with success metrics
   - Leap of Faith Assumptions (LOFAs)
   - User flows with entry/exit points for every screen
   - User stories with acceptance criteria
3. **You** review the design artifacts — add, change, or remove anything
4. **Claude Code** builds the prototype following the approved design:
   - Uses IDS components from the design system
   - Handles all states (loading, error, empty, disabled)
   - Makes it accessible (WCAG 2.1 AA)
   - Makes it responsive across breakpoints
5. **You** review in the browser, give feedback, Claude Code iterates

### With Figma

If you have Figma designs, share the Figma URL with Claude Code. It will:
- Read the design directly via Figma MCP
- Map Figma components to IDS code components
- Build pixel-accurate implementations

You can also send the running prototype back to Figma for review:
> "Capture the UI in a new Figma file"

---

## Common Commands

### Development

| Command | What it does |
|---------|-------------|
| `npm run dev` | Start the dev server (usually http://localhost:5173) |
| `npm run build` | Create a production build |
| `npm run preview` | Preview the production build locally |
| `npm run lint` | Check code for issues |

### Adding IDS Components

```bash
npm install @ids-ts/button @ids-ts/text-field @ids-ts/typography
```

Browse available components in the IDS Storybook or the local `int-design-system/` clone.

### Git (Saving Your Work)

| Command | What it does |
|---------|-------------|
| `git status` | See what files changed |
| `git add .` | Stage all changes |
| `git commit -m "description"` | Save a checkpoint |
| `git push` | Push to GitHub |
| `git checkout -b feature/name` | Create a new branch |
| `git stash` / `git stash pop` | Temporarily save / restore work |

---

## Using with Different AI Agents

This template works with any AI coding agent:

| Agent | Instructions file | Setup |
|-------|------------------|-------|
| **Claude Code** | `CLAUDE.md` | Auto-loaded. Just run `claude` in the project. |
| **Cursor** | Copy `agents.md` to `.cursorrules` | Cursor reads it automatically. |
| **Windsurf** | Copy `agents.md` to `.windsurfrules` | Windsurf reads it automatically. |
| **GitHub Copilot** | Copy `agents.md` to `.github/copilot-instructions.md` | Copilot reads it in chat. |
| **Bolt / v0 / Lovable** | Paste key sections from `agents.md` into the prompt | Re-paste for new conversations. |

---

## What the AI Agent Knows

The CLAUDE.md / agents.md files teach the AI agent to:

- **Solve user problems first** — extract the problem statement before writing code
- **Use IDS components** — import from `@ids-ts/*`, follow IDS prop conventions (`purpose`, `priority`, `size`)
- **Follow accessibility rules** — WCAG 2.1 AA, semantic HTML, keyboard navigation, ARIA
- **Handle all UI states** — default, hover, focus, disabled, loading, error, empty, skeleton
- **Follow Nielsen's heuristics** — feedback, consistency, error prevention, minimalism
- **Use Figma MCP** — read designs from Figma URLs, send prototypes back to Figma
- **Be safe** — never run destructive commands without your approval
- **Build incrementally** — types > mock data > atoms > molecules > organisms > layouts > polish

---

## Prerequisites

- **Node.js 18+** (check: `node --version`)
- **npm** (comes with Node.js)
- **Claude Code** (install: `npm install -g @anthropic-ai/claude-code`)
- **Git** (for version control)

### Optional

- **IDS Design System** clone at `int-design-system/` for component reference
- **Figma MCP** configured in Claude Code for design-to-code workflows

---

## FAQ

**Q: I'm not a developer. Can I use this?**
Yes. The template and AI agent instructions are designed for designers who don't code. Fill in the PRD, let Claude Code do the implementation.

**Q: Do I need a backend?**
No. All prototypes use mock data (JSON files). No servers, no databases.

**Q: Can I use my existing PRD from Google Docs?**
Yes. Download as markdown (File > Download > Markdown) and paste into `docs/PRD.md`.

**Q: What if IDS doesn't have a component I need?**
Claude Code will compose from IDS primitives first. If that's not possible, it builds a custom component and documents why.

**Q: How do I share the prototype with my team?**
Run `npm run build` and deploy the `dist/` folder, or share via a GitHub Pages / Vercel deploy.

**Q: Can I use this with Cursor instead of Claude Code?**
Yes. Copy `agents.md` to `.cursorrules` in the project root. Cursor reads it automatically.

---

## Template Contents

| File | Lines | Description |
|------|-------|-------------|
| `CLAUDE.md` | 273 | Claude Code instructions — IDS, Figma, accessibility, workflow |
| `agents.md` | 174 | Universal agent instructions — works with any coding agent |
| `docs/PRD.md` | 102 | PRD template with guided sections |
| `docs/design.md` | 149 | Design artifact template — Claude Code populates from PRD |
| `scaffold.sh` | 143 | One-command project bootstrapping script |

---

## Contributing

To update the template files, edit them in this repo and push. Every new project scaffolded with `./scaffold.sh` will pick up the latest versions.

For questions or feedback, reach out to the Design Technology team.
