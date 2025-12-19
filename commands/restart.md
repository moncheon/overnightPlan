---
description: Restart the Claude Nights Watch daemon to apply configuration changes
usage: /nights-watch restart [--at TIME]
examples:
  - /nights-watch restart
  - /nights-watch restart --at "09:00"
---

# Restart Nights Watch Daemon

Restart the Claude Nights Watch daemon by stopping the current instance and starting a new one. Useful after modifying task or rules files.

## Usage

```bash
/nights-watch restart [OPTIONS]
```

## Options

- `--at TIME` - Schedule daemon to start monitoring at a specific time after restart
  - Format: `HH:MM` (today) or `YYYY-MM-DD HH:MM` (specific date/time)

## What It Does

1. Stops the currently running daemon gracefully
2. Waits 2 seconds for clean shutdown
3. Starts a new daemon instance
4. Loads latest task.md and rules.md files
5. Resumes monitoring with fresh configuration

## When to Restart

Restart the daemon when you:
- Modified `task.md` and want to apply changes
- Updated `rules.md` safety constraints
- Changed environment variables
- Troubleshooting daemon issues
- Want to reschedule start time

## Examples

**Simple restart:**
```bash
/nights-watch restart
```

**Restart with new schedule:**
```bash
/nights-watch restart --at "09:00"
```

## Implementation

```bash
${CLAUDE_PLUGIN_ROOT}/claude-nights-watch-manager.sh restart "$@"
```

## Restart vs Stop/Start

- **Restart**: Automated stop + start in one command
- **Stop/Start**: Manual control over timing between operations

Both achieve the same result, restart is just more convenient.

## See Also

- `/nights-watch stop` - Stop daemon only
- `/nights-watch start` - Start daemon only
- `/nights-watch status` - Verify restart was successful

