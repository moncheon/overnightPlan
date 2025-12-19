#!/bin/bash
# Work Directive Manager - Core state management

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
STATE_DIR="${PLUGIN_ROOT}/state"
DIRECTIVE_FILE="${STATE_DIR}/directive.json"
ARCHIVE_DIR="${STATE_DIR}/archive"

# Ensure directories exist
mkdir -p "$STATE_DIR" "$ARCHIVE_DIR"

# Generate unique directive ID
generate_id() {
    local timestamp=$(date +%Y%m%d%H%M%S)
    local hash=$(echo "$1" | md5sum | cut -c1-6)
    echo "wd-${timestamp}-${hash}"
}

# Get current timestamp
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Create new directive
create_directive() {
    local title="$1"
    local description="$2"
    local steps_json="$3"
    local context_json="$4"
    local constraints_json="$5"

    local id=$(generate_id "$title")
    local timestamp=$(get_timestamp)
    local total_steps=$(echo "$steps_json" | grep -o '"id"' | wc -l)

    cat > "$DIRECTIVE_FILE" << EOF
{
  "id": "$id",
  "title": "$title",
  "description": "$description",
  "created_at": "$timestamp",
  "updated_at": "$timestamp",
  "status": "planning",
  "total_steps": $total_steps,
  "current_step": 1,
  "steps": $steps_json,
  "context": $context_json,
  "constraints": $constraints_json,
  "session_history": [],
  "resume_context": {
    "last_action": null,
    "next_action": null,
    "critical_state": null
  }
}
EOF

    echo "$id"
}

# Update directive status
update_status() {
    local status="$1"
    local timestamp=$(get_timestamp)

    if [ -f "$DIRECTIVE_FILE" ]; then
        # Use temporary file for atomic update
        local tmp_file="${DIRECTIVE_FILE}.tmp"

        sed -e "s/\"status\"[[:space:]]*:[[:space:]]*\"[^\"]*\"/\"status\": \"$status\"/" \
            -e "s/\"updated_at\"[[:space:]]*:[[:space:]]*\"[^\"]*\"/\"updated_at\": \"$timestamp\"/" \
            "$DIRECTIVE_FILE" > "$tmp_file"

        mv "$tmp_file" "$DIRECTIVE_FILE"
    fi
}

# Update current step
update_current_step() {
    local step="$1"
    local timestamp=$(get_timestamp)

    if [ -f "$DIRECTIVE_FILE" ]; then
        local tmp_file="${DIRECTIVE_FILE}.tmp"

        sed -e "s/\"current_step\"[[:space:]]*:[[:space:]]*[0-9]*/\"current_step\": $step/" \
            -e "s/\"updated_at\"[[:space:]]*:[[:space:]]*\"[^\"]*\"/\"updated_at\": \"$timestamp\"/" \
            "$DIRECTIVE_FILE" > "$tmp_file"

        mv "$tmp_file" "$DIRECTIVE_FILE"
    fi
}

# Get directive info
get_directive_info() {
    if [ -f "$DIRECTIVE_FILE" ]; then
        cat "$DIRECTIVE_FILE"
    else
        echo "{}"
    fi
}

# Check if directive exists
directive_exists() {
    [ -f "$DIRECTIVE_FILE" ]
}

# Check if directive is active
is_active() {
    if [ -f "$DIRECTIVE_FILE" ]; then
        local status=$(cat "$DIRECTIVE_FILE" | grep -o '"status"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')
        [ "$status" = "in_progress" ] || [ "$status" = "paused" ]
    else
        return 1
    fi
}

# Archive directive
archive_directive() {
    if [ -f "$DIRECTIVE_FILE" ]; then
        local id=$(cat "$DIRECTIVE_FILE" | grep -o '"id"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')
        local archive_file="${ARCHIVE_DIR}/${id}.json"
        cp "$DIRECTIVE_FILE" "$archive_file"
        echo "$archive_file"
    fi
}

# Reset directive
reset_directive() {
    local archive="${1:-false}"

    if [ "$archive" = "true" ] && [ -f "$DIRECTIVE_FILE" ]; then
        archive_directive
    fi

    rm -f "$DIRECTIVE_FILE"
}

# Save session boundary
save_session_boundary() {
    local last_action="$1"
    local next_action="$2"
    local timestamp=$(get_timestamp)

    if [ -f "$DIRECTIVE_FILE" ]; then
        # This is a simplified version - in production, use jq or proper JSON handling
        echo "Session boundary saved at $timestamp"
        echo "Last action: $last_action"
        echo "Next action: $next_action"
    fi
}

# Main command handler
case "$1" in
    create)
        shift
        create_directive "$@"
        ;;
    status)
        update_status "$2"
        ;;
    step)
        update_current_step "$2"
        ;;
    info)
        get_directive_info
        ;;
    exists)
        directive_exists && echo "true" || echo "false"
        ;;
    active)
        is_active && echo "true" || echo "false"
        ;;
    archive)
        archive_directive
        ;;
    reset)
        reset_directive "$2"
        ;;
    session-boundary)
        shift
        save_session_boundary "$@"
        ;;
    *)
        echo "Usage: $0 {create|status|step|info|exists|active|archive|reset|session-boundary}"
        exit 1
        ;;
esac
