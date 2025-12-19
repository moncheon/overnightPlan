---
description: Stop the Claude Nights Watch daemon and halt autonomous task execution
usage: /nights-watch stop
examples:
  - /nights-watch stop
---

# Stop Nights Watch Daemon

Stops the running Claude Nights Watch daemon gracefully, halting all autonomous task execution monitoring.

## Usage

```bash
/nights-watch stop
```

## What It Does

1. Locates the running daemon process
2. Sends graceful shutdown signal (SIGTERM)
3. Waits up to 10 seconds for clean shutdown
4. Force kills if necessary (SIGKILL)
5. Cleans up PID file and resources

## Behavior

- **Graceful Shutdown**: Daemon completes current operations before stopping
- **10-Second Timeout**: If not stopped gracefully, force kill is applied
- **Safe**: Any running Claude task is allowed to complete
- **Clean State**: All PID files and locks are removed

## Examples

```bash
/nights-watch stop
```

## Implementation

```bash
${CLAUDE_PLUGIN_ROOT}/claude-nights-watch-manager.sh stop
```

## Exit Codes

- `0` - Daemon stopped successfully
- `1` - Daemon was not running or error occurred

## See Also

- `/nights-watch start` - Start the daemon
- `/nights-watch restart` - Restart the daemon
- `/nights-watch status` - Check if daemon is running

