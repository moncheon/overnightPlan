# ClaudeNightsWatch Setup Guide

## Overview
This guide will help you set up ClaudeNightsWatch for autonomous task execution in GitHub Codespaces with Claude Code CLI.

## Prerequisites
- GitHub Codespaces environment
- Claude Code CLI installed and configured
- Bash shell access
- Git repository access

## Installation Steps

### 1. Verify Files
All necessary files should be present in the repository:
```bash
ls -la /home/user/overnightPlan/
```

Expected files:
- `claude-nights-watch-daemon.sh` - Core daemon process
- `claude-nights-watch-manager.sh` - Management interface
- `setup-nights-watch.sh` - Interactive setup script
- `view-logs.sh` - Log viewer
- `task.md` - Task definitions
- `rules.md` - Safety rules
- `.claude-plugin/` - Plugin metadata
- `commands/` - Slash commands
- `agents/` - AI agents
- `hooks/` - Event handlers
- `mcp-server/` - MCP server
- `logs/` - Log files (created on first run)

### 2. Verify Permissions
Ensure all scripts are executable:
```bash
chmod +x *.sh
chmod +x commands/bin/*
chmod +x hooks/scripts/*.sh
chmod +x mcp-server/*.sh
```

### 3. Check Daemon Status
Verify the daemon manager works:
```bash
./claude-nights-watch-manager.sh status
```

### 4. Review Task and Rules Files
- Edit `task.md` to define your autonomous tasks
- Edit `rules.md` to set safety constraints

### 5. Test Configuration
Run the setup script:
```bash
./setup-nights-watch.sh
```

## Usage

### Starting the Daemon
```bash
./claude-nights-watch-manager.sh start
```

### Starting with Scheduled Time
```bash
./claude-nights-watch-manager.sh start --at "09:00"
./claude-nights-watch-manager.sh start --at "2025-12-20 14:30"
```

### Checking Status
```bash
./claude-nights-watch-manager.sh status
```

### Viewing Logs
```bash
./claude-nights-watch-manager.sh logs
./claude-nights-watch-manager.sh logs -f  # Follow mode
./view-logs.sh  # Interactive viewer
```

### Stopping the Daemon
```bash
./claude-nights-watch-manager.sh stop
```

### Restarting
```bash
./claude-nights-watch-manager.sh restart
```

## Configuration

### Task File (task.md)
Define what Claude should do autonomously:
- Clear objectives
- Specific tasks with detailed steps
- Constraints and boundaries
- Success criteria
- Environment details

### Rules File (rules.md)
Define safety constraints:
- Critical rules (never violate)
- Best practices
- Allowed actions
- Forbidden actions
- Execution limits
- Retry logic

## Claude Code Plugin Integration

### Plugin Structure
The repository is configured as a Claude Code plugin with:
- **Slash Commands**: `/nights-watch start/stop/status/logs/task/setup/restart`
- **AI Agent**: Task Executor for autonomous guidance
- **MCP Server**: Programmatic control tools
- **Smart Hooks**: Session integration

### Installing as Plugin
```bash
claude plugins add /home/user/overnightPlan
```

### Using Plugin Commands
Within Claude Code:
```
/nights-watch start
/nights-watch status
/nights-watch logs
```

## Environment Variables

### CLAUDE_NIGHTS_WATCH_DIR
Set the directory containing task.md and rules.md:
```bash
export CLAUDE_NIGHTS_WATCH_DIR=/home/user/overnightPlan
```

Default: current working directory

## Monitoring

### Log Files
All logs are stored in `logs/` directory:
- `claude-nights-watch-daemon.log` - Main daemon log
- `claude-nights-watch-daemon.pid` - Process ID file

### Log Format
Each log entry includes:
- Timestamp
- Full prompts sent to Claude
- Complete responses from Claude
- Status messages
- Error details

## Troubleshooting

### Daemon Won't Start
1. Check if Claude CLI is installed: `which claude`
2. Verify task.md exists: `ls -l task.md`
3. Check permissions: `ls -l *.sh`
4. Review logs: `./claude-nights-watch-manager.sh logs`

### Tasks Not Executing
1. Verify daemon is running: `./claude-nights-watch-manager.sh status`
2. Check task.md is not empty: `cat task.md`
3. Review rules.md constraints: `cat rules.md`
4. Check logs for errors: `tail -50 logs/claude-nights-watch-daemon.log`

### Permission Errors
```bash
chmod +x *.sh
chmod +x commands/bin/nights-watch
chmod +x hooks/scripts/*.sh
chmod +x mcp-server/*.sh
```

### Git Push Failures
- Verify branch name: `git branch --show-current`
- Check remote: `git remote -v`
- Retry with backoff (automated in rules.md)

## Safety Considerations

⚠️ **Warning**: This tool uses `--dangerously-skip-permissions` for autonomous execution.

### Best Practices:
1. Test tasks manually before enabling autonomous execution
2. Use comprehensive rules.md to prevent destructive actions
3. Start with simple, safe tasks
4. Monitor logs regularly
5. Keep backups of important data
6. Run in isolated environments when possible

### Recommended Restrictions:
- Limit file system access to project directory
- Prohibit deletion commands
- Prevent system modifications
- Restrict network access
- Set resource limits
- Enforce git branch restrictions

## GitHub Codespaces Specific

### Environment
- Working directory: `/home/user/overnightPlan`
- User: `root` or codespace user
- Shell: bash
- Git: Configured with credentials

### Codespaces Considerations
- Respect resource limits
- Don't modify Codespaces configuration
- Work within user home directory
- Use designated git branch
- Follow port forwarding rules

## Next Steps

1. Review and customize `task.md` for your project
2. Adjust safety rules in `rules.md`
3. Test the daemon: `./claude-nights-watch-manager.sh start`
4. Monitor initial executions: `./claude-nights-watch-manager.sh logs -f`
5. Iterate and refine based on results

## Support

For issues, questions, or contributions:
- Original Repository: https://github.com/aniketkarne/ClaudeNightsWatch
- License: MIT
- Author: Aniket Karne

## References

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [ccusage NPM Package](https://www.npmjs.com/package/ccusage)
- [ClaudeNightsWatch README](README.md)
