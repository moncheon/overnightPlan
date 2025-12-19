# Safety Rules for Overnight Plan

## CRITICAL RULES - NEVER VIOLATE THESE:

### 1. File System Safety
- **NEVER** use `rm -rf` or force deletion commands
- **NEVER** modify files outside /home/user/overnightPlan directory
- **NEVER** access or modify system files (/etc, /usr, /System, etc.)
- **ALWAYS** verify directory exists before writing files
- **ALWAYS** check file permissions before operations

### 2. Git Safety
- **NEVER** force push to any branch
- **NEVER** rewrite published git history
- **NEVER** delete remote branches
- **ALWAYS** work on branch: claude/session-restart-tool-YKG1p
- **ALWAYS** use conventional commit message format
- **NEVER** push to main or master branches
- **ALWAYS** verify branch name before pushing

### 3. Security Rules
- **NEVER** commit passwords, API keys, or secrets
- **NEVER** expose sensitive information in logs
- **NEVER** disable security features
- **NEVER** run commands with sudo privileges
- **ALWAYS** use environment variables for sensitive data
- **NEVER** include credentials in documentation

### 4. Network Safety
- **NEVER** perform port scanning or network attacks
- **NEVER** access unauthorized external services
- **NEVER** download executables from untrusted sources
- **ALWAYS** verify HTTPS certificates
- **ONLY** access approved git repository: moncheon/overnightPlan

### 5. Resource Management
- **NEVER** create infinite loops or resource-intensive operations
- **NEVER** consume excessive disk space (>500MB)
- **NEVER** spawn more than 5 concurrent processes
- **ALWAYS** clean up temporary files after operations
- **ALWAYS** close file handles properly

### 6. Codespaces Specific Rules
- **NEVER** modify Codespaces configuration files
- **NEVER** change port forwarding settings
- **NEVER** modify system environment variables
- **ALWAYS** work within user home directory
- **ALWAYS** respect Codespaces resource limits

## BEST PRACTICES:

### Development Workflow
1. Always verify current branch before making changes
2. Stage and review changes before committing
3. Use semantic versioning for releases if applicable
4. Follow existing code style and conventions
5. Document all significant changes in commit messages

### Error Handling
1. Catch and log all errors appropriately
2. Never suppress error messages
3. Fail gracefully with helpful error messages
4. Create rollback plans for risky operations
5. Log all errors to designated log files

### Communication
1. Log all significant actions with timestamps
2. Create summary reports after task completion
3. Highlight any issues or concerns in reports
4. Include execution details in final reports
5. Use clear and descriptive language

### Git Operations Best Practices
1. Verify branch name matches: claude/session-restart-tool-YKG1p
2. Always use `git push -u origin <branch-name>` format
3. Commit frequently with atomic changes
4. Never combine unrelated changes in one commit
5. Always verify remote repository before pushing

## ALLOWED ACTIONS:

### Code Operations
- Read and analyze source code in project directory
- Create new documentation files (*.md, *.txt)
- Modify existing project files within scope
- Run daemon scripts for verification
- Execute test commands
- View log files

### Git Operations
- Check current branch status
- Stage changes with git add
- Commit changes with descriptive messages
- Push to branch: claude/session-restart-tool-YKG1p
- View git history and diffs
- Check remote repository status

### Documentation
- Create documentation files (README, SETUP, TESTING, etc.)
- Update existing markdown files
- Create execution reports
- Add inline comments where helpful
- Write usage examples

### Verification Operations
- Test script executability
- Check file permissions
- Verify directory structure
- Test daemon functionality
- Review log file contents

## FORBIDDEN ACTIONS:

1. Accessing files outside /home/user/overnightPlan
2. Modifying system configuration files
3. Changing Codespaces settings
4. Installing system-level packages
5. Accessing other users' files or directories
6. Modifying git configuration
7. Changing file ownership or special permissions
8. Creating or modifying cron jobs
9. Modifying PATH or other environment variables
10. Pushing to branches other than claude/session-restart-tool-YKG1p

## EXECUTION LIMITS:

- Maximum execution time: 30 minutes per session
- Maximum file size for creation: 5MB
- Maximum number of files to modify: 50
- Maximum commits per session: 10
- Maximum log file size: 10MB
- Git push retry limit: 4 times with exponential backoff

## RETRY LOGIC:

### Git Push Retries
- Retry up to 4 times on network failures
- Use exponential backoff: 2s, 4s, 8s, 16s
- Log each retry attempt with timestamp
- Fail gracefully after max retries exceeded

### Git Fetch/Pull Retries
- Retry up to 4 times on network failures
- Use exponential backoff: 2s, 4s, 8s, 16s
- Prefer fetching specific branches
- Log all retry attempts

## BRANCH VERIFICATION:

Before ANY git push operation:
1. Verify current branch is: claude/session-restart-tool-YKG1p
2. Verify remote is: moncheon/overnightPlan
3. Verify branch name starts with 'claude/' and ends with matching session ID
4. If any verification fails, DO NOT PUSH and log the issue

Remember: When in doubt, choose the safer option and log the concern for review. Safety and data integrity are paramount.
