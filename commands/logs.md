---
description: View Claude Nights Watch execution logs with filtering and follow options
usage: /nights-watch logs [OPTIONS]
examples:
  - /nights-watch logs
  - /nights-watch logs -f
  - /nights-watch logs --follow
---

# View Nights Watch Logs

Display execution logs from the Claude Nights Watch daemon, including all prompts sent to Claude, responses received, and status messages.

## Usage

```bash
/nights-watch logs [OPTIONS]
```

## Options

- `-f`, `--follow` - Follow log file in real-time (like `tail -f`)
- No options - Show last 50 lines of logs

## What's Logged

### Daemon Activity
- Start/stop events
- Configuration loaded
- Monitoring status updates
- Error messages and warnings

### Task Execution
- **Full Prompts**: Complete prompt sent to Claude (rules + task)
- **Full Responses**: Everything Claude outputs during execution
- **Timestamps**: Precise timing of all events
- **Exit Codes**: Success/failure status

### Example Log Entry
```
[2025-10-11 14:30:00] === Claude Nights Watch Daemon Started ===
[2025-10-11 14:30:00] PID: 12345
[2025-10-11 14:30:00] Task directory: /path/to/project
[2025-10-11 14:30:05] Task file found at /path/to/project/task.md
[2025-10-11 14:30:05] Rules file found at /path/to/project/rules.md
[2025-10-11 15:25:00] Time remaining: 2 minutes
[2025-10-11 15:27:00] Reset imminent (2 minutes), preparing to execute task...
[2025-10-11 15:28:00] Starting task execution from task.md...

=== PROMPT SENT TO CLAUDE ===
IMPORTANT RULES TO FOLLOW:
[... rules content ...]
---END OF RULES---

TASK TO EXECUTE:
[... task content ...]
---END OF TASK---
=== END OF PROMPT ===

=== CLAUDE RESPONSE START ===
[... Claude's complete response ...]
=== CLAUDE RESPONSE END ===

[2025-10-11 15:42:00] Task execution completed successfully
```

## Examples

**View recent logs:**
```bash
/nights-watch logs
```

**Follow logs in real-time:**
```bash
/nights-watch logs -f
```

**Use interactive log viewer:**
```bash
# For more advanced viewing with filtering
${CLAUDE_PLUGIN_ROOT}/view-logs.sh
```

## Implementation

```bash
${CLAUDE_PLUGIN_ROOT}/claude-nights-watch-manager.sh logs "$@"
```

## Interactive Log Viewer

For advanced log viewing with filtering options, use the interactive viewer:

```bash
${CLAUDE_PLUGIN_ROOT}/view-logs.sh
```

Features:
- Browse all log files
- View full logs or last 50 lines
- Filter to see only prompts
- Filter to see only responses
- Search for errors
- Real-time following

## Log Location

Logs are stored in:
```
${CLAUDE_PLUGIN_ROOT}/logs/claude-nights-watch-daemon.log
```

## See Also

- `/nights-watch status` - Check daemon status
- `/nights-watch task` - View current task

