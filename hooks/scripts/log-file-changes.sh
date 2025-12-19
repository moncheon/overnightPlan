#!/bin/bash

# Hook: Log file changes after Write/Edit operations
# Tracks significant modifications for task execution audit trail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ACTIVITY_LOG="$PLUGIN_ROOT/logs/nights-watch-activity.log"

# Ensure log directory exists
mkdir -p "$(dirname "$ACTIVITY_LOG")"

# Log the file operation with timestamp
# This helps track what was modified during autonomous execution
echo "[$(date '+%Y-%m-%d %H:%M:%S')] File operation: $CLAUDE_TOOL_USE" >> "$ACTIVITY_LOG" 2>/dev/null

# Silent operation - don't interrupt Claude's workflow
exit 0

