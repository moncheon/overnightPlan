#!/bin/bash
# Check for active work directive on session start

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(dirname "$(dirname "$(dirname "$0")")")}"
STATE_DIR="${PLUGIN_ROOT}/state"
DIRECTIVE_FILE="${STATE_DIR}/directive.json"

# Check if directive file exists
if [ ! -f "$DIRECTIVE_FILE" ]; then
    exit 0
fi

# Read directive status
STATUS=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"status"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')

# If directive is in_progress or paused, notify
if [ "$STATUS" = "in_progress" ] || [ "$STATUS" = "paused" ]; then
    TITLE=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"title"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')
    CURRENT=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"current_step"[[:space:]]*:[[:space:]]*[0-9]*' | head -1 | sed 's/.*:[[:space:]]*//')
    TOTAL=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"total_steps"[[:space:]]*:[[:space:]]*[0-9]*' | head -1 | sed 's/.*:[[:space:]]*//')

    echo "---"
    echo "## Active Work Directive Detected"
    echo ""
    echo "**Title:** $TITLE"
    echo "**Progress:** Step $CURRENT of $TOTAL"
    echo "**Status:** $STATUS"
    echo ""
    echo "Use \`/work resume\` to continue or \`/work status\` to view details."
    echo "---"
fi
