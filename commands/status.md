---
description: Check the status of Claude Nights Watch daemon and view current configuration
usage: /nights-watch status
examples:
  - /nights-watch status
---

# Nights Watch Status

Displays comprehensive status information about the Claude Nights Watch daemon, including running state, configuration, and recent activity.

## Usage

```bash
/nights-watch status
```

## Information Displayed

### Daemon State
- **Running/Stopped**: Current daemon status
- **PID**: Process ID if running
- **Activity Status**: 
  - ✅ ACTIVE - Currently monitoring and executing tasks
  - ⏰ WAITING - Waiting for scheduled start time

### Configuration
- **Task File**: Location and line count of `task.md`
- **Rules File**: Location and line count of `rules.md` (if present)
- **Start Time**: Scheduled start time (if configured)
- **Time Until Start**: Countdown if waiting for scheduled time

### Execution Info
- **Recent Activity**: Last 5 log entries
- **Next Execution**: Estimated time until next task execution
- **Time Since Last Activity**: Hours/minutes since last Claude usage

## Status Indicators

- `✅ ACTIVE` - Daemon is running and monitoring
- `⏰ WAITING` - Daemon is running but waiting for start time
- `❌ STOPPED` - Daemon is not running

## Examples

**Check daemon status:**
```bash
/nights-watch status
```

**Sample Output:**
```
[INFO] Daemon is running with PID 12345
[INFO] Status: ✅ ACTIVE - Task execution monitoring enabled

[TASK] Task file: /path/to/task.md (42 lines)
[TASK] Rules file: /path/to/rules.md (106 lines)

[INFO] Recent activity:
  [2025-10-11 14:30:00] Daemon started
  [2025-10-11 14:30:05] Task file loaded
  [2025-10-11 14:30:10] Monitoring began
  [2025-10-11 14:35:00] Next check in 10 minutes
  [2025-10-11 14:45:00] Time remaining: 234 minutes

[INFO] Estimated time until next task execution: 3h 54m
```

## Implementation

```bash
${CLAUDE_PLUGIN_ROOT}/claude-nights-watch-manager.sh status
```

## See Also

- `/nights-watch start` - Start the daemon
- `/nights-watch logs` - View detailed logs
- `/nights-watch task` - View current task configuration

