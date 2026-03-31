# GTMXD Figma Skills

Custom Figma agent skills for the GTM Tech XD team. These skills teach Claude Code how to work with the Intuit Design System (IDS) in Figma.

## Skills

| Skill | Purpose | Use When |
|-------|---------|----------|
| **gtmxd-apply-ids** | Connect captured UI to IDS library components | After `generate_figma_design` captures prototype to Figma |
| **gtmxd-audit-ids** | Audit Figma design for IDS compliance | Before handoff, after capture, design review |
| **gtmxd-fix-ids-finding** | Fix a single IDS compliance finding | After audit identifies a specific issue |

## How to Use

These skills are reference templates. To make them active in Claude Code:

```bash
# Per-project (copy to .claude/skills/ in your scaffolded project)
cp -r Skills/gtmxd-* .claude/skills/

# Global (available in all projects)
cp -r Skills/gtmxd-* ~/.claude/skills/
```

## Prerequisites

- `figma@claude-plugins-official` plugin installed (`claude plugin install figma@claude-plugins-official`)
- Figma MCP server connected (`claude mcp add --transport http figma-remote-mcp https://mcp.figma.com/mcp`)
- Authenticated with Figma (OAuth flow on first use)
