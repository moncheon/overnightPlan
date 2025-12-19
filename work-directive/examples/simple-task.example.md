# Example: Simple Task Work Directive

## User Query
"Add input validation to the user registration form"

## Generated Work Directive

```
/work plan "Add input validation to the user registration form"
```

### Steps Generated:

1. **Analyze existing form structure**
   - Find registration form component
   - Identify current validation (if any)
   - Review form submission handler

2. **Define validation rules**
   - Email format validation
   - Password strength requirements
   - Required field checks
   - Username constraints

3. **Implement client-side validation**
   - Add validation library or create validators
   - Implement real-time feedback
   - Style error messages

4. **Implement server-side validation**
   - Add validation middleware
   - Return proper error responses
   - Ensure consistency with client rules

5. **Test validation**
   - Test edge cases
   - Verify error messages display correctly
   - Check form submission blocking

### Context Preserved:
- Form location: `src/components/RegisterForm.tsx`
- API endpoint: `POST /api/users/register`
- Validation library: yup (already in project)

### Session Behavior:

**If session ends after step 2:**
```
## Session Boundary

Work directive state saved.
Progress: 2/5 steps complete

Next: Implement client-side validation
Resume context: Validation rules defined in docs/validation-rules.md

Use /work resume in next session.
```

**On resume:**
```
## Resuming Work Directive

Title: Add input validation to user registration form
Progress: 2/5 steps (40%)

Completed:
- [x] Analyze existing form structure
- [x] Define validation rules

Next:
- [ ] Implement client-side validation

Continuing from step 3...
```
