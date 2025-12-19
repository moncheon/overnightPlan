#!/bin/bash
# Session Restart Daemon - Monitors and restarts work after session expiration

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
STATE_DIR="${PLUGIN_ROOT}/state"
DIRECTIVE_FILE="${STATE_DIR}/directive.json"
DAEMON_PID_FILE="${STATE_DIR}/daemon.pid"
DAEMON_LOG="${STATE_DIR}/daemon.log"

# Default configuration
CHECK_INTERVAL=${CHECK_INTERVAL:-60}  # seconds
SESSION_TIMEOUT=${SESSION_TIMEOUT:-300}  # 5 minutes of inactivity
RESTART_DELAY=${RESTART_DELAY:-10}  # seconds to wait before restart

log() {
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "[$timestamp] $1" >> "$DAEMON_LOG"
    echo "[$timestamp] $1"
}

# Check if daemon is already running
is_running() {
    if [ -f "$DAEMON_PID_FILE" ]; then
        local pid=$(cat "$DAEMON_PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            return 0
        else
            rm -f "$DAEMON_PID_FILE"
        fi
    fi
    return 1
}

# Start the daemon
start_daemon() {
    if is_running; then
        log "Daemon already running"
        return 1
    fi

    log "Starting session restart daemon..."

    # Run in background
    nohup "$0" run >> "$DAEMON_LOG" 2>&1 &
    echo $! > "$DAEMON_PID_FILE"

    log "Daemon started with PID $(cat "$DAEMON_PID_FILE")"
}

# Stop the daemon
stop_daemon() {
    if [ -f "$DAEMON_PID_FILE" ]; then
        local pid=$(cat "$DAEMON_PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            log "Stopping daemon (PID: $pid)..."
            kill "$pid"
            rm -f "$DAEMON_PID_FILE"
            log "Daemon stopped"
        else
            rm -f "$DAEMON_PID_FILE"
            log "Daemon was not running"
        fi
    else
        log "No daemon PID file found"
    fi
}

# Get daemon status
daemon_status() {
    if is_running; then
        local pid=$(cat "$DAEMON_PID_FILE")
        echo "Daemon running (PID: $pid)"
        return 0
    else
        echo "Daemon not running"
        return 1
    fi
}

# Check if there's active work to resume
has_active_work() {
    if [ -f "$DIRECTIVE_FILE" ]; then
        local status=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"status"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')
        [ "$status" = "in_progress" ] || [ "$status" = "paused" ]
    else
        return 1
    fi
}

# Resume work by starting Claude
resume_work() {
    if ! has_active_work; then
        log "No active work to resume"
        return 1
    fi

    local title=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"title"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"\([^"]*\)"$/\1/')
    local current=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"current_step"[[:space:]]*:[[:space:]]*[0-9]*' | head -1 | sed 's/.*:[[:space:]]*//')
    local total=$(cat "$DIRECTIVE_FILE" 2>/dev/null | grep -o '"total_steps"[[:space:]]*:[[:space:]]*[0-9]*' | head -1 | sed 's/.*:[[:space:]]*//')

    log "Resuming work: $title (Step $current/$total)"

    # Create resume prompt
    local resume_prompt="Resume work directive: $title. Currently at step $current of $total. Use /work resume to continue."

    # Start Claude with resume prompt
    if command -v claude &> /dev/null; then
        echo "$resume_prompt" | claude --dangerously-skip-permissions -p
        log "Work resumed successfully"
    else
        log "ERROR: Claude CLI not found"
        return 1
    fi
}

# Main daemon loop
run_daemon() {
    log "Daemon loop started"

    local last_activity=$(date +%s)

    while true; do
        local current_time=$(date +%s)

        # Check for active work
        if has_active_work; then
            # Check if session seems to have timed out
            local time_since_activity=$((current_time - last_activity))

            if [ $time_since_activity -gt $SESSION_TIMEOUT ]; then
                log "Session timeout detected ($time_since_activity seconds)"
                log "Waiting $RESTART_DELAY seconds before restart..."
                sleep $RESTART_DELAY

                resume_work
                last_activity=$(date +%s)
            fi
        fi

        sleep $CHECK_INTERVAL
    done
}

# Command handler
case "$1" in
    start)
        start_daemon
        ;;
    stop)
        stop_daemon
        ;;
    status)
        daemon_status
        ;;
    restart)
        stop_daemon
        sleep 2
        start_daemon
        ;;
    run)
        run_daemon
        ;;
    resume)
        resume_work
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart|run|resume}"
        echo ""
        echo "Commands:"
        echo "  start   - Start the session restart daemon"
        echo "  stop    - Stop the daemon"
        echo "  status  - Check daemon status"
        echo "  restart - Restart the daemon"
        echo "  run     - Run daemon in foreground (internal use)"
        echo "  resume  - Manually trigger work resume"
        exit 1
        ;;
esac
