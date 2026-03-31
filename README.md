# XD Dev Setup Kit

AI-powered prototyping environment for Intuit Product Designers. Scaffold a project, write your PRD, and let Claude Code build the prototype with **100% IDS (Intuit Design System) parity**.

**No coding experience required.** Write your PRD, open Claude Code, and start building.

---

## What This Template Does

1. Scaffolds a **Vite + React 18 + TypeScript** project
2. Installs **IDS components** (`@ids-ts/button`, `@ids-ts/badge`, `@ids-ts/typography`)
3. Downloads **real IDS design tokens** from the Intuit CDN
4. Configures **PostCSS** to match the IDS build pipeline
5. Sets up **Storybook** with IDS theming for component docs, visual testing, and frontend handover
6. Sets up **CLAUDE.md** with instructions for AI-assisted prototyping
7. Sets up **Storybook MCP proxy** for AI-powered component lookup (no IDS clone needed)
8. Provides **admin UI overrides** (softer shadows/borders for dashboards)

Your prototype uses the same components and tokens that developers use in production.

---

## Prerequisites (One-Time Setup)

You only need to do this once. There are two ways:

### Option A: Let Claude Code check everything for you (Recommended)

If you already have Claude Code installed, open Terminal and run:

```bash
claude
```

Then paste this prompt:

> Check if my machine is ready for IDS prototyping. Verify: Node.js 18+, Git, GitHub CLI, and that ~/.npmrc has the Intuit npm registry configured. For anything missing, install it for me or tell me exactly what to do.

Claude Code will check each tool and either install what's missing or give you one-click instructions.

> **Don't have Claude Code yet?** Install it first: open Terminal (`Cmd + Space`, type "Terminal", press Enter) and run `npm install -g @anthropic-ai/claude-code`. If that fails with "npm not found", install Node.js first from [nodejs.org](https://nodejs.org/) (click the LTS button).

### Option B: Check manually (if you prefer)

<details>
<summary>Click to expand manual setup steps</summary>

> **How to open Terminal on Mac**: Press `Cmd + Space`, type "Terminal", press Enter.

**1. Node.js 18+**

```bash
node --version
```
If you see a version number (e.g., `v22.x.x`) — you're good. Otherwise:
```bash
brew install node
```
> Don't have Homebrew? Go to [brew.sh](https://brew.sh/) and copy-paste the install command.

**2. Git**

```bash
git --version
```
If you see "command not found":
```bash
xcode-select --install
```

**3. GitHub CLI**

```bash
gh --version
```
If not installed:
```bash
brew install gh
```

**4. Claude Code**

