---
description: Clear the current work directive and reset state
usage: /work reset
examples:
  - /work reset
  - /work reset --archive
  - /work reset --force
---

# Reset Work Directive

Clears the current work directive and resets the state. Optionally archives the directive before clearing.

## Usage

```bash
/work reset [OPTIONS]
```

## Options

- `--archive` - Archive the directive before clearing (saved to `state/archive/`)
- `--force` - Skip confirmation prompt
- `--keep-context` - Clear directive but keep context for new planning

## What It Does

1. **Confirms Action**
   - Shows current directive summary
   - Warns about data loss
   - Requests confirmation

2. **Archives (if requested)**
   - Copies directive to `state/archive/`
   - Timestamps the archive file
   - Preserves full history

3. **Clears State**
   - Removes `state/directive.json`
   - Clears progress tracking
   - Resets session state

4. **Confirms Reset**
   - Shows confirmation message
   - Ready for new directive

## Confirmation Prompt

```
$ /work reset

## Reset Work Directive?

**Current Directive:** REST API for Users
**Progress:** 4/10 steps (40%)

This will clear:
- All step progress
- Session history
- Resume context

Are you sure? [y/N]
```

## With Archive

```
$ /work reset --archive

## Reset Work Directive?

**Current Directive:** REST API for Users
**Progress:** 4/10 steps (40%)

Directive will be archived to:
state/archive/wd-20250119-a7f3.json

Proceed? [y/N]

...

Directive archived and reset complete.
Archive location: state/archive/wd-20250119-a7f3.json
```

## Force Reset

```
$ /work reset --force

Work directive reset.
Ready for new directive.
```

## Archive Structure

Archived directives are saved with full state:

```
state/archive/
  wd-20250119-a7f3.json
  wd-20250115-b2e1.json
  ...
```

Each archive contains:
- Complete directive with all steps
- Full session history
- Final progress state
- Artifacts list

## Use Cases

### Starting Fresh
Clear incomplete work to start new task:
```
/work reset
/work plan "New task"
```

### Saving Progress
Archive before clearing:
```
/work reset --archive
```

### Quick Restart
Force reset without prompts:
```
/work reset --force
```

## Recovery

If you reset by mistake:
1. Check `state/archive/` for recent archives
2. Copy archive back to `state/directive.json`
3. Use `/work resume` to continue

## See Also

- `/work plan` - Create new directive
- `/work status` - View current state
- `/work resume` - Resume work
