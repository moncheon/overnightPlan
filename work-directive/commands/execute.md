---
description: Execute the current work directive, tracking progress and handling session boundaries
usage: /work execute
examples:
  - /work execute
  - /work execute --step 3
  - /work execute --from 2
---

# Execute Work Directive

Executes the current work directive, systematically working through each step while tracking progress and handling session boundaries.

## Usage

```bash
/work execute [OPTIONS]
```

## Options

- `--step N` - Execute only step N
- `--from N` - Start execution from step N
- `--dry-run` - Show what would be executed without doing it

## What It Does

1. **Loads Directive**
   - Reads `state/directive.json`
   - Validates directive status
   - Identifies next step to execute

2. **Executes Steps**
   - Marks step as `in_progress`
   - Performs the step's work
   - Records artifacts and outputs
   - Marks step as `completed`

3. **Tracks Progress**
   - Updates progress after each step
   - Saves state to `directive.json`
   - Maintains session history

4. **Handles Session Boundaries**
   - Monitors context usage
   - Saves state before session end
   - Creates resume instructions

## Execution Flow

```
[Load Directive]
       |
       v
[Check Current Step]
       |
       v
[Mark In Progress]
       |
       v
[Execute Step] ---> [Error?] ---> [Log & Continue/Stop]
       |
       v
[Record Artifacts]
       |
       v
[Mark Complete]
       |
       v
[Save State]
       |
       v
[More Steps?] ---> Yes ---> [Next Step]
       |
       No
       v
[Complete Directive]
```

## Progress Tracking

Each step execution updates:
- `status`: pending -> in_progress -> completed
- `started_at`: When step began
- `completed_at`: When step finished
- `artifacts`: Files created/modified
- `output_summary`: Brief summary of results

## Session Boundary Handling

When approaching context limits:

```
## Session Boundary Reached

Progress saved for directive: {title}
Current: Step {n}/{total}

### Resume Context
Last action: {what was being done}
Next action: {what to do next}

Work will continue automatically in next session.
Run `/work resume` to continue manually.
```

## Example Execution

```
$ /work execute

## Executing Work Directive

**Title:** REST API for Users
**Status:** Step 2 of 10

### Step 2: Design API endpoints
Status: in_progress

Analyzing existing models...
Designing endpoint structure...
Creating OpenAPI spec draft...

Step 2 complete. Artifacts:
- docs/api-design.md
- specs/openapi-draft.yaml

### Step 3: Implement User model
Status: in_progress

...
```

## Error Handling

If a step fails:
1. Step marked as `failed`
2. Error details logged
3. User prompted for action:
   - Retry step
   - Skip step
   - Abort directive

## See Also

- `/work plan` - Create a new directive
- `/work status` - View current progress
- `/work resume` - Resume after interruption
- `/work reset` - Clear and start over
