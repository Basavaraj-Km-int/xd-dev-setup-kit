# Design Document

> This file is generated and maintained collaboratively by the designer and Claude Code.
> Fixed sections provide structure. Project-specific sections are filled in per project.

---

## Customer Problem Statement

```
I am...            [narrow description of the customer]
I am trying to...  [desired outcome]
But...             [barrier]
Because...         [root cause]
Which makes me feel... [emotion]
```

---

## Ideal State

```
In a perfect world...          [bold future state -- outcomes, not solutions]
The biggest benefit to me is... [improvement in customer's life]
Which makes me feel...         [opposite emotions from problem statement]
```

---

## Hypothesis

```
If we...                    [experience presented to customer]
Then...                     [expected behavior]
Which we will measure by... [metrics]
Success metric will be...   [threshold]
```

---

## Leap of Faith Assumptions (LOFAs)

| # | Assumption | Crucial for Success | Proven | LOFA? |
|---|-----------|-------------------|--------|-------|
| 1 | [Assumption] | Yes/No | Yes/No | Yes/No |
| 2 | [Assumption] | Yes/No | Yes/No | Yes/No |
| 3 | [Assumption] | Yes/No | Yes/No | Yes/No |

**Which LOFA does this prototype test?**
[Specific assumption being validated]

---

## User Flows

### Pages Overview

| Page | Purpose | Entry Points | Exit Points |
|------|---------|-------------|-------------|
| [Page 1] | [What problem it solves] | [How users arrive] | [Where users go next] |
| [Page 2] | [What problem it solves] | [How users arrive] | [Where users go next] |

### Flow: [Primary Flow Name]

```
[Screen A] → user action → [Screen B]
[Screen B] → decision point
  ├── Yes → [Screen C]
  └── No  → [Screen D]
[Screen C] → success → [Screen E]
  └── Error → [Screen C with error state]
```

### Flow: [Secondary Flow Name]

```
[Add flow here]
```

---

## Screen Inventory

### [Screen Name]

- **Purpose**: [What user problem this screen solves]
- **Entry points**: [How users arrive here]
- **Content sections**: [Header, primary content, actions, secondary info]
- **Key interactions**: [What users do on this screen]
- **Exit points**: [Where users go next]
- **States**: default, loading, empty, error, success
- **IDS components**: [Which @ids-ts components to use]

### [Screen Name]

- **Purpose**:
- **Entry points**:
- **Content sections**:
- **Key interactions**:
- **Exit points**:
- **States**:
- **IDS components**:

---

## User Stories

### Epic: [Feature Name]

#### Story 1: [Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] Given [context], when [action], then [outcome]
- [ ] Given [context], when [action], then [outcome]
- [ ] Error: when [failure], show [feedback]
- [ ] Loading: while [processing], show [indicator]
- [ ] Empty: when [no data], show [guidance]
- [ ] Accessibility: [specific requirement]

#### Story 2: [Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] Given [context], when [action], then [outcome]

---

## Design Decisions Log

| Date | Decision | Rationale | Alternatives Considered |
|------|----------|-----------|------------------------|
| [Date] | [What was decided] | [Why — tied to user problem] | [What else was considered] |

---

## Prototype Notes

**What this prototype tests**: [Which LOFA / hypothesis]

**What is mocked / faked**: [What is not real in this prototype]

**Known limitations**: [What does not work yet]

**Next iteration**: [What to improve based on learnings]
