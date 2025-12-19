---
description: Interactive setup wizard for Claude Nights Watch configuration
usage: /nights-watch setup
examples:
  - /nights-watch setup
---

# Nights Watch Setup Wizard

Launch the interactive setup wizard to configure Claude Nights Watch for the first time or modify existing configuration.

## Usage

```bash
/nights-watch setup
```

## Setup Process

The wizard guides you through:

### 1. Prerequisites Check
- ✓ Verify Claude CLI is installed
- ✓ Check for ccusage (for accurate timing)
- ✓ Confirm required permissions

### 2. Task Configuration
- Create or edit `task.md` file
- Enter task instructions
- Review and modify as needed

### 3. Safety Rules Configuration
- Create or edit `rules.md` file
- Choose from default safety templates
- Customize rules for your project

### 4. Daemon Configuration
- Choose to start daemon immediately or later
- Optionally schedule a start time
- Configure monitoring preferences

### 5. Summary
- Review all configuration
- Display available commands
- Optionally start daemon

## Interactive Prompts

```
================================
Claude Nights Watch Setup
================================

Checking prerequisites...
✓ Claude CLI found
! ccusage not found (will use time-based checking)
To install ccusage: npm install -g ccusage

=== Task Configuration ===
task.md already exists
Do you want to view/edit it? (y/n)

=== Safety Rules Configuration ===
Do you want to create safety rules? (recommended) (y/n)

=== Daemon Configuration ===
Do you want to start the daemon after setup? (y/n)
Do you want to schedule a start time? (y/n)
Enter start time (HH:MM for today, or YYYY-MM-DD HH:MM):

=== Setup Complete ===
✓ Task file: /path/to/task.md
✓ Rules file: /path/to/rules.md
✓ Manager: /path/to/claude-nights-watch-manager.sh

Available commands:
  /nights-watch start    - Start the daemon
  /nights-watch stop     - Stop the daemon
  /nights-watch status   - Check daemon status
  /nights-watch logs     - View logs
  /nights-watch task     - View current task

Starting daemon...
```

## What Gets Created

### Files Created
- `task.md` - Your task instructions (if doesn't exist)
- `rules.md` - Safety rules (optional, if requested)
- `logs/` - Directory for daemon logs (on first start)

### Files NOT Modified
- Existing `task.md` - Only edited if you choose to
- Existing `rules.md` - Only edited if you choose to
- Any project files

## First-Time Setup

If you're setting up for the first time:

1. Run `/nights-watch setup`
2. Create a simple test task:
```markdown
# Test Task
1. Create a file called test-output.txt
2. Write "Hello from Claude Nights Watch" to it
3. Report success
```
3. Add basic safety rules (wizard provides template)
4. Start daemon and monitor with `/nights-watch status`
5. Check logs with `/nights-watch logs -f`

## Implementation

```bash
${CLAUDE_PLUGIN_ROOT}/setup-nights-watch.sh
```

## Environment Variables

- `CLAUDE_NIGHTS_WATCH_DIR` - Set custom task directory (default: current directory)
- `EDITOR` - Preferred text editor (default: nano)

## See Also

- `/nights-watch start` - Start daemon after setup
- `/nights-watch task` - View configured tasks
- Example files: `${CLAUDE_PLUGIN_ROOT}/examples/`

