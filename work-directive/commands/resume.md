---
description: Resume work from the last saved state after session expiration or interruption
usage: /work resume
examples:
  - /work resume
  - /work resume --show-context
---

# Resume Work Directive

Resumes execution from the last saved state. This command is automatically suggested when a session starts with an incomplete directive.

## Usage

```bash
/work resume [OPTIONS]
```

## Options

- `--show-context` - Display full resume context before continuing
- `--from-step N` - Resume from a specific step instead of current

## What It Does

1. **Loads Saved State**
   - Reads `state/directive.json`
   - Validates directive exists and is incomplete
   - Loads resume context

2. **Displays Progress Summary**
   - Shows completed steps
   - Shows current/next step
   - Displays session history

3. **Restores Context**
   - Loads key files information
   - Restores working state
   - Applies any critical context

4. **Continues Execution**
   - Resumes from `current_step`
   - Maintains progress tracking
   - Handles subsequent session boundaries

## Resume Context

The resume context includes:
- `last_action`: What was being done when session ended
- `next_action`: What should be done next
- `critical_state`: Any state that must be preserved
- Key files and their states

## Automatic Resume

On session start, if an incomplete directive exists:

```
## Active Work Directive Detected

**Title:** {directive.title}
**Progress:** {current_step}/{total_steps} steps

### Completed:
- [x] Step 1: {title}
- [x] Step 2: {title}

### In Progress:
- [ ] Step 3: {title}

### Resume Context:
{resume_context.last_action}

Continue with this directive? [Y/n]
```

## Example

```
$ /work resume

## Resuming Work Directive

**Title:** REST API for Users
**Progress:** 4/10 steps complete

### Session History:
- Session 1 (2h ago): Steps 1-2
- Session 2 (1h ago): Steps 3-4 (partial)

### Last State:
Step 4 was in progress: "Create CRUD endpoints (Create)"
POST /users endpoint implemented
Validation pending

### Resuming from:
Step 4 - Completing validation implementation

---

Continuing execution...
```

## Recovery Scenarios

### Normal Resume
Previous session ended gracefully with saved state.
- Full context available
- Continue from exact position

### Abrupt Interruption
Session ended unexpectedly.
- State may be partially saved
- Resume from last confirmed checkpoint

### Failed Step Recovery
Previous step failed and was logged.
- Error details available
- Option to retry or skip

## State Requirements

Resume requires:
- `state/directive.json` exists
- Directive status is `in_progress` or `paused`
- At least one step is not completed

## See Also

- `/work plan` - Create new directive
- `/work execute` - Start fresh execution
- `/work status` - View without resuming
- `/work reset` - Clear and start over
