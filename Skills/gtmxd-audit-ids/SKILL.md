---
name: gtmxd-audit-ids
description: Audit a Figma screen for IDS (Intuit Design System) compliance — missing IDS component instances, unbound tokens, incorrect variants, and typography scale violations. Read-only inspection with actionable findings.
---

# GTMXD Audit IDS — IDS Design System Compliance Audit

Read-only audit of a Figma design for IDS integration drift. Produces a report of findings with priority, evidence, and suggested fixes.

**When to use**: Before Workflow B handoff (verifying Figma ↔ code parity), after `generate_figma_design` capture (checking what needs IDS binding), or as a design review checkpoint.

**IDS Figma Library Keys:**
- **Web Components**: `VO8rsMYDqsDY44J9yEVyES9Y`
- **Foundations & Tokens**: `Q0HemoQpvXxl4pB3YA7VDZ`

**Based on**: [edenspiekermann/Skills/audit-design-system](https://github.com/edenspiekermann/Skills/tree/main/skills/audit-design-system)

---

## Workflow

### 1. Parse Input

Accept a Figma URL, or `fileKey` + `nodeId`. Normalize node IDs (`72-293` → `72:293`).

### 2. Gather Evidence

Call these Figma MCP tools:
1. `get_design_context` — for the exact node under review
2. `get_screenshot` — for visual confirmation
3. `get_variable_defs` — to check which IDS variables are bound
4. `get_metadata` — for large/repeated nodes, map nested instances
5. `search_design_system(fileKey: "VO8rsMYDqsDY44J9yEVyES9Y", query: "...")` — search IDS Web Components for replacement

### 3. Review for IDS-Specific Issues

#### What to Flag

**Missing IDS instances** (Priority 2-3):
- Buttons recreated as styled frames instead of IDS Button instances
- Badges/tags as custom rectangles instead of IDS Badge
- Typography as raw text instead of IDS H4/H5/B2/B3 component usage
- Loaders as custom animations instead of IDS Activity/Progress

**Incorrect variant selection** (Priority 1-2):
- IDS Button with wrong `purpose` (visual cue doesn't match semantic intent)
- IDS Button with wrong `priority` (filled when should be outlined, etc.)
- Admin UI using H1-H3 instead of H4-H5 scale

**Unbound tokens** (Priority 1-2):
- Hard-coded hex colors where IDS token variables should apply
- Raw spacing values instead of IDS spacing tokens
- Custom font sizes instead of IDS typography scale
- Hard-coded border radius instead of IDS radius tokens

**Compound component violations** (Priority 2):
- Modal built as flat frames instead of ModalDialog + ModalHeader + ModalContent + ModalActions
- Dropdown items as plain text instead of MenuItem instances

**Multi-brand violations** (Priority 1):
- Mixed brand tokens in same screen (e.g., Intuit blue + TurboTax green)
- Hard-coded brand colors instead of brand-agnostic IDS tokens

**Vite compatibility notes** (Priority 0 — informational):
- Design uses IDS components that have CSS Module hash issues in Vite:
  - `@ids-ts/table`, `@ids-ts/dropdown`, `@ids-ts/text-field`
- These render correctly in Figma but need token-styled alternatives in code

#### What NOT to Flag

- Aesthetic preferences or layout taste
- Copywriting or product decisions
- One-off compositions when underlying primitives are already IDS instances
- Screen-specific layouts that don't need to be componentized
- Custom data visualizations (charts, graphs) — these are intentionally bespoke

### 4. Present Findings

#### Markdown Report Format (default)

```markdown
## IDS Compliance Audit: [Screen Name]

**Verdict**: ✅ Passes / ⚠️ Needs Work / ❌ Significant Issues
**Confidence**: X%

### Summary
[2-3 sentences]

### Findings

| # | Priority | Title | Node |
|---|----------|-------|------|
| 1 | 🔴 Critical | [title] | [nodeId] |
| 2 | 🟠 High | [title] | [nodeId] |

### Details

#### Finding 1: [Title]
- **Evidence**: [what Figma structure shows]
- **Why it matters**: [maintenance, consistency, theming impact]
- **IDS replacement**: [specific component + variant suggestion]
- **Node**: [nodeId]

### Recommendations
[Prioritized action items]
```

### 5. Route to Fix Skills

- Single finding fix → `gtmxd-fix-ids-finding`
- Multi-section reconnect → `gtmxd-apply-ids`

---

## Priority Scale

| Priority | Icon | Meaning | Example |
|----------|------|---------|---------|
| 3 | 🔴 | Critical — library-level or nav-level issue | Global nav built from custom frames |
| 2 | 🟠 | High — reusable primitive not componentized | Buttons as styled frames |
| 1 | 🟡 | Medium — moderate system drift | Wrong typography scale, unbound tokens |
| 0 | ⚪ | Low — nit or informational | Vite compatibility note |

## Evidence Standard

Every finding must answer:
1. What concrete Figma evidence shows this is not IDS-compliant?
2. Why does that matter for consistency, theming, or multi-brand support?

Good evidence: node is a plain frame where IDS Button should be, raw #0077C5 instead of `--color-action-standard` variable binding.

Weak evidence: "this looks custom" without structural proof.
