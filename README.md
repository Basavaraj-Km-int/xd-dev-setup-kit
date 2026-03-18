# Design Prototype Template

A project template for Intuit Product Designers to create interactive UI prototypes powered by AI coding agents (Claude Code, Cursor, Windsurf, Copilot).

**No coding experience required.** Write your PRD, open Claude Code, and start building.

---

## Prerequisites (One-Time Setup)

You only need to do this once on your Mac. After that, every new project takes 2 minutes.

### Step 1: Install the tools

> **How to open Terminal on Mac**: Press `Cmd + Space`, type "Terminal", press Enter.

**1. Node.js 18+**

Run in Terminal:
```bash
node --version
```
If you see a version number (e.g., `v22.x.x`) — you're good, skip to the next tool.

If you see "command not found" — install it. Run in Terminal:
```bash
brew install node
```
> Don't have Homebrew? Install it first: go to [brew.sh](https://brew.sh/) and copy-paste the install command into Terminal.

Or [download from nodejs.org](https://nodejs.org/) — click the **LTS** button, run the installer. Then close and reopen Terminal.

**2. Git**

Run in Terminal:
```bash
git --version
```
If you see a version number (e.g., `git version 2.x.x`) — you're good, skip to the next tool.

If you see "command not found" — run in Terminal:
```bash
xcode-select --install
```
A popup appears — click **"Install"** and wait for it to finish.

**3. GitHub CLI**

Run in Terminal:
```bash
gh --version
```
If you see a version number — you're good, skip to the next tool.

If you see "command not found" — run in Terminal:
```bash
brew install gh
```
> Don't have Homebrew? Install it first: go to [brew.sh](https://brew.sh/) and copy-paste the install command into Terminal.

Or [download from cli.github.com](https://cli.github.com/).

**4. Claude Code**

Run in Terminal:
```bash
claude --version
```
If you see a version number — you're good.

If you see "command not found" — run in Terminal:
```bash
npm install -g @anthropic-ai/claude-code
```

### Step 2: Log in to GitHub (one-time)

Open Terminal and run:

```bash
gh auth login
```

A browser opens → click "Authorize" → come back to Terminal. That's it.

---

## Creating a New Project

### Scaffold with Script (Recommended)

One command creates the full project — Vite + React + TypeScript, all template files, IDS design system clone, and dependencies installed.

**Step 1: Download the template to your computer**

Open Terminal and run this command. It downloads the template into a folder called `design-prototype-template`:

```bash
git clone https://github.com/Basavaraj-Km-int/design-prototype-template.git
```

**Step 2: Go into the template folder**

```bash
cd design-prototype-template
```

**Step 3: Run the scaffold script to create your project**

This is where you choose your project's name. Pick a name that describes your prototype — use **lowercase letters and dashes** (no spaces).

Good names: `payroll-onboarding`, `expense-tracker-redesign`, `invoice-approval-flow`

Run the script with your chosen name:

```bash
./scaffold.sh your-project-name
```

For example, if you're prototyping a payroll onboarding flow:

```bash
./scaffold.sh payroll-onboarding
```

The script creates a **new folder** with your project name (e.g., `payroll-onboarding/`) right next to the template folder. Inside it:
- A React + TypeScript project ready to run
- CLAUDE.md and agents.md with all the design system rules
- Empty PRD and design doc templates for you to fill in
- IDS design system clone (for Claude Code to reference components)
- All dependencies installed

**Step 4: Go into your new project folder**

```bash
cd your-project-name
```

For the example above:

```bash
cd payroll-onboarding
```

> **Where is my project?** It's at `/Users/you/design-prototype-template/payroll-onboarding/`. You can also find it in Finder by navigating to your home folder.

**Step 5 (optional): Clean up the template folder**

You don't need the `design-prototype-template` folder anymore — your project is its own standalone folder now. You can keep it around for creating more projects later, or delete it:

```bash
cd ..
rm -rf design-prototype-template
```

**Done! Your project is ready.** Jump to [How to Use](#how-to-use) below.

---

### Manual Setup (If Script Doesn't Work)

If the scaffold script fails or you prefer to do it step by step:

<details>
<summary>Click to expand manual setup steps</summary>

**Step 1: Create your repo from the template**

1. Go to this repo on GitHub: [design-prototype-template](https://github.com/Basavaraj-Km-int/design-prototype-template)
2. Click the green **"Use this template"** button (top right)
3. Click **"Create a new repository"**
4. Fill in:
   - **Repository name**: Your project name (e.g., `payroll-onboarding-prototype`)
   - **Description** (optional): e.g., "Prototype for new payroll onboarding flow"
   - **Public or Private**: Choose Private for internal prototypes
5. Click **"Create repository"**

**Step 2: Clone it to your computer**

Open Terminal and run (replace `YOUR-USERNAME` and `your-project-name`):

```bash
git clone https://github.com/YOUR-USERNAME/your-project-name.git
cd your-project-name
```

**Step 3: Install dependencies**

```bash
npm install
```

Takes about 30 seconds.

**Step 4: Clone the IDS design system**

```bash
git clone --depth 1 https://github.intuit.com/design-systems/ids-web.git int-design-system
```

> If this fails, run `gh auth login --hostname github.intuit.com` first, then try again.

**Done!**

</details>

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

Make sure you're in your project folder in Terminal. If you just ran the scaffold, you're already there. If not:

```bash
cd your-project-name
```

Then start Claude Code:

```bash
claude
```

You'll see something like this appear in your Terminal:

```
╭──────────────────────────────────────────────╮
│ ✻ Welcome to Claude Code                     │
│                                              │
│   /help for help, /status for your plan      │
│                                              │
│   cwd: /Users/you/your-project-name          │
╰──────────────────────────────────────────────╯

>
```

The `>` is where you type your instructions to Claude Code. It has already read the `CLAUDE.md` file in your project, so it knows about the IDS design system, accessibility rules, D4D framework, and the Figma integration.

**If you see a permission prompt** — Claude Code may ask to read files or run commands. Type `y` (yes) to allow it. These are safe operations like reading your PRD or starting the dev server.

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

### Share via GitHub Pages (Free)

Host your prototype as a live website on GitHub — anyone with the link can view it.

1. Ask Claude Code: "Build the prototype and deploy to GitHub Pages"
2. Or do it manually:
   ```bash
   npm run build
   ```
3. Go to your repo on GitHub (e.g., `github.com/YOUR-USERNAME/your-project-name`)
4. Click **Settings** (tab at the top)
5. Click **Pages** (left sidebar)
6. Under **"Build and deployment"**, set **Source** to **"GitHub Actions"**
7. Your prototype will be live at: `https://YOUR-USERNAME.github.io/your-project-name/`
8. Share this URL with your team — no login required, works on any device

> **Tip:** Every time you `git push`, GitHub Pages automatically rebuilds and updates the live site.

### Share via screen recording

Record yourself walking through the prototype and share the video with your team.

**Option A: Quick screen recording (Mac built-in)**
1. Run `npm run dev` in Terminal (your prototype opens at http://localhost:5173)
2. Open the URL in your browser
3. Press `Cmd + Shift + 5` on your keyboard
4. Click **"Record Selected Portion"** in the toolbar that appears at the bottom
5. Drag to select your browser window
6. Click **"Record"**
7. Walk through all the flows in the prototype
8. Click the **stop button** in the menu bar (top right) when done
9. The recording saves to your Desktop as a `.mov` file — share it via Slack, email, or Google Drive

**Option B: QuickTime Player (more control)**
1. Run `npm run dev` in Terminal
2. Open **QuickTime Player** (press `Cmd + Space`, type "QuickTime", press Enter)
3. Click **File > New Screen Recording** in the menu bar
4. Click the dropdown arrow next to the record button to select audio options (if you want to narrate)
5. Click the **red record button**
6. Click your browser window to record just that window, or click anywhere to record the full screen
7. Walk through all the flows in the prototype
8. Click the **stop button** in the menu bar (top right) when done
9. **File > Save** — choose a name like "payroll-prototype-walkthrough.mov"
10. Share via Slack, email, or Google Drive

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
