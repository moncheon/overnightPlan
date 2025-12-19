#!/bin/bash
# Save work directive state before session ends

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(dirname "$(dirname "$(dirname "$0")")")}"
STATE_DIR="${PLUGIN_ROOT}/state"
DIRECTIVE_FILE="${STATE_DIR}/directive.json"
SESSION_LOG="${STATE_DIR}/session.log"

# Ensure state directory exists
mkdir -p "$STATE_DIR"

# Check if directive file exists and is in progress
if [ ! -f "$DIRECTIVE_FILE" ]; then
    exit 0
fi

STATUS=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"status"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')

if [ "$STATUS" != "in_progress" ]; then
    exit 0
fi

# Log session end
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "[$TIMESTAMP] Session ended - directive state preserved" >> "$SESSION_LOG"

# The directive.json should already be saved by the agent
# This hook just logs the session boundary
echo "---"
echo "## Session Boundary"
echo ""
echo "Work directive state has been preserved."
echo "Progress will continue in the next session."
echo "---"
