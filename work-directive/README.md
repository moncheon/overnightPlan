# Work Directive Plugin

Session-aware task planning and execution system for Claude Code. Creates structured work directives, tracks progress across sessions, and automatically resumes work after session expiration.

## Key Features

- **Work Directives**: Break complex tasks into manageable, trackable steps
- **Session Persistence**: Progress saved automatically before session boundaries
- **Automatic Resume**: Work continues seamlessly in new sessions
- **Agent-Friendly**: Structured output for automation and orchestration
- **Context Preservation**: Critical state maintained across interruptions

## Installation

```bash
# Install as Claude Code plugin
claude plugins add /path/to/work-directive

# Or from marketplace (when available)
claude plugins add work-directive
```

## Quick Start

### 1. Plan Your Work
```bash
/work plan "Implement user authentication with JWT, login, logout, and password reset"
```

The agent will:
- Analyze your query
- Break it into logical steps
- Present a plan for approval
- Save the directive

### 2. Execute
```bash
/work execute
```

Work proceeds step by step with:
- Progress tracking
- Artifact documentation
- Automatic state saving

### 3. Session Boundary
When approaching context limits, the system:
- Saves current state
- Documents resume context
- Creates continuation instructions

### 4. Resume (automatically or manually)
```bash
/work resume
```

New sessions detect active directives and offer to continue.

## Commands

| Command | Description |
|---------|-------------|
| `/work plan [query]` | Create a new work directive from query |
| `/work execute` | Execute the current directive |
| `/work resume` | Resume from saved state |
| `/work status` | View current progress |
| `/work reset` | Clear current directive |

## How It Works

### Work Directive Structure

```json
{
  "id": "wd-20250119-a7f3",
  "title": "Task Title",
  "status": "in_progress",
  "steps": [
    {
      "id": 1,
      "title": "Step title",
      "status": "completed",
      "artifacts": ["files created"],
      "output_summary": "what was done"
    }
  ],
  "resume_context": {
    "last_action": "what was being done",
    "next_action": "what to do next"
  }
}
```

### Session Flow

```
[User Query]
     |
     v
[Create Directive] --> [state/directive.json]
     |
     v
[Execute Steps] --> [Track Progress]
     |
     v
[Session Boundary?]
     |
   Yes --> [Save State] --> [Output Resume Instructions]
     |
    No
     |
     v
[Continue Until Complete]
```

### Resume Flow

```
[New Session Start]
     |
     v
[Check directive.json]
     |
     v
[Active Directive?]
     |
   Yes --> [Load Context] --> [Continue Execution]
     |
    No
     |
     v
[Ready for New Work]
```

## Session Restart Daemon

For fully autonomous operation, the plugin includes a daemon that monitors for session expiration and automatically restarts work:

```bash
# Start daemon
./scripts/session-restart-daemon.sh start

# Check status
./scripts/session-restart-daemon.sh status

# Stop daemon
./scripts/session-restart-daemon.sh stop
```

The daemon:
- Monitors for incomplete directives
- Detects session timeouts
- Automatically resumes work
- Logs all activity

## Examples

### Simple Task
```bash
/work plan "Add input validation to the registration form"
```

### Complex Multi-Session Task
```bash
/work plan "Refactor the database layer to use connection pooling, add caching, and update all services"
```

See `examples/` directory for detailed examples.

## Agent-Friendly Features

### Structured Markers
Output includes parseable markers for automation:
```
[STEP_COMPLETE:1]
[PROGRESS:2/5]
[SESSION_BOUNDARY]
[RESUME_POINT:step=3,action="Continue implementation"]
```

### JSON State
All state stored in JSON for programmatic access:
- `state/directive.json` - Current directive
- `state/archive/*.json` - Completed directives

### Predictable Hooks
Session events trigger defined hooks:
- `SessionStart` - Check for active work
- `SessionEnd` - Save state
- `PreToolUse` - Track activity

## Configuration

Environment variables:
- `CHECK_INTERVAL` - Daemon check interval (default: 60s)
- `SESSION_TIMEOUT` - Inactivity timeout (default: 300s)
- `RESTART_DELAY` - Delay before restart (default: 10s)

## File Structure

```
work-directive/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest
│   └── marketplace.json     # Marketplace entry
├── agents/
│   └── directive-planner.md # Planning agent
├── commands/
│   ├── plan.md              # Create directive
│   ├── execute.md           # Execute directive
│   ├── resume.md            # Resume work
│   ├── status.md            # View status
│   └── reset.md             # Reset directive
├── hooks/
│   ├── hooks.json           # Hook configuration
│   └── scripts/
│       ├── check-directive.sh
│       ├── save-session-state.sh
│       └── track-tool-usage.sh
├── scripts/
│   ├── directive-manager.sh    # State management
│   └── session-restart-daemon.sh # Auto-restart
├── state/                    # Runtime state
│   ├── directive.json       # Current directive
│   └── archive/             # Completed directives
└── examples/
    ├── directive.example.json
    ├── simple-task.example.md
    └── complex-task.example.md
```

## Best Practices

1. **Detailed Queries**: More detail = better planning
2. **Review Plans**: Check the directive before executing
3. **Let It Save**: Don't interrupt during step completion
4. **Check Status**: Use `/work status` to monitor progress
5. **Archive Important Work**: Use `/work reset --archive`

## Safety

- Progress saved atomically (no partial writes)
- Archives preserved for recovery
- Session history fully tracked
- All actions logged

## Integration with Overnight Plugin

This plugin complements the Claude Nights Watch daemon:
- Use Work Directive for structured task planning
- Use Nights Watch for scheduled execution windows
- Combined: Full autonomous task management

## License

MIT

## Contributing

Contributions welcome! Please follow the existing code style and include tests for new features.
