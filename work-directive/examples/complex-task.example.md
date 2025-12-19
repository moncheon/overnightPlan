# Example: Complex Multi-Session Task

## User Query
"Refactor the entire database layer to use connection pooling, add proper error handling, implement query caching, and update all services to use the new patterns"

## Generated Work Directive

This is a complex task that will likely span multiple sessions. The Work Directive system ensures no progress is lost.

### Phase 1: Research & Planning (Session 1)

```
Step 1: Audit current database usage
- Map all database connections
- Identify connection patterns
- Document current error handling

Step 2: Design connection pooling strategy
- Choose pooling library
- Define pool configuration
- Plan migration approach

Step 3: Design caching architecture
- Identify cacheable queries
- Choose caching strategy
- Define cache invalidation rules
```

### Phase 2: Core Implementation (Sessions 2-3)

```
Step 4: Implement connection pool
- Create pool manager
- Configure pool settings
- Add health checks

Step 5: Implement error handling layer
- Create error types
- Add retry logic
- Implement circuit breaker

Step 6: Implement query cache
- Set up caching infrastructure
- Create cache decorators
- Add cache invalidation
```

### Phase 3: Migration (Sessions 4-5)

```
Step 7: Update UserService
Step 8: Update ProductService
Step 9: Update OrderService
Step 10: Update remaining services
```

### Phase 4: Validation (Session 6)

```
Step 11: Write integration tests
Step 12: Performance benchmarking
Step 13: Update documentation
```

## Session Transitions Example

### End of Session 2
```
## Session Boundary Reached

**Directive:** Database Layer Refactoring
**Progress:** Step 5 of 13 (38%)

### State Saved
- Connection pool: Complete
- Error handling: In progress (retry logic done, circuit breaker pending)

### Resume Context
Last: Implemented exponential backoff retry logic in src/db/retry.ts
Next: Create circuit breaker wrapper in src/db/circuitBreaker.ts

Files modified this session:
- src/db/pool.ts (new)
- src/db/retry.ts (new)
- src/db/errors.ts (new)
- package.json (added dependencies)

### To Continue
Run `/work resume` or start new session - work will continue automatically.
```

### Start of Session 3
```
## Resuming Work Directive

**Title:** Database Layer Refactoring
**Progress:** 5/13 steps (38%)

### Session History:
- Session 1 (2h): Steps 1-3 (Research & Design)
- Session 2 (1.5h): Steps 4-5 partial

### Last Session Summary:
Implemented connection pooling with pg-pool. Created error types.
Retry logic complete. Circuit breaker pending.

### Current Step: 5 (Error Handling Layer)
Resuming: Create circuit breaker wrapper

### Key Files:
- src/db/pool.ts - Connection pool manager
- src/db/errors.ts - Error type definitions
- src/db/retry.ts - Retry logic (COMPLETE)
- src/db/circuitBreaker.ts - TO BE CREATED

---

Continuing with circuit breaker implementation...
```

## Benefits Demonstrated

1. **No Lost Progress**: Every step saved before session ends
2. **Clear Context**: Resume knows exactly where to continue
3. **File Tracking**: All artifacts documented
4. **Session History**: Full audit trail of work done
5. **Automatic Resume**: No manual state reconstruction needed

## Agent-Friendly Output

The directive system outputs structured markers for automation:

```
[STEP_COMPLETE:5]
[PROGRESS:6/13]
[SESSION_BOUNDARY]
[ARTIFACTS:src/db/retry.ts,src/db/circuitBreaker.ts]
[RESUME_POINT:step=6,action="Implement query cache"]
```

These can be parsed by external tools for monitoring and orchestration.
