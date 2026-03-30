# Claude Code Prompts for Designers

> Copy-paste these prompts into Claude Code to get things done without knowing terminal commands.
> Each prompt is self-contained — Claude Code will handle the rest.

---

## 1. First-Time Setup

### Check if your machine is ready

```
Check if my machine is ready for IDS prototyping. Verify I have: Node.js 18+, Git, GitHub CLI, and that ~/.npmrc has registry=https://registry.npmjs.intuit.com/ configured. For anything missing, install it for me or tell me exactly what to do step by step.
```

### Clone the template and scaffold a new project

```
Clone the xd-dev-setup-kit template from https://github.com/Basavaraj-Km-int/xd-dev-setup-kit.git into a new folder called [YOUR-PROJECT-NAME], go into that folder, make the scaffold script executable, and run it. Then read the README.md and CLAUDE.md so you understand the project setup.
```

> Replace `[YOUR-PROJECT-NAME]` with your project name (e.g., `payroll-onboarding`, `expense-tracker`)

### Set up the IDS Platform Context MCP

```
Add the IDS Platform Context MCP server so you can look up IDS component documentation. Run: claude mcp add platform-context -- npx mcp-remote@next https://mcp-platform.netlify.app/mcp
```

### Set up the Figma MCP

```
Add the Figma MCP server so you can read Figma designs and send prototypes to Figma. Run: claude mcp add --transport http figma-remote-mcp https://mcp.figma.com/mcp
```

---

## 2. Starting a Project

### Generate design document from PRD

```
Read docs/PRD.md and create the design document in docs/design.md. Include: customer problem statement, hypothesis, LOFAs, user flows with entry/exit points for every screen, screen inventory with IDS component mapping, and user stories with acceptance criteria. Show me the design doc for review before writing any code.
```

### Start building after design review

```
The design document is approved. Build the prototype following the build order in CLAUDE.md. Start with types and mock data, then build screen by screen starting with the primary flow. Use IDS components for everything — look up each component in the MCP before using it.
```

### Start from a Figma design

```
Implement this Figma design using IDS components: [PASTE FIGMA URL HERE]. Read the design from Figma MCP, identify all IDS components, map the layout to flexbox with IDS spacing tokens, and build it. Add loading, error, and empty states that the design doesn't show.
```

### Start from both PRD and Figma

```
Read the PRD in docs/PRD.md and the Figma design at [PASTE FIGMA URL HERE]. Generate docs/design.md from the PRD, use the Figma design for visual implementation. Cross-reference: flag any flows in the PRD not covered by Figma, or screens in Figma not traced to a user story.
```

---

## 3. During Development

### Start the dev server

```
Start the dev server so I can see the prototype in my browser.
```

### Look up an IDS component before using it

```
Look up the [COMPONENT NAME] component in the IDS design system. Show me: all available props and their values, correct import pattern, code example, and any accessibility requirements.
```

> Examples: `Button`, `Badge`, `Typography`, `Modal`, `Tabs`, `Accordion`, `Drawer`, `Checkbox`

### Switch to a different brand theme

```
Switch this prototype from Intuit theme to [BRAND] theme. Update the token import in main.tsx and the data-theme attribute in App.tsx.
```

> Brands: `intuit`, `turbotax`, `quickbooks`, `mailchimp`, `creditkarma`, `mint`

### Add dark mode

```
Add dark mode support to this prototype. Change data-colorscheme to "dark" in App.tsx and verify the UI looks correct with dark tokens.
```

### Add a new page

```
Add a new page called [PAGE NAME] to the prototype. Create the page component in src/pages/, add it to the router, and add a navigation link in the sidebar. Include loading, error, and empty states.
```

### Add a new component

```
Create a [COMPONENT NAME] component. First check if IDS has this component — if yes, use it. If not, build a custom one using IDS design tokens for all colors, spacing, typography, and shadows. Include all states: default, hover, focus, active, disabled.
```

---

## 4. Fixing Issues

### Something looks wrong

```
The [describe what looks wrong] doesn't look right. Check if we're using the correct IDS tokens and component props. Compare with the IDS Storybook documentation and fix it.
```

### The page is blank or has errors

```
The page is blank or showing errors. Check the browser console for errors, diagnose the issue, and fix it.
```

### Layout is broken on mobile

```
The layout is broken on mobile. Check responsive behavior at 375px width and fix: stack horizontal layouts vertically, hide secondary actions behind overflow menu, ensure 44px minimum touch targets.
```

### Fix accessibility issues

```
Run an accessibility check on this prototype. Verify: semantic HTML, keyboard navigation, focus indicators, color contrast (4.5:1 for text), aria-labels on icon buttons, associated labels on all inputs. Fix any issues found.
```

---

## 5. Saving & Sharing

### Save your work (git commit + push)

```
Save all my changes with a good commit message and push to GitHub.
```

### Create a new branch for a variation

```
Create a new git branch called [BRANCH NAME] for this variation so I can experiment without affecting the main version.
```

### Switch back to main version

```
Switch back to the main branch.
```

### Capture the prototype to Figma

```
Start the dev server and capture the UI in a new Figma file. Capture each page and each state (default, loading, empty, error) as separate frames. Name each frame clearly (e.g., "Dashboard - Default", "Dashboard - Empty State").
```

### Capture to an existing Figma file

```
Capture the current UI to this Figma file: [PASTE FIGMA FILE URL]. Add it as new frames alongside what's already there.
```

### Bring Figma changes back to code

```
The team updated the Figma design. Here's the updated version: [PASTE FIGMA URL]. Compare with the current prototype and update the code to match the new design.
```

### Deploy for sharing

```
Build the prototype for production and tell me how to share it with my team. Give me options: Figma capture, GitHub Pages, or a shareable URL.
```

---

## 6. Clean Up

### Extract images from Google Docs PRD

```
The PRD has large embedded images from Google Docs that are bloating the file. Run the clean-prd.sh script to extract them to docs/images/ and fix the markdown references.
```

### Update IDS tokens to latest

```
Re-download the latest IDS design tokens from the CDN for all brands. Save them to src/styles/tokens/. The CDN base URL is: https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css/
```

### Check what changed since last save

```
Show me what files I changed since my last git commit. Summarize the changes.
```

---

## Tips

- You can ask Claude Code anything in plain language — you don't need to use these exact prompts
- If Claude Code asks for permission, click **Allow** — it needs to read files, run commands, and install packages
- If Claude Code seems stuck, type `/clear` to start a fresh conversation (your code is still there)
- For the best results, be specific: "Make the header sticky" is better than "Fix the header"
- Claude Code reads CLAUDE.md automatically — it already knows about IDS, accessibility rules, and the design workflow
