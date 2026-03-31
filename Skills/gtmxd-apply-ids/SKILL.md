---
name: gtmxd-apply-ids
description: Post-process Figma designs to connect captured UI layers to IDS (Intuit Design System) library components. Use after generate_figma_design captures a prototype to Figma, or when an existing design needs IDS library binding. Adapted from Eden Spiekermann's apply-design-system skill.
---

# GTMXD Apply IDS — Connect Designs to Intuit Design System

Post-process Figma designs to replace raw frames with IDS library component instances, bind IDS variables, and ensure design-system compliance.

**When to use**: After `generate_figma_design` captures a prototype to Figma (Workflow A), or when connecting any existing design to the IDS library.

**Prerequisites — load these skills first:**
- `figma-use` — Plugin API rules (mandatory before every `use_figma` call)
- `figma-generate-library` — if building new IDS components in Figma

**Based on**: [edenspiekermann/Skills/apply-design-system](https://github.com/edenspiekermann/Skills/tree/main/skills/apply-design-system)

---

## IDS-Specific Knowledge

### IDS Component Mapping

When classifying captured UI elements, map them to IDS components:

| Captured Element | IDS Component | Package |
|-----------------|---------------|---------|
| Primary/secondary buttons | Button | `@ids-ts/button` |
| Status indicators, tags | Badge | `@ids-ts/badge` |
| Headings (28px page, 24px section) | H4, H5 | `@ids-ts/typography` |
| Body text (16px, 14px) | B2, B3 | `@ids-ts/typography` |
| Spinners, progress bars | Activity, Progress | `@ids-ts/loader` |
| Dialog overlays | ModalDialog compound | `@ids-ts/modal-dialog` |
| Selection dropdowns | Dropdown + MenuItem | `@ids-ts/dropdown` |
| Option menus | Menu + MenuItem | `@ids-ts/menu` |

### IDS Variant Props

IDS does NOT use `variant`. It uses:
- **`purpose`**: `standard | passive | special | destructive | complementary | ai`
- **`priority`**: `primary | secondary | tertiary`
- **`size`**: `small | medium | large`

When matching captured elements to variants, look for visual cues:
- Blue/action color → `purpose="standard"`
- Red/danger color → `purpose="destructive"`
- Green/success → `purpose="special"`
- Filled solid → `priority="primary"`
- Outlined/border → `priority="secondary"`
- Text-only → `priority="tertiary"`

### IDS Compound Components

These IDS components are compositions, not single instances:

```text
ModalDialog → ModalHeader + ModalContent + ModalActions
Dropdown → Dropdown + MenuItem (children)
Menu → Menu + MenuItem (children)
Tabs → Tabs + Tab (children)
```

When captured UI shows a modal, don't look for a single "modal" component — look for the compound pattern.

### Typography Scale for Admin UIs

IDS H1-H3 are display-scale (48-84px) for marketing. For admin/dashboard prototypes:
- Page titles → H4 (28px)
- Section titles → H5 (24px)
- Body text → B2 (16px)
- Small text → B3 (14px)

### Components with Vite CSS Issues

These IDS components render in Figma but have CSS Module hash conflicts in Vite code. Flag them during the apply process:
- `@ids-ts/table` — use `<table>` with IDS tokens in code
- `@ids-ts/dropdown` — use custom Select in code
- `@ids-ts/text-field` — use custom input in code

This does NOT prevent using them in Figma — only note the code-side limitation.

---

## Classification Buckets

Classify each section into exactly one:

- **`already-connected`**: Section is an IDS library instance or accepted composition
- **`exact-swap`**: An IDS library component/variant can replace the section directly
- **`compose-from-primitives`**: No single IDS component exists, but rebuild from IDS primitives
- **`blocked`**: IDS library doesn't expose the needed component, or section is intentionally custom

---

## Required Workflow

### 1. Determine Scope

If scope is not identified:
1. Run `gtmxd-audit-ids` or equivalent audit pass first
2. Collapse findings into section-sized work packages
3. If only one finding, use `gtmxd-fix-ids-finding` instead

### 2. Capture Current State

Before writing:
1. `get_metadata` on the target frame
2. `get_screenshot` for visual reference
3. Note: if `get_design_context` asks about Code Connect, ask the user before proceeding

### 3. Back Up the Target Screen

Before destructive edits, duplicate the frame. Name: `Backup - [Screen Name]`

### 4. Inventory the Existing Screen

Use `use_figma` to inspect:
- Top-level section instances
- Each section's `mainComponent` (local, remote, or missing)
- Nested published components already used
- Text and variant properties

### 5. Search IDS Library

Use `search_design_system` to find IDS components. Search tips:
- Search by IDS component name: "Button", "Badge", "Typography"
- Narrow by variant: "Button primary", "Badge status"
- Results may include non-IDS libraries — filter for IDS results

### 6. Decide Section Strategy

| Pattern | Strategy |
|---------|----------|
| Standalone button/badge/loader | `exact-swap` |
| Header summary with mixed content | `compose-from-primitives` |
| Alert/notification card | Check if IDS has it → `exact-swap` or `compose` |
| Navigation bar | `compose-from-primitives` (nav items are IDS primitives) |
| Custom data visualization | `blocked` (intentionally bespoke) |
| Form inputs | Check IDS availability → `exact-swap` if available |

### 7. Update One Section at a Time

Never rewrite the entire screen in one script.

For each section:
1. Read current node IDs
2. Import IDS component via `importComponentByKeyAsync()`
3. Match closest IDS variant to original section
4. Create or swap only that section
5. Return all mutated node IDs
6. Validate with `get_screenshot`

### 8. Handle Import Failures

If IDS component import fails:
1. Stop — don't continue with unrelated edits
2. Check if component key exists in the target file already
3. Try importing exact component key vs component-set key
4. If imports still fail, mark `blocked`

### 9. Validate

After each section:
- Screenshot the changed section
- Confirm IDS instance linkage
- Confirm text/spacing didn't regress
- At the end, validate full screen screenshot

---

## Multi-Brand Awareness

IDS supports 6 brands. When applying design system:
1. Check which brand tokens are active in the file (data-theme attribute)
2. Apply IDS components from the correct brand library
3. Bind variables from the matching brand token collection

| Brand | `data-theme` | Token set |
|-------|-------------|-----------|
| Intuit (default) | `intuit` | `intuit.css` |
| TurboTax | `turbotax` | `turbotax.css` |
| QuickBooks | `quickbooks` | `quickbooks.css` |
| Mailchimp | `mailchimp` | `mailchimp.css` |
| Credit Karma | `creditkarma` | `creditkarma.css` |
| Mint | `mint` | `mint.css` |
