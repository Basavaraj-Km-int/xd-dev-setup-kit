# XD Dev Setup Kit

AI-powered prototyping environment for Intuit Product Designers. Scaffold a project, write your PRD, and let Claude Code build the prototype with **100% IDS (Intuit Design System) parity**.

**No coding experience required.** Write your PRD, open Claude Code, and start building.

---

## What This Template Does

1. Scaffolds a **Vite + React 18 + TypeScript** project
2. Installs **IDS components** (`@ids-ts/button`, `@ids-ts/badge`, `@ids-ts/typography`)
3. Downloads **real IDS design tokens** from the Intuit CDN
4. Configures **PostCSS** to match the IDS build pipeline
5. Sets up **CLAUDE.md** with instructions for AI-assisted prototyping
6. Sets up **Storybook MCP proxy** for AI-powered component lookup (no IDS clone needed)
7. Provides **admin UI overrides** (softer shadows/borders for dashboards)

Your prototype uses the same components and tokens that developers use in production.

---

## Prerequisites (One-Time Setup)

### Step 1: Install the tools

> **How to open Terminal on Mac**: Press `Cmd + Space`, type "Terminal", press Enter.

**1. Node.js 18+**

```bash
node --version
```
If you see a version number (e.g., `v22.x.x`) — you're good. Otherwise:
```bash
brew install node
```
> Don't have Homebrew? Install it first: go to [brew.sh](https://brew.sh/).

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
If not installed, follow: [claude.ai/code](https://claude.ai/code)

### Step 2: Authenticate with Intuit GitHub

```bash
gh auth login --hostname github.intuit.com
```
Follow the prompts.

### Step 3: Configure npm for Intuit packages

Check if already configured:
```bash
cat ~/.npmrc
```

You should see `registry=https://registry.npmjs.intuit.com/`. If not, add it:
```bash
echo "registry=https://registry.npmjs.intuit.com/" >> ~/.npmrc
```

---

## Quick Start (Every New Project)

### 1. Clone this template

```bash
git clone https://github.intuit.com/YOUR_ORG/xd-dev-setup-kit.git my-prototype
cd my-prototype
```

### 2. Run the scaffold

```bash
chmod +x scaffold.sh
./scaffold.sh
```

This takes ~2 minutes. It installs React, IDS components, downloads tokens, and sets up the Storybook MCP proxy.

### 3. Write your PRD

Open `docs/PRD.md` and fill in your product requirements.

### 4. Start building

```bash
npm run dev
```

Then open Claude Code in the project directory:
```bash
claude
```

Tell Claude: **"Read the PRD and create the design document, then build the prototype"**

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

---

## Project Structure

```text
my-prototype/
├── CLAUDE.md                 # AI agent instructions (read this!)
├── docs/
│   ├── PRD.md                # Your product requirements
│   ├── design.md             # Generated design document
│   └── session-learnings.md  # Build session notes
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

### Option A: Storybook MCP Proxy (Recommended — no IDS clone needed)

The MCP proxy fetches IDS component docs directly from the hosted CDN. No 450MB repo clone, no build step.

**One-time setup:**

```bash
# Clone the proxy (tiny — 13 packages, ~5MB)
git clone https://github.com/Basavaraj-Km-int/ids-storybook-mcp-proxy.git
cd ids-storybook-mcp-proxy
npm install
```

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
npm run build            # Production build (fast navigation)
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

## MCP Servers (AI Agent Integration)

These MCP servers enhance Claude Code's capabilities:

| MCP Server | Purpose | Setup Command |
|---|---|---|
| **IDS Storybook MCP Proxy** | Look up IDS component docs (no clone needed) | `cd ids-storybook-mcp-proxy && node server.js` then `claude mcp add ids-storybook --transport http http://localhost:6007/mcp` |
| **Figma MCP** | Read Figma designs | `claude mcp add --transport http figma-remote-mcp https://mcp.figma.com/mcp` |
| **Agentation** | Visual feedback in browser | `claude mcp add agentation -- npx agentation-mcp server` |
| **Chrome DevTools** | Browser automation & screenshots | (Plugin — install via Claude Code) |

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
| GTM Tech XD Team | Basavaraj K M, Vidyashree Todakar |
| Slack | #xd-dev-setup-kit |

### Changelog

| Date | Change |
|------|--------|
| 2026-03-19 | v2: React 18, CDN tokens, PostCSS pipeline, Storybook MCP, admin overrides |
| 2026-03-01 | v1: Initial scaffold with Vite + React + IDS reference |
