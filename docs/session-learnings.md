# Session Learnings — IDS Prototype with XD Dev Setup Kit

> Detailed record of what worked, what didn't, challenges faced, and how they were resolved
> during the DNC-GPC Platform Demo prototype build (March 2026).

---

## 1. Scaffold & Initial Setup

### What Worked
- `scaffold.sh` created the Vite + React + TypeScript project correctly
- Project structure (`src/components`, `src/pages`, `src/layouts`, `src/mocks`) was ready out of the box
- `docs/PRD.md` and `docs/design.md` templates guided the design-first workflow
- CLAUDE.md provided clear instructions for the AI agent to follow

### What Didn't Work
- The scaffold installed **React 19** — but all `@ids-ts/*` packages require **React 18.2.0** as a peer dependency. Every IDS install required `--legacy-peer-deps`, and some components had subtle runtime issues.
- The scaffold didn't install any IDS packages, PostCSS plugins, or download design tokens — the AI agent had to figure all of this out from scratch.
- The scaffold didn't configure the Intuit npm registry (`~/.npmrc`) — it was already set up on this machine, but a fresh machine would fail silently.

### Fix Applied
- Downgraded React to 18.2.0: `npm install react@18.2.0 react-dom@18.2.0 @types/react@18.2.48 @types/react-dom@18.2.18`
- All subsequent IDS installs worked without `--legacy-peer-deps`

### Recommendation for Scaffold
- Pin React to 18.2.0 in the scaffold (matches IDS peer dep exactly)
- Pre-install core IDS packages: `@ids-ts/button @ids-ts/badge @ids-ts/typography`
- Download CDN tokens during scaffold
- Add PostCSS config during scaffold

---

## 2. IDS Design System Integration

### Challenge: CSS Module Hash Mismatch
IDS components like `Table`, `Dropdown`, and `TextField` use CSS Modules with pre-built hashed class names (e.g., `Table-comfortable-5e61537`). When these components are imported into a Vite project, Vite generates **different** hashes, so props like `density="comfortable"` have no visual effect — the CSS class doesn't match.

**Root Cause**: IDS components are built with their own Vite config (`getViteConfig()` from `baseViteConfig.ts`) which produces specific CSS Module hashes. Our standalone Vite instance uses different hashing.

