# Design Prototype Template

A project template for Intuit Product Designers to create interactive UI prototypes powered by AI coding agents (Claude Code, Cursor, Windsurf, Copilot).

**No coding experience required.** Write your PRD, open Claude Code, and start building.

---

## Prerequisites (One-Time Setup)

You only need to do this once on your Mac. After that, every new project takes 2 minutes.

### Step 1: Install the tools

| # | Tool | How to check if you have it | How to install |
|---|------|----------------------------|----------------|
| 1 | **Node.js 18+** | Open Terminal, type `node --version` | [Download from nodejs.org](https://nodejs.org/) — click the LTS button, run the installer |
| 2 | **Git** | `git --version` | [Download from git-scm.com](https://git-scm.com/downloads) — or on Mac: `xcode-select --install` |
| 3 | **GitHub CLI** | `gh --version` | `brew install gh` — or [Download from cli.github.com](https://cli.github.com/) |
| 4 | **Claude Code** | `claude --version` | Open Terminal, run: `npm install -g @anthropic-ai/claude-code` |

> **How to open Terminal on Mac**: Press `Cmd + Space`, type "Terminal", press Enter.

### Step 2: Log in to GitHub (one-time)

Open Terminal and run these two commands. Each one opens a browser window where you log in.

```bash
# Log in to public GitHub (where this template lives)
gh auth login
```
A browser opens → click "Authorize" → come back to Terminal.

```bash
# Log in to Intuit GitHub (where the design system lives)
gh auth login --hostname github.intuit.com
```
A browser opens → log in with your Intuit credentials → click "Authorize" → come back to Terminal.

**If the `gh` command doesn't work**, you can create a token manually:
1. Open [github.intuit.com/settings/tokens](https://github.intuit.com/settings/tokens) in your browser
2. Click **"Generate new token (classic)"**
3. Give it a name like "design-prototypes"
4. Check the **`repo`** checkbox
5. Click **"Generate token"** at the bottom
6. Copy the token (you'll need it when cloning — paste it when asked for a password)

---

## Creating a New Project

### Option A: GitHub Template (Recommended)

This is the easiest way. You click a button on GitHub and get a fresh project.

**Step 1: Create your repo from the template**

1. Go to this repo on GitHub: [design-prototype-template](https://github.com/Basavaraj-Km-int/design-prototype-template)
2. Click the green **"Use this template"** button (top right)
3. Click **"Create a new repository"**
4. Fill in:
   - **Repository name**: Your project name, e.g., `payroll-onboarding-prototype` or `expense-tracker-redesign`
   - **Description** (optional): Brief description, e.g., "Prototype for new payroll onboarding flow"
   - **Public or Private**: Choose Private for internal prototypes
5. Click **"Create repository"**

**Step 2: Clone it to your computer**

Open Terminal and run (replace `YOUR-USERNAME` and `your-project-name` with your actual values):

```bash
git clone https://github.com/YOUR-USERNAME/your-project-name.git
```

Example:
```bash
git clone https://github.com/Basavaraj-Km-int/payroll-onboarding-prototype.git
```

**Step 3: Go into the project folder**

```bash
cd your-project-name
```

Example:
```bash
cd payroll-onboarding-prototype
```

**Step 4: Install dependencies**

```bash
npm install
```

This downloads the libraries needed to run the prototype. Takes about 30 seconds.

**Step 5: Clone the IDS design system**

This gives Claude Code access to read IDS component documentation locally.

```bash
git clone --depth 1 https://github.intuit.com/design-systems/ids-web.git int-design-system
```

> If this fails with an authentication error, go back to "Log in to GitHub" in Prerequisites and make sure you completed the `gh auth login --hostname github.intuit.com` step.

**Done! Your project is ready.** Jump to [How to Use](#how-to-use) below.

### Option B: Scaffold with Script

If you prefer a single command that does everything (creates a Vite project, copies files, clones IDS, installs dependencies):

```bash
git clone https://github.com/Basavaraj-Km-int/design-prototype-template.git
cd design-prototype-template
./scaffold.sh your-project-name
```

Example:
```bash
./scaffold.sh payroll-onboarding-prototype
```

Then:
```bash
cd payroll-onboarding-prototype
```

**Done! Your project is ready.**

---

## How to Use

### Step 1: Fill in your PRD

Open the file `docs/PRD.md` in any text editor (VS Code, TextEdit, or even in GitHub).

**Option A**: Fill in the template sections directly — each section has `[placeholder]` text to replace.

**Option B**: Already have a PRD in Google Docs or Confluence?
1. In Google Docs: **File > Download > Markdown (.md)**
2. Open the downloaded `.md` file in any text editor
3. Select all (`Cmd + A`), copy (`Cmd + C`)
4. Open `docs/PRD.md`, select all, paste (`Cmd + V`)

### Step 2: Open Claude Code

In Terminal, make sure you're in your project folder, then:

```bash
claude
```

You'll see the Claude Code prompt `>` appear.

### Step 3: Tell Claude Code what to do

Type one of these prompts (or write your own):

**Starting from a PRD (most common):**
> Read the PRD in docs/PRD.md and create the design document, then build the prototype

**Starting from a Figma design:**
> Implement this Figma design using IDS components: https://figma.com/design/YOUR-FILE-URL

**Starting from both PRD + Figma:**
> Read the PRD and implement the Figma design: https://figma.com/design/YOUR-FILE-URL

Claude Code will:
1. Read your PRD (and/or Figma design)
2. Generate `docs/design.md` — customer problem statement, hypothesis, user flows, user stories
3. **Show you the design artifacts and ask for your approval** before writing any code
4. Build the prototype screen-by-screen using IDS components
5. Start the dev server so you can see it in your browser

### Step 4: Review in your browser

Claude Code will start a dev server and show you a URL (usually http://localhost:5173). Open it in your browser to see the prototype.

### Step 5: Iterate

Tell Claude Code what to change in plain language:

- "Make the header sticky"
- "Add a loading state to the dashboard"
- "The delete button should ask for confirmation first"
- "Show an empty state when there are no transactions"
- "Make it work on mobile"
- "The form validation should happen as I type, not when I click submit"

Claude Code makes the changes and you see them instantly in the browser.

---

## Sharing Your Prototype

### Share via Figma (Recommended)

Send the running prototype directly to Figma so your team can review and annotate:

> "Start a local server and capture the UI in a new Figma file"

Claude Code will:
1. Start the dev server
2. Open a browser with a capture toolbar
3. You click to capture screens, elements, and states
4. When done, Claude Code gives you a link to the Figma file

**More capture prompts you can use:**

| What you want | What to type in Claude Code |
|---------------|---------------------------|
| Capture to a new Figma file | "Capture the UI in a new Figma file" |
| Capture to an existing file | "Capture the UI in https://figma.com/design/YOUR-FILE-URL" |
| Capture to clipboard | "Capture the UI to my clipboard" |
| Capture a specific screen | "Capture the dashboard empty state" |
| Capture another screen (same file) | "Also capture the settings page" |
| Capture a specific element | Use the "Select element" button in the capture toolbar |

**Tips:**
- Capture each state separately: default, loading, empty, error, success
- Capture each step of the user flow as a separate screen
- Claude Code reuses the same Figma file within a conversation
- This is a conversation artifact, not a final handoff — your team annotates in Figma, you bring feedback back to Claude Code

### Share via URL

> "Deploy this prototype so I can share a link"

Claude Code can deploy to Vercel or similar services for a shareable URL.

### Share via screen recording

1. Run `npm run dev` in Terminal
2. Open the URL in your browser
3. Use Mac's built-in screen recording: `Cmd + Shift + 5` > "Record Selected Portion"
4. Walk through the flows and share the recording

---

## Working with Figma

### Figma → Code (Design to Prototype)

Share a Figma URL and Claude Code reads the design directly:

> "Implement this Figma design: https://figma.com/design/..."

It extracts layout, spacing, components, and styles from your Figma file and builds the prototype using IDS components.

### Code → Figma (Prototype to Design Review)

Send your running prototype back to Figma for team review — see [Share via Figma](#share-via-figma-recommended) above.

### PRD + Figma Together

If you have both:

> "Read the PRD and the Figma design, then build the prototype"

Claude Code cross-references: are all PRD flows covered in Figma? Are all Figma screens traced to a user story? It flags any gaps.

---

## Everyday Commands

These are the commands you'll use most. Type them in Terminal.

> **Pro tip:** You can ask Claude Code to run most of these for you. Just say "start the dev server" or "save my work and push to GitHub".

### Running your prototype

| What you want | Command | What it does |
|---------------|---------|-------------|
| Start the prototype | `npm run dev` | Opens in browser at http://localhost:5173 |
| Stop the prototype | Press `Ctrl + C` in Terminal | Stops the dev server |
| Open Claude Code | `claude` | Opens AI assistant in your project |

### Saving your work

Think of Git like Figma's version history — each commit is a saved version you can go back to.

| What you want | Command | Figma equivalent |
|---------------|---------|-----------------|
| See what changed | `git status` | Looking at the "Changes" indicator |
| Save a version | `git add .` then `git commit -m "what you changed"` | Saving a named version in version history |
| Upload to GitHub | `git push` | Publishing / syncing |
| See version history | `git log --oneline -10` | Opening version history panel |

**Or just ask Claude Code:** "Commit my changes with a good message and push to GitHub"

### Working on variations

| What you want | Command | Figma equivalent |
|---------------|---------|-----------------|
| Create a variation | `git checkout -b feature/new-idea` | Creating a Figma branch |
| Switch back to main | `git checkout main` | Switching back to the main file |
| Save changes for later | `git stash` | — |
| Bring back saved changes | `git stash pop` | — |

### Undo mistakes

| What you want | What to do |
|---------------|-----------|
| Undo recent changes | Ask Claude Code: "Undo the last change" |
| Start over on a file | Ask Claude Code: "Reset this file to how it was" |
| Go back to a previous version | Ask Claude Code: "Go back to the version before the header change" |

---

## What You Get

### Project Structure

```
your-project-name/
├── CLAUDE.md                 # AI agent instructions (auto-loaded, don't edit)
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
├── int-design-system/        # IDS component reference (local clone, not committed)
└── package.json
```

### What each file does

| File | What it is | Do you edit it? |
|------|-----------|----------------|
| `docs/PRD.md` | Your product requirements | **Yes — you fill this in** |
| `docs/design.md` | Problem statement, flows, stories | **Review what Claude Code generates** |
| `CLAUDE.md` | Rules for Claude Code | No — pre-configured |
| `agents.md` | Rules for other AI agents | No — pre-configured |
| `scaffold.sh` | Project setup script | No — only used once |
| `src/` folder | All the prototype code | Claude Code writes this |
| `int-design-system/` | IDS component docs | No — reference only |

---

## The Design Workflow

```
You write PRD  ──>  Claude Code generates design.md  ──>  You review & approve
                                                                │
       You iterate  <──  Claude Code builds prototype  <────────┘
            │
            └──>  Capture to Figma  ──>  Team reviews in Figma  ──>  You iterate
```

### What Claude Code does for you

- **Reads your PRD** and extracts D4D artifacts (problem statement, hypothesis, LOFAs)
- **Maps user flows** — every screen, every decision point, every error path
- **Writes user stories** with acceptance criteria including error, loading, empty, and accessibility states
- **Picks IDS components** — reads the design system docs before using any component
- **Builds accessible** — WCAG 2.1 AA, keyboard navigation, screen reader support, all baked in
- **Handles all states** — not just the happy path: loading, error, empty, disabled, skeleton
- **Makes it responsive** — works on mobile (320px) through ultrawide (1920px)
- **Never runs dangerous commands** without asking you first

---

## Using with Other AI Agents

This template works with any AI coding agent. Claude Code is recommended (reads `CLAUDE.md` automatically), but you can use others:

| Agent | How to set up |
|-------|--------------|
| **Claude Code** | Just run `claude` in the project folder. That's it. |
| **Cursor** | Open the project in Cursor. Copy `agents.md` → rename to `.cursorrules` in the project root. |
| **Windsurf** | Open the project in Windsurf. Copy `agents.md` → rename to `.windsurfrules` in the project root. |
| **GitHub Copilot** | Create folder `.github/` in project root. Copy `agents.md` → rename to `copilot-instructions.md` inside `.github/`. |
| **Bolt / v0 / Lovable** | Open `agents.md`, copy the first 5 sections, paste into your first prompt in the tool. |

---

## FAQ

**Q: I'm not a developer. Can I really use this?**
Yes. This is designed specifically for designers who don't code. You write the PRD in plain language, Claude Code handles all the implementation. The [Everyday Commands](#everyday-commands) section covers the few terminal commands you'll need.

**Q: Do I need a backend or database?**
No. All prototypes use mock data (JSON files). No servers, no databases, no API keys needed.

**Q: Can I use my existing PRD from Google Docs?**
Yes. In Google Docs: **File > Download > Markdown (.md)**. Open the downloaded file, copy the content, paste into `docs/PRD.md`. See [Step 1: Fill in your PRD](#step-1-fill-in-your-prd) for details.

**Q: What if IDS doesn't have a component I need?**
Claude Code will try to compose it from existing IDS components first. If that's not possible, it builds a custom component and documents why IDS was insufficient.

**Q: How do I share the prototype with my team?**
The easiest way: ask Claude Code "Capture the UI in a new Figma file". Your team reviews directly in Figma. See [Sharing Your Prototype](#sharing-your-prototype) for all options.

**Q: The script can't clone the IDS design system. What do I do?**
You need to authenticate with Intuit's GitHub. Open Terminal and run:
```bash
gh auth login --hostname github.intuit.com
```
Follow the browser prompts. Then try again:
```bash
git clone --depth 1 https://github.intuit.com/design-systems/ids-web.git int-design-system
```

**Q: Something broke. What do I do?**
Ask Claude Code: "Something broke, can you fix it?" — it will diagnose and fix the issue. If Claude Code itself seems stuck, type `/clear` to start a fresh conversation (your code is still there, only the conversation resets).

**Q: How do I update the template for future projects?**
New projects created from the template always get the latest version. Existing projects don't auto-update — to get updates, compare your `CLAUDE.md` and `agents.md` with the latest in this template repo.

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

To update the template files, edit them in this repo and push. Every new project created from this template will get the latest versions.

For questions or feedback, reach out to the Design Technology team.
