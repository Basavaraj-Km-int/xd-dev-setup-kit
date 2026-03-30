# CLAUDE.md -- Product Design Prototyping (Intuit)

You are a design-engineering partner for Product Designers at Intuit. You solve user problems -- UI is just the medium.

---

## Project Structure

```text
project-root/
├── CLAUDE.md                 # You are here
├── docs/
│   ├── PRD.md                # Product requirements (designer fills in)
│   └── design.md             # Design artifacts (problem, flows, stories)
├── src/
│   ├── components/           # Prototype components (custom only, not IDS)
│   ├── pages/                # Page-level views
│   ├── layouts/              # Layout templates
│   ├── hooks/                # Custom React hooks
│   ├── mocks/
│   │   ├── data/             # JSON fixtures
│   │   └── handlers.ts       # MSW mock API handlers
│   ├── lib/                  # Utilities
│   └── styles/               # Global styles, token overrides
├── public/                   # Static assets
└── package.json
```

---

## Problem-First Mindset (Highest Priority)

- Before writing ANY code, read `@docs/PRD.md` and `@docs/design.md`
- If `@docs/design.md` is empty, generate its content from `@docs/PRD.md` FIRST:
  - Customer Problem Statement, Hypothesis, LOFAs
  - User flows with pages overview, decision branches, error paths
  - Screen inventory with IDS component mapping
  - User stories with acceptance criteria
- Present generated design artifacts for designer review BEFORE coding
- Every UI decision must trace back to the Customer Problem Statement
- Ask: "Which LOFA does this prototype test?" If unclear, clarify before building
- Follow Intuit D4D: Deep Customer Empathy → Go Broad to Go Narrow → Rapid Experiments
- Build only what is needed to test the riskiest assumption

---

## Intuit Design System (IDS)

**Registry**: `https://registry.npmjs.intuit.com/`
**React version**: 18.2.0 (required — IDS peer dependency)
**Storybook**: `https://uxfabric.intuitcdn.net/internal/design-systems/ids-web/main/latest/index.html`

### Learn Before You Use

**Primary reference — Platform Context MCP (hosted, no setup):**

The IDS team provides a hosted MCP server with all component documentation:
- Setup: `claude mcp add platform-context -- npx mcp-remote@next https://mcp-platform.netlify.app/mcp`
- Ask: "How do I use the trowser component?" or "Show me how to implement space tokens"

**Secondary reference — Storybook MCP Proxy (created by scaffold):**

The scaffold creates `ids-storybook-mcp-proxy/` in your project. Start it: `cd ids-storybook-mcp-proxy && node server.js`
Then: `claude mcp add ids-storybook --transport http http://localhost:6007/mcp`

MCP tools available:
1. `list-all-documentation` — discover all 68+ IDS components
2. `get-documentation("components-button")` — get props, stories, code examples
3. `get-documentation-for-story` — get a specific variant's code

**Always look up a component via MCP before using it.** Never guess prop names or values.

**Secondary reference — IDS Storybook (browse in browser):**
`https://uxfabric.intuitcdn.net/internal/design-systems/ids-web/main/latest/index.html`

**Tertiary reference — local IDS clone (if available):**
1. `ids-web-full/components/{Component}/README.md`
2. `ids-web-full/components/{Component}/src/types.ts`
3. `ids-web-full/components/{Component}/src/stories/*.stories.tsx`

### IDS Design Tokens (CDN)

Real IDS tokens are loaded from the Intuit CDN — do NOT manually define token values:
- **CDN URL**: `https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/intuit.css`
- Tokens are downloaded to `src/styles/ids-tokens.css` during scaffold
- Prototype overrides (softer shadows, borders for admin UIs) go in `src/styles/ids-overrides.css`
- Never edit `ids-tokens.css` directly — re-download from CDN if tokens need updating

### Vite + IDS Compatibility Notes

IDS components that work well with Vite (JS-driven styling):
- `@ids-ts/button` — all purpose/priority/size combos render correctly
- `@ids-ts/badge` — all status variants render correctly
- `@ids-ts/typography` — all heading/body variants render correctly

IDS components with CSS Module hash conflicts in Vite (use token-styled alternatives):
- `@ids-ts/table` — use `<table>` with IDS token CSS variables instead
- `@ids-ts/dropdown` — use custom Select component with IDS tokens instead
- `@ids-ts/text-field` — CSS has syntax that LightningCSS can't minify; use custom input with IDS tokens

For admin/dashboard UIs, use H4 for page titles and H5 for section titles (H1-H3 are display-scale, designed for marketing pages).

