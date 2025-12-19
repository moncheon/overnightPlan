#!/bin/bash

# Hook: Session end prompt
# Reminds users about daemon if task.md exists but daemon isn't running

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PID_FILE="$PLUGIN_ROOT/logs/claude-nights-watch-daemon.pid"
TASK_FILE="$(pwd)/task.md"

# Check if task.md exists in current directory
if [ -f "$TASK_FILE" ]; then
    # Check if daemon is running
    DAEMON_RUNNING=false
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if kill -0 "$PID" 2>/dev/null; then
            DAEMON_RUNNING=true
        fi
    fi
    
    # If task exists but daemon not running, suggest starting it
    if [ "$DAEMON_RUNNING" = false ]; then
        echo ""
        echo "💡 You have a task.md file but Nights Watch daemon isn't running."
        echo "   Start autonomous execution: /nights-watch start"
    fi
fi

exit 0

