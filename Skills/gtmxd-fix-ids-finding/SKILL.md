---
name: gtmxd-fix-ids-finding
description: Fix a specific IDS compliance finding in a Figma design — swap a custom frame for an IDS library instance, bind IDS tokens, or correct variant selection. Use after gtmxd-audit-ids identifies a concrete issue.
---

# GTMXD Fix IDS Finding — Targeted IDS Fix

Fix one specific IDS compliance finding from a `gtmxd-audit-ids` report.

**Scope**: One finding, one node, minimal read/write. Use `gtmxd-apply-ids` for broader multi-section work.

**Based on**: [edenspiekermann/Skills/fix-design-system-finding](https://github.com/edenspiekermann/Skills/tree/main/skills/fix-design-system-finding)

---

## Expected Input

One of:
- A single finding from `gtmxd-audit-ids`
- A paraphrased issue + Figma URL or `fileKey`/`nodeId`
- The full audit report + which finding to fix

## Scope Rule

Stay pinned to the selected finding until:
- `fixed`: the issue is corrected
- `blocked`: requires missing IDS library assets or broader decisions
- `needs-follow-up`: node improved but adjacent issue remains

## Workflow

### 1. Normalize the Finding

Extract: `fileKey`, offending `nodeId`, finding title, why it was flagged.

### 2. Compatibility Check

Before writing, verify:
- Which exact IDS component/variant is the replacement
- Whether text, icon, size overrides are supported
- Whether the replacement preserves the node's layout

Results: `safe-to-apply`, `blocked`, or `needs-human-choice`

### 3. Gather Evidence

Minimal reads:
1. `get_screenshot` for the offending node
2. `get_metadata` for structural context
3. `get_variable_defs` if finding is about tokens
4. `search_design_system` only if replacement isn't identified yet

### 4. Classify the Fix

Choose one:
- **`swap-instance`**: Replace with correct IDS library component/variant
- **`compose-from-primitives`**: Rebuild from IDS compound components
- **`bind-tokens`**: Replace raw values with IDS variable bindings
- **`align-variant`**: Move existing instance to correct `purpose`/`priority`/`size`
- **`blocked`**: No valid IDS-backed fix possible

### 5. Back Up

Duplicate only the affected node. Name: `Backup - Fix [finding title]`

### 6. Apply Fix

Small, incremental steps:
1. Inspect current node
2. Import IDS component via `importComponentByKeyAsync()`
3. Replace/swap/bind only the targeted area
4. Return all created/mutated node IDs

### 7. Validate

- Screenshot the changed node
- Confirm the audit complaint is resolved
- Confirm spacing/text didn't regress

---

## IDS Fix Patterns

| Finding Type | Fix Strategy | IDS Component |
|-------------|-------------|---------------|
| Custom button frame | `swap-instance` | Button (`purpose`/`priority`/`size`) |
| Raw hex color | `bind-tokens` | IDS color variable |
| Wrong heading scale | `align-variant` | H4 (28px) or H5 (24px) |
| Modal as flat frames | `compose-from-primitives` | ModalDialog compound |
| Custom badge/tag | `swap-instance` | Badge |
| Unbound spacing | `bind-tokens` | IDS spacing variable |
| Wrong button style | `align-variant` | Correct `purpose` + `priority` |