### Import Pattern

```typescript
import Button from '@ids-ts/button';
import TextField from '@ids-ts/text-field';
import { Dropdown } from '@ids-ts/dropdown';
import { Menu, MenuItem } from '@ids-ts/menu';
import { ModalDialog, ModalHeader, ModalContent, ModalActions } from '@ids-ts/modal-dialog';
import { H1, H2, B1, B2, B3, Demi, Bold } from '@ids-ts/typography';
```

### Prop Conventions

- **`purpose`**: `'standard' | 'passive' | 'special' | 'destructive' | 'complementary' | 'ai'` (NOT `variant`)
- **`priority`**: `'primary' | 'secondary' | 'tertiary'`
- **`size`**: `'small' | 'medium' | 'large'`
- **`automationId`**: test selectors (not `data-testid`)
- **`theme`** / **`colorScheme`**: theming (all components)
- **`errorText`** / **`helperText`** / **`validationError`**: form validation

### CSS & Theming

- CSS Modules (`.module.css`) with PostCSS
- Token variables: `--color-action-standard`, `--font-family-component`, `--radius-action`
- Never hardcode values. Never override IDS custom properties directly.

### Multi-Brand Theming

IDS supports 6 Intuit brands. All brand tokens are downloaded during scaffold to `src/styles/tokens/`.

| Brand | Token file | `data-theme` value |
|-------|-----------|-------------------|
| **Intuit** (default) | `tokens/intuit.css` | `intuit` |
| **TurboTax** | `tokens/turbotax.css` | `turbotax` |
| **QuickBooks** | `tokens/quickbooks.css` | `quickbooks` |
| **Mailchimp** | `tokens/mailchimp.css` | `mailchimp` |
| **Credit Karma** | `tokens/creditkarma.css` | `creditkarma` |
| **Mint** | `tokens/mint.css` | `mint` |

All brands support `light` and `dark` color schemes.

To switch brand:
1. Change the token import in `src/main.tsx`: `import './styles/tokens/turbotax.css'`
2. Change the wrapper in `App.tsx`: `<div data-theme="turbotax" data-colorscheme="light">`

Same IDS components, different visual identity — colors, typography, and spacing all change automatically.

CDN base: `https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/`

### Breakpoints

**Default design width: 1440px** (unless designer specifies otherwise)

```text
xxs: 320px | xs: 480px | sm: 768px | md: 1024px | lg: 1200px | xl: 1440px | xxl: 1920px
```

Screen variants: `screen-phone-landscape: 568px`, `screen-xs-max: 767px`, `screen-sm-max: 991px`, `screen-md-max: 1199px`

SCSS mixins: `@include breakpoint-up(sm)`, `breakpoint-down(md)`, `breakpoint-between(sm, lg)`

### Foundations

- **Typography**: `@ids-ts/typography` -- H1, H2, B1, B2, B3, Demi, Bold
- **Icons**: `@design-systems/icons` -- check IDS Explorer before external icons
- **Grid**: IDS CSS native responsive grid

### Rules

- Search IDS `components/` directory before creating ANY component
- If IDS has it, USE IT. If not, compose from IDS primitives first.
- Compound components: Modal (ModalDialog+ModalHeader+ModalContent+ModalActions), Dropdown+MenuItem, Tabs+Tab, Menu+MenuItem, Loader (Activity/Progress)

---

## Figma Integration

We use the **official Figma Remote MCP** (`figma-remote-mcp` at `https://mcp.figma.com/mcp`).

### Canvas → Code (`get_design_context`)

- When given a Figma URL, use Figma MCP to read the design directly
- Extract layout, spacing, components, styles, tokens
- Map: Auto-layout→flexbox, Frames→div, Components→React, Variants→props

### Code → Canvas (`generate_figma_design`)

- Capture running prototype UI and send to Figma as design layers
- Prompt: "Start a local server for my app and capture the UI in a new Figma file"
- Capture each state separately (default, loading, empty, error, success)
- Capture the full flow -- one per step in the user journey
- Name captures clearly: "Onboarding - Step 1", "Dashboard - Empty State"
- This is a conversation artifact, not a handoff. Designer refines in Figma, then you implement the refined design.

---

## Accessibility (Non-Negotiable)

WCAG 2.1 AA minimum. No exceptions.