```bash
claude --version
```
If not installed: `npm install -g @anthropic-ai/claude-code` or follow [claude.ai/code](https://claude.ai/code)

**5. Figma plugin for Claude Code** (enables canvas read/write and 7 design skills)

```bash
claude plugin install figma@claude-plugins-official
```
Authenticate when prompted (opens Figma in browser).

**6. Intuit npm registry**

```bash
cat ~/.npmrc
```
You should see `registry=https://registry.npmjs.intuit.com/`. If not:
```bash
echo "registry=https://registry.npmjs.intuit.com/" >> ~/.npmrc
```

**7. Intuit GitHub auth** (only needed if cloning IDS repo directly)

```bash
gh auth login --hostname github.intuit.com
```

</details>

> **Note**: The scaffold script (`./scaffold.sh`) handles everything AFTER these tools are installed — it creates the project, installs IDS packages, downloads tokens, and sets up the MCP proxy. You don't need to do any of that manually.

---

## How It Works (The Full Flow)

```
┌─────────────────────────────────────────────────────────────────────┐
│  Step 1         Step 2          Step 3           Step 4             │
│  Clone       →  Scaffold     →  Write PRD     →  Open Claude Code  │
│  template       (sets up        (your product     (AI reads PRD,    │
│  repo           everything)     requirements)     generates design, │
│                                                   builds prototype) │
└─────────────────────────────────────────────────────────────────────┘
```

| Step | Who does it | What happens |
|------|------------|-------------|
| 1. Clone template | **You** | Downloads the template files (CLAUDE.md, scaffold.sh, empty PRD, empty design.md) |
| 2. Run scaffold | **You** (one command) | Installs React, IDS components, downloads brand tokens, creates folder structure, sets up MCP proxy |
| 3. Write PRD | **You** | Fill in `docs/PRD.md` with your product requirements (or paste from Google Docs) |
| 4. Open Claude Code | **You** | Paste one prompt — Claude Code takes over from here |
| 5. Generate design.md | **Claude Code** | Reads your PRD → generates problem statement, user flows, user stories in `docs/design.md` |
| 6. Review design | **You** | Check the generated design doc — approve, adjust, or add missing flows |
| 7. Build prototype | **Claude Code** | Builds the prototype screen-by-screen using IDS components |
| 8. Review & iterate | **You + Claude Code** | Review in browser, give feedback, Claude Code makes changes |

---

## Quick Start

### Step 1: Clone the template and run scaffold

Open Terminal and **copy-paste this entire block** (replace `my-prototype` with your project name):

```bash
git clone https://github.com/Basavaraj-Km-int/xd-dev-setup-kit.git my-prototype && cd my-prototype && chmod +x scaffold.sh && ./scaffold.sh
```

Examples:
```bash
# For a payroll project:
git clone https://github.com/Basavaraj-Km-int/xd-dev-setup-kit.git payroll-onboarding && cd payroll-onboarding && chmod +x scaffold.sh && ./scaffold.sh

# For an expense tracker:
git clone https://github.com/Basavaraj-Km-int/xd-dev-setup-kit.git expense-tracker && cd expense-tracker && chmod +x scaffold.sh && ./scaffold.sh
```

> Use lowercase with dashes for the name, no spaces. This is the **only Terminal command you need** — it clones, enters the folder, and runs the full setup.

This takes ~2 minutes. The script:
- Creates a React + TypeScript project with Vite
- Installs IDS components (Button, Badge, Typography, Loader)
- Downloads design tokens for all 6 Intuit brands
- Sets up PostCSS to match the IDS build pipeline
- Creates the Storybook MCP proxy for component lookup
- Sets up Storybook with IDS theming, MCP addon, and story template
- Writes starter files with accessibility baked in

**After this step, your project is fully set up.** You don't need to run any more install commands.

### Step 2: Write your PRD

Open `docs/PRD.md` and fill in your product requirements.

- **Option A**: Fill in the template sections directly
- **Option B**: Paste from Google Docs (File > Download > Markdown). Then run `./clean-prd.sh` to extract embedded images.

> **This is the only file YOU need to write.** Everything else is generated or pre-configured.

### Step 3: Open Claude Code and start

Open Claude Code in VS Code (`Cmd + Shift + P` → "Claude Code: Open"), or in Terminal:

```bash
claude
```

Then paste this prompt:

> Read docs/PRD.md and create the design document in docs/design.md with customer problem statement, hypothesis, LOFAs, user flows, and user stories. Show me the design doc for review before writing any code.

**Claude Code will:**
1. Read your PRD
2. Generate `docs/design.md` — problem statement, hypothesis, user flows, user stories with acceptance criteria
3. **Show you the design doc and wait for your approval**
4. After you approve, build the prototype screen-by-screen using IDS components
5. Start the dev server so you can review in your browser

### Step 4: Review, iterate, share

- Review the prototype in your browser (http://localhost:5173)
- Tell Claude Code what to change in plain language
- When ready, capture to Figma: "Capture the UI in a new Figma file"

> **Need more prompts?** See [docs/claude-code-prompts.md](docs/claude-code-prompts.md) — a complete collection of copy-paste prompts for every step: setup, building, fixing issues, saving, sharing, and more.

---

## Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **Framework** | React | 18.2.0 |
| **Bundler** | Vite | 8.x |
| **Language** | TypeScript | 5.9.x |
| **Design System** | IDS (`@ids-ts/*`) | 5.153.x |
| **Tokens** | IDS CDN (6 brands: Intuit, TurboTax, QuickBooks, Mailchimp, Credit Karma, Mint) | 24.5.0 |
| **CSS** | CSS Modules + PostCSS | — |
| **Routing** | React Router | 7.x |
| **PostCSS** | postcss-mixins, postcss-nested, postcss-simple-vars | Matches IDS |
| **Storybook** | Storybook + @storybook/addon-mcp | 8.x |
| **Mocking** | MSW (Mock Service Worker) | 2.x |

---

## Project Structure

```text
my-prototype/
├── CLAUDE.md                 # AI agent instructions (read this!)
├── docs/
│   ├── PRD.md                # Your product requirements
│   ├── design.md             # Generated design document
│   └── claude-code-prompts.md # Copy-paste prompts for every step
├── src/
│   ├── components/           # Custom components
│   ├── pages/                # Page views
│   ├── layouts/              # Layout templates
│   ├── hooks/                # Custom React hooks
│   ├── mocks/data/           # Mock data fixtures
│   ├── lib/                  # Types & utilities
│   └── styles/
│       ├── ids-tokens.css    # Active brand tokens (default: Intuit)
│       ├── tokens/           # All brand tokens (intuit, turbotax, quickbooks, mailchimp, creditkarma, mint)
│       ├── ids-overrides.css # Admin UI adjustments
│       ├── ids-imports.css   # IDS component CSS
│       └── global.css        # Base styles
├── .storybook/
│   ├── main.ts               # Storybook config (framework, addons, stories glob)
│   └── preview.tsx            # IDS theme wrapper + token imports
├── ids-storybook-mcp-proxy/  # Storybook MCP proxy (5MB, no IDS clone needed)
├── vite.config.ts            # Vite with IDS optimizations
├── postcss.config.js         # Matches IDS build pipeline
└── package.json
```

---

## IDS Components

### Components That Work Out of the Box

These IDS components render correctly in Vite with full visual parity:

```typescript
import Button from '@ids-ts/button';
import Badge from '@ids-ts/badge';
import { H4, H5, B2, B3 } from '@ids-ts/typography';
import { Activity, Progress } from '@ids-ts/loader';
```

### Components That Need Alternatives

These IDS components have CSS Module hash conflicts with Vite. Use custom components styled with IDS token variables instead:

| IDS Component | Issue | Alternative |
|---|---|---|
| `@ids-ts/table` | CSS hashes don't match | `<table>` with IDS token CSS variables |
| `@ids-ts/dropdown` | Heavy deps, CSS hash issues | Custom `Select` component (see `src/components/Select.tsx`) |
| `@ids-ts/text-field` | LightningCSS can't parse CSS | `<input>` styled with IDS tokens |

### Typography Scale for Admin UIs

IDS H1-H3 are designed for marketing pages (48-84px). For admin/dashboard UIs:

| Use | Component | Size |
|-----|-----------|------|
| Page title | `<H4>` | 28px |
| Section title | `<H5>` | 24px |
| Body text | `<B2>` | 16px |
| Small text | `<B3>` | 14px |
| Labels | `<B3>` or custom | 12-14px |

### Adding More IDS Components

```bash
npm install @ids-ts/checkbox @ids-ts/radio @ids-ts/switch @ids-ts/modal-dialog
```

Always check the Storybook first: `get-documentation("components-checkbox")`

---

## IDS Storybook (Component Reference)

### Option A: Platform Context MCP (Easiest — hosted, no setup)

The IDS team provides a hosted MCP server with all component docs. No local setup needed.

**One-time setup** — add to Claude Code:

```bash
claude mcp add platform-context -- npx mcp-remote@next https://mcp-platform.netlify.app/mcp
```

Ask Claude Code: "How do I use the trowser component?" or "Show me how to implement the space tokens"

### Option B: Storybook MCP Proxy (Created by scaffold)

The scaffold (`./scaffold.sh`) automatically creates an `ids-storybook-mcp-proxy/` folder in your project. It fetches component docs from the hosted IDS CDN.

**Start the proxy (before each session):**

```bash
cd ids-storybook-mcp-proxy
node server.js
```

You'll see:
```
IDS Storybook MCP Proxy
MCP server ready at: http://localhost:6007/mcp
```

**Connect Claude Code (one-time per project):**

```bash
claude mcp add ids-storybook --transport http http://localhost:6007/mcp
```

Claude Code can now look up any IDS component:
- `list-all-documentation` — see all 68+ components
- `get-documentation("components-button")` — get exact props, variants, code examples
- `get-documentation-for-story` — get specific story variant code

### Option B: Hosted Storybook (Browse in browser)

Open in browser — no setup needed, but only for human reference (Claude Code can't query it programmatically):
```
https://uxfabric.intuitcdn.net/internal/design-systems/ids-web/main/latest/index.html
```

### Option C: Local IDS Clone (Fallback — heavy, 450MB+)

Only if you need the full IDS source code:

```bash
git clone --depth 1 https://github.intuit.com/design-systems/ids-web.git ids-web-full
cd ids-web-full && yarn build && yarn dev
claude mcp add storybook-mcp --transport http http://localhost:6006/mcp --scope project
```

---

## Commands

```bash
# Development
npm run dev              # Start dev server (http://localhost:5173)
npm run storybook        # Start Storybook (http://localhost:6006)
npm run build            # Production build (fast navigation)
npm run build-storybook  # Build Storybook for deployment/sharing
npm run preview          # Preview production build (http://localhost:4173)
npm run lint             # Lint code

# IDS Tokens (re-download if needed)
curl -s "https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/intuit.css" > src/styles/ids-tokens.css

# Git (for designers)
git status               # See what changed
git add .                # Stage all changes
git commit -m "message"  # Save a checkpoint
git push                 # Push to remote
```

### Dev Server vs Production Build

| | Dev Server (`npm run dev`) | Production (`npm run build && npm run preview`) |
|---|---|---|
| **Use for** | Active coding with hot reload | Demos, stakeholder reviews |
| **Navigation speed** | Slower (Vite compiles on-demand) | Instant (<160ms) |
| **URL** | `http://localhost:5173` | `http://localhost:4173` |

---

## Storybook (Component Documentation + Visual Testing)

Every custom component gets a `.stories.tsx` file alongside its source. Storybook serves as:

- **Component catalog**: Browse every component with interactive controls (props, states, themes)
- **Visual testing**: Review all states (default, hover, error, empty, loading) in isolation
- **Frontend handover**: Engineers can inspect exact props, tokens, and behavior before building
- **MCP addon**: Claude Code can generate and preview stories via `@storybook/addon-mcp`

### Quick Start

```bash
npm run storybook        # Start at http://localhost:6006
npm run build-storybook  # Build static site for sharing
```

### Writing Stories for Custom Components

Copy the template: `src/components/.story-template.tsx`

```tsx
// src/components/StatusBadge/StatusBadge.stories.tsx
import type { Meta, StoryObj } from '@storybook/react';
import StatusBadge from './StatusBadge';

const meta = {
  title: 'Components/StatusBadge',
  component: StatusBadge,
  tags: ['autodocs'],
  argTypes: {
    status: { control: 'select', options: ['active', 'pending', 'error'] },
  },
} satisfies Meta<typeof StatusBadge>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Active: Story = { args: { status: 'active' } };
export const Pending: Story = { args: { status: 'pending' } };
export const Error: Story = { args: { status: 'error' } };
```

### IDS Theme in Storybook

The `.storybook/preview.tsx` loads IDS tokens and wraps every story in `<div data-theme="intuit" data-colorscheme="light">`. Components render with full IDS visual parity — same as the dev server.

---

## MCP Servers (AI Agent Integration)

These MCP servers enhance Claude Code's capabilities:

| MCP Server | Purpose | Setup Command |
|---|---|---|
| **Platform Context MCP** | Look up IDS component docs (hosted, no setup) | `claude mcp add platform-context -- npx mcp-remote@next https://mcp-platform.netlify.app/mcp` |
| **Storybook MCP Proxy** | Component docs from CDN (created by scaffold) | `cd ids-storybook-mcp-proxy && node server.js` then `claude mcp add ids-storybook --transport http http://localhost:6007/mcp` |
| **Figma MCP** | Read/write Figma designs, capture UI to canvas | `claude mcp add --transport http figma-remote-mcp https://mcp.figma.com/mcp` |

### Figma Plugin (One-Time Global Install)

The Figma plugin bundles 7 skills that teach Claude Code how to work with Figma effectively:

```bash
claude plugin install figma@claude-plugins-official
```

This installs once globally — works across all projects. Skills included:

| Skill | What it does |
|---|---|
| `figma-use` | Foundational skill for all canvas write operations |
| `figma-generate-design` | Capture live UI from dev server into Figma |
| `figma-implement-design` | Translate Figma designs into production code |
| `figma-generate-library` | Build design system libraries in Figma |
| `figma-create-design-system-rules` | Create governance rule files for code generation |
| `figma-code-connect-components` | Connect Figma components to `@ids-ts/*` code |
| `figma-create-new-file` | Create new Figma Design or FigJam files |

After installing, authenticate when prompted (browser OAuth flow). Skills load automatically when Claude Code detects relevant Figma operations — no per-project setup needed.


---

## Known Issues & Workarounds

### IDS CSS Module Hashes
IDS components are pre-built with specific CSS Module hashes. Vite generates different hashes, so some components' prop-driven styling doesn't work. **Workaround**: Use IDS Button/Badge/Typography (JS-driven) directly. For Table/Dropdown/TextField, use custom components styled with IDS token CSS variables.

### IDS ThemeProvider
The `@design-systems/theme` ThemeProvider tries to fetch tokens from an internal CDN that isn't accessible standalone. **Workaround**: Use `<div data-theme="intuit" data-colorscheme="light">` wrapper + downloaded CDN tokens.

### Vite Dev Server Performance
With 60+ IDS transitive dependencies, Vite dev mode can be slow on first navigation (compiles each module on-demand). **Workaround**: Use `npm run build && npm run preview` for demos. Add IDS packages to `optimizeDeps.include` in vite.config.ts.

### TextField CSS Build Error
`@ids-ts/text-field` CSS has `::before` pseudo-element syntax that LightningCSS (Vite 8) can't minify. **Workaround**: Don't import `@ids-ts/text-field/dist/main.css`. Use custom `<input>` with IDS tokens.

---

## Design Token Overrides

The CDN tokens are designed for full Intuit product pages. For admin/dashboard prototypes, `src/styles/ids-overrides.css` provides:

- **Softer shadows**: `rgba(0,0,0,0.04)` instead of `rgba(0,0,0,0.2)`
- **Softer borders**: `#E3E5E8` instead of `#8D9096`
- **Softer dividers**: `#F0F2F4` instead of `#BABEC5`

Edit this file to adjust the visual feel for your prototype.

---

## Multi-Brand Theming

IDS supports all Intuit brands. The scaffold downloads tokens for all 6 brands to `src/styles/tokens/`:

| Brand | File | `data-theme` | Use for |
|-------|------|-------------|---------|
| **Intuit** (default) | `tokens/intuit.css` | `intuit` | Intuit corporate, cross-product |
| **TurboTax** | `tokens/turbotax.css` | `turbotax` | TurboTax product UIs |
| **QuickBooks** | `tokens/quickbooks.css` | `quickbooks` | QuickBooks product UIs |
| **Mailchimp** | `tokens/mailchimp.css` | `mailchimp` | Mailchimp product UIs |
| **Credit Karma** | `tokens/creditkarma.css` | `creditkarma` | Credit Karma product UIs |
| **Mint** | `tokens/mint.css` | `mint` | Mint product UIs |

All brands support `light` and `dark` color schemes.

### How to Switch Brand

**Step 1**: Change the token import in `src/main.tsx`:

```tsx
// Default: Intuit
import './styles/ids-tokens.css'

// To use TurboTax instead:
import './styles/tokens/turbotax.css'
```

**Step 2**: Change the theme wrapper in `src/App.tsx`:

```tsx
// Default: Intuit
<div data-theme="intuit" data-colorscheme="light">

// TurboTax:
<div data-theme="turbotax" data-colorscheme="light">

// QuickBooks dark mode:
<div data-theme="quickbooks" data-colorscheme="dark">
```

Same IDS components, different visual identity — colors, typography, and spacing all change automatically based on the brand tokens.

### Token CDN

All brand tokens are hosted at:
```
https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/{brand}.css
```

To re-download the latest tokens:
```bash
curl -s "https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/turbotax.css" > src/styles/tokens/turbotax.css
```

---

## Updates & Contact

| Team | Contact |
|------|---------|
| GTM Tech XD Team | Basavaraj K M
| Slack | #xd-dev-setup-kit |

### Changelog

| Date | Change |
|------|--------|
| 2026-03-31 | v3: Added Storybook with IDS theming, MCP addon, story template, MSW mock API |
| 2026-03-19 | v2: React 18, CDN tokens, PostCSS pipeline, Storybook MCP, admin overrides |
| 2026-03-01 | v1: Initial scaffold with Vite + React + IDS reference |