**Components Affected**:
- `@ids-ts/table` — `density`, `divider`, `hover` props don't apply CSS
- `@ids-ts/dropdown` — dropdown menu positioning/styling broken
- `@ids-ts/text-field` — CSS has `::before` pseudo-element syntax that LightningCSS (Vite 8's minifier) can't parse, breaking production builds

**Components That Work Well** (JS-driven styling, not dependent on CSS Module hashes):
- `@ids-ts/button` — all purpose/priority/size combos render correctly
- `@ids-ts/badge` — all status variants render correctly
- `@ids-ts/typography` — all H1-H6, B1-B4 variants render correctly

**Fix Applied**:
- Use IDS Button, Badge, Typography directly (they work)
- For Table: use standard `<table>` with IDS token CSS variables
- For Dropdown: built a custom `Select` component styled with IDS tokens
- For TextField: use standard `<input>` styled with IDS token variables

### Challenge: ThemeProvider Network Requests
The `@design-systems/theme` `ThemeProvider` component tries to fetch tokens from `appfabric-static-assets` S3 bucket at runtime. In a standalone prototype, this URL doesn't resolve, causing:
- 10+ second delays on first render
- Console warnings about failed token fetches
- No theme tokens applied (components render unstyled)

**Fix Applied**:
- Removed `ThemeProvider` wrapper
- Used `<div data-theme="intuit" data-colorscheme="light">` instead
- Downloaded real CDN tokens to `src/styles/ids-tokens.css`

### Challenge: IDS Token Values Were Wrong
Initially, we manually defined ~170 CSS custom properties with approximate values. After downloading the real CDN tokens, we discovered many values were different:
- `--color-action-passive` was `#E3E5E8` (light gray), not `#6b7280` (medium gray)
- `--color-container-border-secondary` was `#8D9096` (harsh), not `#e5e7eb` (soft)
- `--color-shadow` was `rgba(0,0,0,0.2)` (heavy), not our lighter approximation

**Fix Applied**:
- Downloaded real tokens from CDN: `curl -s "https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/intuit.css" > src/styles/ids-tokens.css`
- Created `ids-overrides.css` for admin UI adjustments (softer shadows, borders)

---

## 3. Performance Issues

### Challenge: Vite Dev Server — 16-Second Navigation
In dev mode, clicking between pages took **16 seconds**. This is because Vite serves each module as a separate HTTP request (ESM native modules). With IDS components having 60+ transitive dependencies, each navigation triggered dozens of on-demand module compilations.

**Diagnosis**:
- 59 network requests per page load
- Each IDS component pulls in `@cgds/utils`, `@design-systems/theme`, `clsx`, `lodash.uniqueid`, and many more
- First visit to each page triggers fresh compilation of all new modules

**Fix Applied**:
1. **Production build for demos**: `npm run build && npm run preview` bundles everything into 2 files (408KB JS + 98KB CSS). Navigation drops to **<160ms**.
2. **Pre-bundling in vite.config.ts**: Added `optimizeDeps.include` for all IDS packages and their transitive deps
3. **Excluded IDS source repo from watcher**: `server.watch.ignored: ['**/ids-web-full/**']` — prevented Vite from scanning 80+ tsconfig files on every change

### Performance Results

| Metric | Before | After |
|--------|--------|-------|
| Vite startup | 2,551ms | 300ms |
| Page navigation (dev) | 16,000ms | ~400ms |
| Page navigation (prod) | — | <160ms |
| Network requests (dev) | 59 | 39 |
| Build time | — | 500-640ms |
| Bundle size | — | 408KB JS + 98KB CSS |

---

## 4. Typography Scale Issues

### Challenge: IDS Heading Sizes Too Large for Dashboard
IDS Typography components use display-scale font sizes designed for marketing pages:
- H1: 48px, H2: 40px, H3: 34px (at desktop breakpoint)

For an admin dashboard, these are way too large. Page titles should be 24-28px, section titles 20-24px.

**Fix Applied**:
- Use **H4** (28px) for page titles (Dashboard, DNC Scrubber, Processing History)
- Use **H5** (24px) for section titles (Region Breakdown, Recent Scrubs, etc.)
- Document this pattern in CLAUDE.md for future prototypes

---

## 5. Storybook MCP Integration

### Challenge: No Programmatic Component Lookup
The AI agent was guessing prop names and import patterns, causing:
- Wrong exports (`import Table from` vs `import { Table } from`)
- Missing required props (`Progress` needs `shape` prop)
- Incorrect prop values (using `variant` instead of `purpose`)

### Solution: Storybook MCP Server
1. Built the IDS Storybook locally: `cd ids-web-full && yarn build && yarn dev`
2. Added MCP server: `claude mcp add storybook-mcp --transport http http://localhost:6006/mcp --scope project`
3. Claude Code can now call:
   - `list-all-documentation` — discover all 68 components
   - `get-documentation("components-button")` — get exact props, stories, code examples
   - `get-documentation-for-story` — get specific variant details

**Prerequisite**: IDS repo must be built first (`yarn build`) before Storybook can start, because component CSS files (`dist/main.css`) don't exist until built.

---

## 6. PostCSS Pipeline

### Challenge: Missing PostCSS Plugins
IDS components use PostCSS mixins (e.g., `@mixin roundedFocusWithGap`) in their source CSS. Without the matching PostCSS plugins, these patterns can't be processed.

**Fix Applied**:
- Installed: `postcss-mixins@9.0.4 postcss-nested@6.0.1 postcss-simple-vars@7.0.1`
- Created `postcss.config.js` matching the IDS build pipeline

---

## 7. Git Authentication

### Challenge: Multiple GitHub Accounts
The user has two GitHub accounts:
- `github.com/Basavaraj-Km-int` (personal)
- `github.intuit.com/bkm01` (enterprise)

SSH keys weren't configured for either. The scaffold's `git clone` for IDS failed silently.

**Fix Applied**:
- Used HTTPS + PAT (Personal Access Token) for cloning
- Configured `~/.netrc` with tokens for both platforms
- Added `ssh-keyscan` for github.intuit.com to known_hosts

---

## 8. Dev Tooling

### Agentation (Visual Feedback)
- Installed `agentation` as dev dependency
- Added `<Agentation />` component to App.tsx
- Added MCP server: `claude mcp add agentation -- npx agentation-mcp server`
- Enables real-time visual feedback annotations in the browser
- The AI agent can see and respond to specific UI element feedback

### React Grab
- Installed `react-grab` as dev dependency
- Added dev-only import in `index.html`
- Provides DOM inspection overlay in dev mode

---

## 9. Key Decisions & Rationale

| Decision | Rationale |
|----------|-----------|
| React 18.2.0 (not 19) | Matches IDS peer dependency exactly — no workarounds needed |
| CDN tokens (not ThemeProvider) | ThemeProvider fetches from internal S3 — doesn't work standalone |
| Custom Select (not IDS Dropdown) | IDS Dropdown has 15+ transitive deps and CSS Module hash issues |
| Custom table styles (not IDS Table) | IDS Table CSS Module hashes don't match in standalone Vite |
| H4/H5 (not H1/H2) for dashboards | IDS H1-H3 are display-scale (48-84px) — too large for admin UIs |
| Production build for demos | Dev server is slow (16s nav) due to unbundled ESM; prod build is instant |
| `ids-overrides.css` layer | CDN tokens are designed for product pages — admin UIs need softer shadows and borders |

---

## 10. Recommendations for XD Dev Setup Kit v2

### Must-Have in Scaffold
1. Pin React to 18.2.0
2. Pre-install `@ids-ts/button @ids-ts/badge @ids-ts/typography`
3. Download CDN tokens to `src/styles/ids-tokens.css`
4. Create `ids-overrides.css` with admin-appropriate overrides
5. Install PostCSS plugins and create `postcss.config.js`
6. Configure `vite.config.ts` with IDS optimizeDeps and watcher exclusions
7. Add `react-router-dom` for multi-page prototypes

### Must-Have in CLAUDE.md
1. Storybook URL as primary component reference
2. Chrome DevTools / Storybook MCP lookup instructions
3. List of IDS components that work vs. need alternatives in Vite
4. Typography scale guidance (H4/H5 for admin UIs)
5. Token download command
6. Production build instructions for demos

### Nice-to-Have
1. Storybook MCP auto-setup in scaffold ✅ (done — MCP proxy in scaffold v2)
2. Agentation + React Grab pre-configured
3. MSW (Mock Service Worker) for API mocking
4. Dark mode toggle using `data-colorscheme="dark"` (tokens already support it)

---

## 11. Multi-Brand Theming Discovery

All Intuit brand tokens are available on the CDN:
- `intuit.css`, `turbotax.css`, `quickbooks.css`, `mailchimp.css`, `creditkarma.css`, `mint.css`
- CDN base: `https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/`
- Each supports `light` and `dark` color schemes
- Switch by changing token import in `main.tsx` and `data-theme` in `App.tsx`
- Same IDS components work across all brands — only token values change
- The `@design-systems/storybook-theme-addon` provides brand switching in local Storybook but is NOT on the hosted Storybook
- Brand theme source: `github.intuit.com/design-systems/theme`