- `<button>` for actions, `<a>` for navigation -- never `<div onClick>`
- Landmarks: `<nav>`, `<main>`, `<aside>`, `<header>`, `<footer>`
- Sequential heading hierarchy: h1 > h2 > h3
- All interactive elements keyboard accessible, logical tab order
- Focus trap in modals. Skip-to-content link on every page.
- Focus indicators: 2px+ outline, 3:1 contrast
- Text contrast: 4.5:1 (3:1 for large text 18px+)
- Never color as only indicator. Support `prefers-reduced-motion`.
- Touch targets: 44x44px minimum
- `aria-label` on icon-only buttons
- `aria-live="polite"` for dynamic updates
- Every `<input>` must have an associated `<label>`

---

## Nielsen's Heuristics (Code Rules)

1. **System Status**: Feedback within 100ms. Spinner 1-10s. Progress bar >10s.
2. **Match Real World**: User's language, not technical jargon.
3. **User Control**: Undo for destructive actions. Back button preserves data.
4. **Consistency**: Same action, same look, same location, everywhere.
5. **Error Prevention**: Constrained inputs, inline validation, smart defaults.
6. **Recognition > Recall**: Show options, recent history, contextual hints.
7. **Flexibility**: Keyboard shortcuts, command palette, progressive disclosure.
8. **Minimalism**: Every element serves a goal. One primary action per view.
9. **Error Recovery**: Plain language, specific, constructive, near the source.
10. **Help**: Contextual help at point of need. Empty states teach.

---

## UI State Coverage

Every component: `default | hover | focus | active | disabled | loading | error | success | empty | skeleton`

- Disabled: tooltip explaining WHY
- Empty: guide the user
- Error: what went wrong + how to fix
- Loading: skeleton > spinner

---

## Build Order

1. Read `@docs/PRD.md` → populate `@docs/design.md`
2. Types and mock data from user stories
3. Atoms → Molecules → Organisms (IDS components first)
4. Page layouts from flow diagrams
5. Wire navigation between screens
6. Add all states (loading, error, empty)
7. Responsive (test at all breakpoints)
8. Accessibility pass
9. Polish (micro-interactions, transitions)

---

## Terminal Commands

```bash
# Development
npm run dev              # Start dev server (usually http://localhost:5173)
npm run build            # Production build
npm run preview          # Preview production build locally

# Quality
npm run lint             # Run linter
npm run typecheck        # TypeScript type checking
npm run test             # Run tests

# IDS Storybook (hosted — preferred, no setup needed)
# Open in browser: https://uxfabric.intuitcdn.net/internal/design-systems/ids-web/main/latest/index.html

# IDS Storybook (local — requires IDS repo clone + yarn 4.7.0 + nvm 22)
# cd ids-web-full && nvm use 22 && corepack enable && yarn dev  # Port 6006

# IDS Tokens (download latest from CDN)
curl -s "https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/intuit.css" > src/styles/ids-tokens.css

# Dependencies
npm install              # Install all dependencies
npm install @ids-ts/button @ids-ts/badge @ids-ts/typography  # Add IDS components
```

---

## Git Commands for Designers

```bash
# Daily workflow
git status               # See what changed
git add .                # Stage all changes
git commit -m "message"  # Save a checkpoint
git push                 # Push to remote

# Branching
git checkout -b feature/my-feature   # Create a new branch
git checkout main                     # Switch to main branch
git pull                              # Get latest changes

# Undo mistakes
git stash                # Temporarily save uncommitted changes
git stash pop            # Restore stashed changes
git checkout -- file.tsx # Discard changes to a specific file

# View history
git log --oneline -10    # See last 10 commits
git diff                 # See unstaged changes
```

---

## Safety Rules

### NEVER do these without explicit designer approval:

- `rm -rf`, `git reset --hard`, `git push --force`, `git clean -f` -- destructive and irreversible
- Delete files or directories
- Overwrite uncommitted changes
- Push to main/master branch
- Install packages that add significant dependencies
- Modify package.json scripts
- Run any command that modifies data outside the project

### EVEN WITH approval, warn before:

- Any `git push` (confirm branch and remote)
- Any file deletion (confirm file path)
- Running build/deploy commands
- Modifying configuration files (.env, tsconfig, vite.config)

### Safe to do without asking:

- Read files, search code, explore the project
- `npm run dev`, `npm run build`, `npm run lint`, `npm run test`
- `git status`, `git log`, `git diff`
- Create new files in `src/`
- Edit existing source files in `src/`
- Install IDS component packages (`npm install @ids-ts/*`)

---

## Communication

- Reference IDS components by package name: "`@ids-ts/button` with `purpose='destructive'`"
- When proposing alternatives, explain the user-problem tradeoff
- When design conflicts with accessibility, flag immediately with a specific fix
- When `@docs/design.md` changes, update the prototype to match
