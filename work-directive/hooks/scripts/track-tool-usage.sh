#!/bin/bash
# Track tool usage for progress estimation

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(dirname "$(dirname "$(dirname "$0")")")}"
STATE_DIR="${PLUGIN_ROOT}/state"
USAGE_LOG="${STATE_DIR}/tool-usage.log"

# Ensure state directory exists
mkdir -p "$STATE_DIR"

# Log tool usage with timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
TOOL_NAME="${TOOL_NAME:-unknown}"

echo "[$TIMESTAMP] Tool: $TOOL_NAME" >> "$USAGE_LOG"

# Keep log file size manageable (last 1000 entries)
if [ -f "$USAGE_LOG" ]; then
    LINES=$(wc -l < "$USAGE_LOG")
    if [ "$LINES" -gt 1000 ]; then
        tail -500 "$USAGE_LOG" > "${USAGE_LOG}.tmp"
        mv "${USAGE_LOG}.tmp" "$USAGE_LOG"
    fi
fi
