---
description: Display the current status of the active work directive
usage: /work status
examples:
  - /work status
  - /work status --verbose
  - /work status --json
---

# Work Directive Status

Displays the current progress and status of the active work directive without modifying it.

## Usage

```bash
/work status [OPTIONS]
```

## Options

- `--verbose` - Show detailed step information
- `--json` - Output as JSON for programmatic use
- `--history` - Include full session history

## What It Shows

### Basic Status
- Directive title and description
- Overall progress (X/Y steps)
- Current step status
- Time elapsed

### Step Breakdown
- List of all steps
- Status of each step
- Completion timestamps
- Artifacts created

### Session History
- Previous session summaries
- Steps completed per session
- Total time invested

## Example Output

```
$ /work status

## Work Directive Status

**ID:** wd-20250119-a7f3
**Title:** REST API for Users
**Status:** in_progress
**Progress:** 4/10 steps (40%)

### Steps:
  [x] 1. Analyze existing project structure
  [x] 2. Design API endpoints and data models
  [x] 3. Implement User model with validation
  [>] 4. Create CRUD endpoints (Create)     <- Current
  [ ] 5. Create CRUD endpoints (Read)
  [ ] 6. Create CRUD endpoints (Update)
  [ ] 7. Create CRUD endpoints (Delete)
  [ ] 8. Write unit tests
  [ ] 9. Write integration tests
  [ ] 10. Update API documentation

### Current Step:
Title: Create CRUD endpoints (Create)
Status: in_progress
Started: 10 minutes ago

### Session History:
- Session 1: Steps 1-2 (45 min)
- Session 2: Steps 3-4 (ongoing)

### Artifacts Created:
- src/models/User.ts
- src/validators/userValidator.ts
- docs/api-design.md
```

## Verbose Output

With `--verbose`:

```
$ /work status --verbose

## Work Directive Status (Verbose)

**ID:** wd-20250119-a7f3
...

### Step Details:

#### Step 1: Analyze existing project structure
- Status: completed
- Started: 2025-01-19 10:00:00
- Completed: 2025-01-19 10:15:00
- Duration: 15 minutes
- Artifacts: None
- Summary: Found Express.js backend with MongoDB.
           Existing patterns: MVC, service layer.

#### Step 2: Design API endpoints and data models
- Status: completed
- Started: 2025-01-19 10:15:00
- Completed: 2025-01-19 10:35:00
- Duration: 20 minutes
- Artifacts:
  - docs/api-design.md
  - specs/openapi-draft.yaml
- Summary: Designed RESTful endpoints following
           existing patterns. User model includes
           email, password, profile fields.

...
```

## JSON Output

With `--json`:

```json
{
  "id": "wd-20250119-a7f3",
  "title": "REST API for Users",
  "status": "in_progress",
  "progress": {
    "current": 4,
    "total": 10,
    "percentage": 40
  },
  "current_step": {
    "id": 4,
    "title": "Create CRUD endpoints (Create)",
    "status": "in_progress"
  },
  "steps": [...],
  "session_history": [...]
}
```

## No Active Directive

If no directive exists:

```
$ /work status

No active work directive found.

Use `/work plan [query]` to create one.
```

## See Also

- `/work plan` - Create new directive
- `/work execute` - Start execution
- `/work resume` - Resume work
- `/work reset` - Clear directive
