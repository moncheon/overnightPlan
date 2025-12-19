---
description: Create a work directive from a complex query. Breaks down tasks into steps for session-aware execution.
usage: /work plan [query]
examples:
  - /work plan "Implement user authentication with login and password reset"
  - /work plan "Refactor the database layer to use connection pooling"
  - /work plan "Create comprehensive API documentation with examples"
---

# Create Work Directive

Creates a structured work directive from a complex query. The directive breaks down the task into manageable steps that can be executed across multiple sessions.

## Usage

```bash
/work plan [query]
```

## What It Does

1. **Analyzes the Query**
   - Parses the user's request
   - Identifies main objectives
   - Determines scope and complexity

2. **Generates Work Directive**
   - Creates unique directive ID
   - Breaks task into logical steps
   - Defines dependencies between steps
   - Documents constraints and context

3. **Saves State**
   - Stores directive in `state/directive.json`
   - Initializes progress tracking
   - Creates session history entry

4. **Presents Plan**
   - Shows step-by-step breakdown
   - Requests user confirmation
   - Allows modifications before execution

## Directive Structure

Each directive contains:

- **Steps**: Ordered list of actions to perform
- **Dependencies**: Which steps depend on others
- **Context**: Working directory, key files, environment
- **Constraints**: Safety and scope limitations
- **Resume Context**: State for session recovery

## Example

**Input:**
```
/work plan "Build a REST API with CRUD operations for users, including validation and tests"
```

**Generated Directive:**
```
# Work Directive: REST API for Users

## Steps:
1. Analyze existing project structure
2. Design API endpoints and data models
3. Implement User model with validation
4. Create CRUD endpoints (Create)
5. Create CRUD endpoints (Read)
6. Create CRUD endpoints (Update)
7. Create CRUD endpoints (Delete)
8. Write unit tests
9. Write integration tests
10. Update API documentation

## Constraints:
- Follow existing code style
- Use project's validation library
- All endpoints must have tests

Ready to execute? [Y/n]
```

## Agent Behavior

When this command is invoked, the Directive Planner Agent:

1. Reads the query from arguments
2. Explores codebase if needed for context
3. Creates structured directive
4. Saves to `state/directive.json`
5. Presents plan for approval
6. Waits for user confirmation

## State File

Created directive is saved to:
```
state/directive.json
```

## See Also

- `/work execute` - Execute the current directive
- `/work status` - View directive progress
- `/work resume` - Resume interrupted work
- `/work reset` - Clear current directive
