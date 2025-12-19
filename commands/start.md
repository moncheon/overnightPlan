---
description: Start the Claude Nights Watch daemon to begin autonomous task execution monitoring
usage: /nights-watch start [--at TIME]
examples:
  - /nights-watch start
  - /nights-watch start --at "09:00"
  - /nights-watch start --at "2025-10-12 14:30"
---

# Start Nights Watch Daemon

Starts the Claude Nights Watch daemon to monitor your Claude usage windows and execute tasks from `task.md` automatically.

## Usage

```bash
/nights-watch start [OPTIONS]
```

## Options

- `--at TIME` - Schedule daemon to start monitoring at a specific time
  - Format: `HH:MM` (today) or `YYYY-MM-DD HH:MM` (specific date/time)
  - Daemon will wait until scheduled time before beginning task execution

## What It Does

1. Checks for required files (`task.md` in current directory)
2. Starts background daemon process
3. Begins monitoring Claude usage windows
4. Executes tasks when approaching the 5-hour limit
5. Logs all activity to `logs/claude-nights-watch-daemon.log`

## Prerequisites

- `task.md` file must exist in current directory (create one if not present)
- `rules.md` file is recommended for safety constraints (optional)
- Claude CLI must be installed and configured

## Examples

**Start immediately:**
```bash
/nights-watch start
```

**Start at 9 AM today:**
```bash
/nights-watch start --at "09:00"
```

**Start at specific date and time:**
```bash
/nights-watch start --at "2025-10-12 14:30"
```

## Implementation

```bash
${CLAUDE_PLUGIN_ROOT}/claude-nights-watch-manager.sh start "$@"
```

## Safety Notice

⚠️ The daemon uses `--dangerously-skip-permissions` for autonomous execution. Always:
- Test tasks manually first
- Use comprehensive `rules.md` for safety constraints
- Monitor logs regularly
- Start with simple, non-destructive tasks

## See Also

- `/nights-watch stop` - Stop the daemon
- `/nights-watch status` - Check daemon status
- `/nights-watch task` - View/edit current task
- `/nights-watch logs` - View execution logs

