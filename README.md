# Design Prototype Template

A one-command scaffolding tool for Intuit Product Designers to create interactive UI prototypes powered by AI coding agents / Claude Code.

**No coding experience required.** Write your PRD, open Claude Code, and start building.

---

## Prerequisites (One-Time Setup)

Before using this template, make sure you have these installed on your Mac. If you don't, follow the links.

| Tool | Check if installed | Install |
|------|-------------------|---------|
| **Node.js 18+** | `node --version` | [Download Node.js](https://nodejs.org/) |
| **Git** | `git --version` | [Download Git](https://git-scm.com/downloads) |
| **Claude Code** | `claude --version` | `npm install -g @anthropic-ai/claude-code` |
| **GitHub CLI** | `gh --version` | `brew install gh` or [Download](https://cli.github.com/) |

### Authenticate with GitHub (One-Time)

You need to log in to **both** GitHub.com and Intuit's GitHub Enterprise:

```bash
# Public GitHub (for this template repo)
gh auth login

# Intuit GitHub Enterprise (for IDS design system)
gh auth login --hostname github.intuit.com
```

Each command opens a browser window — log in and authorize.

**If you can't use `gh`**, create a Personal Access Token:
1. Go to [github.intuit.com/settings/tokens](https://github.intuit.com/settings/tokens)
2. Click "Generate new token", select `repo` scope
3. Copy the token — you'll paste it when prompted for a password during `git clone`

---

## Quick Start

### Option A: Use as GitHub Template (Recommended)

1. Click **"Use this template"** button at the top of this repo
2. Name your new repo (e.g., `my-prototype`)
3. Open Terminal and run:

```bash
git clone https://github.com/YOUR-USERNAME/my-prototype.git
cd my-prototype
npm install
```

4. Clone the IDS design system (so Claude Code can read component docs):

```bash
git clone --depth 1 https://github.intuit.com/design-systems/ids-web.git int-design-system
```

### Option B: Scaffold with Script

```bash
git clone https://github.com/Basavaraj-Km-int/design-prototype-template.git
cd design-prototype-template
./scaffold.sh my-prototype-name
```

This creates a full project with all template files, folder structure, IDS clone, and dependencies installed automatically.

---

## How to Use

### Step 1: Fill in your PRD

Open `docs/PRD.md` in any text editor and either:

- **Fill in the template sections** directly, or
- **Paste your existing PRD** — download from Google Docs (File > Download > Markdown) or copy from Confluence

### Step 2: Open Claude Code

```bash
cd my-prototype
claude
```

### Step 3: Tell Claude Code to start

Type something like:

> "Read the PRD and create the design document, then build the prototype"

Claude Code will:
1. Read your `docs/PRD.md`
2. Generate `docs/design.md` — customer problem statement, hypothesis, LOFAs, user flows, user stories with acceptance criteria
3. **Ask you to review** before writing any code
4. Build the prototype screen-by-screen using IDS components

### Step 4: Review and iterate

- Claude Code starts the dev server — open the URL it shows (usually http://localhost:5173)
- Review in your browser
- Tell Claude Code what to change: "Make the header sticky", "Add an error state to the form", "The button should be destructive red"
- Claude Code makes the changes and you see them instantly

---

## Working with Figma

The template includes Figma integration via the official [Figma MCP](https://mcp.figma.com).

### Figma Design → Code

Share a Figma URL with Claude Code:

> "Implement this Figma design: https://figma.com/design/..."

Claude Code reads the design directly from Figma — extracts layout, spacing, components, styles — and builds it using IDS components.

### Code → Figma (Share with Your Team)

Send your running prototype to Figma for team review and iteration:

> "Start a local server for my app and capture the UI in a new Figma file"

Or send to an existing Figma file:

> "Capture the UI in https://figma.com/design/YOUR-FILE-URL"

Or copy to clipboard and paste into any Figma file:

> "Capture the UI to my clipboard"

**Tips for capturing:**
- Use the capture toolbar that appears in the browser to capture specific screens, elements, and states
- Capture each screen state separately: "Capture the dashboard empty state", "Now capture the dashboard with data"
- Capture the full user flow: "Capture onboarding step 1", "Also capture step 2 and step 3"
- Claude Code reuses the same Figma file within a conversation — just say "Also capture the settings page"
- Name captures clearly so your team can review: "Onboarding - Step 1", "Dashboard - Empty State"

This is NOT a handoff — it's a conversation artifact. Your team reviews in Figma, adds annotations, and you bring the feedback back to Claude Code for the next iteration.

### Both PRD + Figma

If you have both a PRD and Figma designs:

> "Read the PRD and the Figma design, then build the prototype"

Claude Code will cross-reference: are all PRD flows covered in Figma? Are all Figma screens traced to a user story? It flags any gaps.

---

## Everyday Commands

These are the commands you'll use most. Type them in Terminal.

### Running your prototype

| Command | What it does |
|---------|-------------|
| `npm run dev` | Start the prototype (opens in browser at http://localhost:5173) |
| `npm run build` | Create a production build |
| `claude` | Open Claude Code in the current project |

### Saving your work (Git)

| Command | What it does |
|---------|-------------|
| `git status` | See what files you changed |
| `git add .` | Prepare all changes to be saved |
| `git commit -m "what you changed"` | Save a checkpoint (like saving a Figma version) |
| `git push` | Upload your saved work to GitHub |

**Or just ask Claude Code:** "Commit my changes with a good message and push to GitHub"

### Branching (working on variations)

| Command | What it does |
|---------|-------------|
| `git checkout -b feature/new-idea` | Create a branch (like a Figma branch) |
| `git checkout main` | Go back to the main version |
| `git stash` / `git stash pop` | Temporarily hide / restore uncommitted changes |

### Undo mistakes

| Command | What it does |
|---------|-------------|
| `git stash` | Temporarily save and hide all your changes |
| `git stash pop` | Bring back your hidden changes |
| `git log --oneline -10` | See your last 10 saved checkpoints |

**Or just ask Claude Code:** "Undo the last change" or "Go back to how it was before"

---

## What You Get

### Project Structure

```
my-prototype/
├── CLAUDE.md                 # AI agent instructions (auto-loaded)
├── agents.md                 # Instructions for other agents (Cursor, etc.)
├── docs/
│   ├── PRD.md                # Your product requirements (you fill this in)
│   └── design.md             # Design artifacts (Claude Code generates this)
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
├── int-design-system/        # IDS component reference (local clone)
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

## The Design Workflow

```
You write PRD  ──>  Claude Code generates design.md  ──>  You review
                                                              │
       You iterate  <──  Claude Code builds prototype  <──────┘
            │
            └──>  Capture to Figma  ──>  Team reviews  ──>  You iterate
```

### What Claude Code does for you

- **Reads your PRD** and extracts the D4D artifacts (problem statement, hypothesis, LOFAs)
- **Maps user flows** — every screen, every decision point, every error path
- **Writes user stories** with acceptance criteria including error, loading, empty, and accessibility states
- **Picks IDS components** — reads the design system docs before using any component
- **Builds accessible** — WCAG 2.1 AA, keyboard navigation, screen reader support, all baked in
- **Handles all states** — not just the happy path: loading, error, empty, disabled, skeleton
- **Makes it responsive** — works on mobile (320px) through ultrawide (1920px)
- **Never runs dangerous commands** without asking you first

---

## What the AI Agent Knows

The CLAUDE.md / agents.md files teach the AI agent:

- **Problem-first mindset** — extract the problem statement before writing code (Intuit D4D framework)
- **IDS design system** — import from `@ids-ts/*`, follow IDS prop conventions, read component docs before using them
- **Figma integration** — read designs from Figma URLs, send prototypes back to Figma
- **Accessibility** — WCAG 2.1 AA, semantic HTML, keyboard navigation, ARIA, color contrast
- **All UI states** — default, hover, focus, disabled, loading, error, success, empty, skeleton
- **Nielsen's heuristics** — system feedback, consistency, error prevention, minimalism
- **Safety** — never run destructive commands (`rm -rf`, `git push --force`) without your explicit approval
- **Build order** — types > mock data > atoms > molecules > organisms > layouts > states > responsive > polish

---

## Using with Other AI Agents

This template works with any AI coding agent:

| Agent | Setup |
|-------|-------|
| **Claude Code** | Just run `claude` in the project. Reads `CLAUDE.md` automatically. |
| **Cursor** | Copy `agents.md` to `.cursorrules` in the project root. |
| **Windsurf** | Copy `agents.md` to `.windsurfrules` in the project root. |
| **GitHub Copilot** | Copy `agents.md` to `.github/copilot-instructions.md`. |
| **Bolt / v0 / Lovable** | Paste key sections from `agents.md` into your first prompt. |

---

## FAQ

**Q: I'm not a developer. Can I use this?**
Yes. This is designed for designers who don't code. Fill in the PRD, let Claude Code handle the implementation. The everyday commands section above covers everything you need.

**Q: Do I need a backend or database?**
No. All prototypes use mock data (JSON files). No servers, no databases, no API keys.

**Q: Can I use my existing PRD from Google Docs?**
Yes. In Google Docs: File > Download > Markdown (.md). Open the downloaded file, copy the content, paste into `docs/PRD.md`.

**Q: What if IDS doesn't have a component I need?**
Claude Code will compose from IDS primitives first. If that's not possible, it builds a custom component and documents why.

**Q: How do I share the prototype with my team?**
Three options:
1. **Figma** (recommended): Ask Claude Code "Capture the UI in a new Figma file" — your team reviews directly in Figma
2. **Live URL**: Ask Claude Code to deploy (e.g., via Vercel) for a shareable link
3. **Screen recording**: Run `npm run dev` and record your screen walking through the flows

**Q: The scaffold script can't clone IDS — what do I do?**
You need to authenticate with Intuit's GitHub first. Run `gh auth login --hostname github.intuit.com` and follow the browser prompts. Then clone manually: `git clone --depth 1 https://github.intuit.com/design-systems/ids-web.git int-design-system`

**Q: What do I do if something goes wrong?**
Ask Claude Code: "Something broke, can you fix it?" — it will diagnose and fix. If Claude Code itself is stuck, type `/clear` to start a fresh conversation in the same project.

---

## Template Contents

| File | Description |
|------|-------------|
| `CLAUDE.md` | Claude Code instructions — IDS, Figma, accessibility, D4D workflow |
| `agents.md` | Universal agent instructions — works with any coding agent |
| `docs/PRD.md` | PRD template with guided sections (or paste your own) |
| `docs/design.md` | Design artifact template — Claude Code populates from PRD |
| `scaffold.sh` | One-command project bootstrapping script |

---

## Contributing

To update the template files, edit them in this repo and push. Every new project scaffolded with `./scaffold.sh` will pick up the latest versions.

For questions or feedback, reach out to the Design Technology team.
