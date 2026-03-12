# Quick Reference Card

## Windsurf Workflows (Slash Commands)

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/start-exploration` | Begin debugging | Found a bug, need to investigate |
| `/implement-clean-fix` | Clean rewrite | Found root cause, ready to fix |
| `/new-feature` | TDD feature dev | Building new functionality |
| `/run-uat` | Execute sprint UAT | End of sprint, verify deliverables |
| `/quality-check` | Pre-commit checks | Before committing or pushing |

## The Two-Phase Protocol

### Phase 1: EXPLORE 🔍
```bash
git checkout -b explore/issue-name
# Debug freely, add logs, try approaches
# Document findings in .EXPLORING
# DO NOT COMMIT
```

### Phase 2: IMPLEMENT ✨
```bash
git checkout main
git branch -D explore/issue-name
git checkout -b fix/issue-name
# Write test, implement cleanly, commit
```

## Branch Naming

| Type | Prefix | Example | Purpose |
|------|--------|---------|---------|
| Exploration | `explore/` | `explore/auth-bug` | Debugging only (never merge) |
| Bug Fix | `fix/` | `fix/auth-validation` | Clean bug fixes |
| Feature | `feat/` | `feat/email-verify` | New features |
| Refactor | `refactor/` | `refactor/auth-service` | Code improvements |
| Tests | `test/` | `test/add-auth-tests` | Test additions |
| Docs | `docs/` | `docs/update-readme` | Documentation |

## Commit Message Format

```
<type>: <short description> (max 72 chars)

<detailed explanation>

Root cause: <what caused the issue>
Solution: <how this fixes it>

Fixes: #<issue-number>
```

**Types:** `fix`, `feat`, `refactor`, `test`, `docs`, `perf`, `chore`

## Quality Check Commands

```bash
# Before commit
npm run pre-commit        # Lint + unit tests

# Before push
npm run pre-push          # All tests + coverage + build

# Individual checks
npm run lint              # ESLint
npm run lint:fix          # Auto-fix linting
npm run format            # Format code
npm run test:unit         # Unit tests only
npm run test:integration  # Integration tests
npm run test:e2e          # E2E tests
npm test                  # All tests
npm run test:coverage     # With coverage report
```

## Git Hooks (Auto-Installed)

| Hook | Blocks | Checks |
|------|--------|--------|
| `pre-commit` | Debug code, linting errors | console.log, debugger, tests |
| `commit-msg` | Bad format | Type prefix, length |
| `pre-push` | Test failures, low coverage | All tests, coverage ≥80% |

**Install hooks:**
```bash
npm run hooks:install
```

**Bypass (emergency only):**
```bash
git commit --no-verify
git push --no-verify
```

## UAT Commands

```bash
# Navigate to sprint UAT
cd tests/uat/sprint-[N]

# Run all tests
./run-all.sh

# View results
cat artifacts/latest/test-results.json
cat artifacts/latest/test-log.txt
open artifacts/latest/coverage-report/index.html
```

## Cascade Chat Quick Commands

| Say This | Cascade Does |
|----------|--------------|
| "What branch am I on?" | Shows current branch |
| "Check for debug code" | Searches for console.log, debugger |
| "Run unit tests" | Executes npm run test:unit |
| "What's my coverage?" | Shows test coverage % |
| "Help write commit message" | Guides through template |
| "Run quality checks" | Executes pre-push checks |
| "Show exploration findings" | Displays .EXPLORING file |

## Cascade Warnings

Cascade will warn you if:

- ❌ Trying to commit on `explore/*` branch
- ❌ Debug code found in `src/`
- ❌ Tests failing
- ❌ Coverage below 80%
- ❌ Improper commit message format
- ❌ Commented-out code blocks

## TDD Cycle

1. **🔴 RED:** Write failing test
2. **🟢 GREEN:** Write minimal code to pass
3. **🔵 REFACTOR:** Improve code quality
4. **REPEAT** for next test case

## Sprint Structure

| Sprint | Focus | UAT Tests | Duration |
|--------|-------|-----------|----------|
| 1 | Foundation & Database | 28 | 2 weeks |
| 2 | Sprint Creation & Admin | 26 | 2 weeks |
| 3 | Participant Flow & Topics | 50 | 2 weeks |
| 4 | Support System & Notes | 55 | 2 weeks |
| 5 | Moderation & LLM | 63 | 2 weeks |
| 6 | Production Hardening | 46 | 2 weeks |

## File Locations

```
.windsurf/workflows/     # Workflow definitions
.git-hooks/              # Git hook scripts
.cascade/                # Cascade instructions
docs/                    # Documentation
tests/uat/sprint-N/      # UAT tests per sprint
```

## Anti-Patterns (DON'T DO)

❌ Commit on `explore/*` branch  
❌ Commit debug code (console.log, debugger)  
❌ Commit commented-out code  
❌ Mix unrelated changes in one commit  
❌ Skip writing tests  
❌ Use vague commit messages  

## Best Practices (DO THIS)

✅ Explore freely on `explore/*` branches  
✅ Rewrite cleanly on `fix/*` or `feat/*` branches  
✅ Write tests first (TDD)  
✅ Document root cause in commits  
✅ Keep commits atomic and focused  
✅ Run quality checks before pushing  
✅ Use proper commit message format  

## Success Metrics

Each sprint UAT must achieve:
- **Test pass rate:** ≥ 95%
- **Code coverage:** ≥ 80%
- **Performance:** All endpoints < 1s
- **Security:** No critical vulnerabilities

## Documentation

| Document | Purpose |
|----------|---------|
| `README.md` | Project overview |
| `docs/QUICK_START.md` | Getting started guide |
| `docs/ROADMAP.md` | 6-sprint development plan |
| `docs/TESTING_STRATEGY.md` | Testing approach |
| `docs/DEVELOPMENT_DISCIPLINE.md` | Complete protocol |
| `docs/WINDSURF_HOWTO.md` | Windsurf-specific guide |
| `docs/QUICK_REFERENCE.md` | This document |

## Emergency Procedures

### Accidentally Committed on Exploration Branch

```bash
# Undo commit (keep changes)
git reset HEAD~1

# Switch to main
git checkout main

# Delete exploration branch
git branch -D explore/[name]

# Start clean implementation
git checkout -b fix/[name]
```

### Committed Debug Code

```bash
# Undo commit
git reset HEAD~1

# Remove debug code
grep -r "console\.log" src/ --include="*.js" | cut -d: -f1 | xargs sed -i '/console\.log/d'

# Commit again (clean)
git add .
git commit
```

### Tests Failing After Implementation

```bash
# Review failures
npm test

# If fix broke existing functionality:
# Option 1: Fix the implementation
# Option 2: Revert and re-explore
git reset --hard HEAD~1
git checkout -b explore/[issue]-v2
```

## Getting Help

### In Cascade Chat
```
How do I [task]?
Show me [document]
Help with [problem]
```

### In Documentation
- Read `docs/WINDSURF_HOWTO.md` for detailed Windsurf guide
- Read `docs/DEVELOPMENT_DISCIPLINE.md` for complete protocol
- Check workflow files in `.windsurf/workflows/`

## Keyboard Shortcuts (Optional)

Set in Windsurf settings:

- `Ctrl+Shift+E` → Start exploration
- `Ctrl+Shift+I` → Implement clean fix
- `Ctrl+Shift+Q` → Quality check
- `Ctrl+Shift+T` → Run tests
- `Ctrl+Shift+U` → Run UAT

## Remember

> **Never commit exploratory code. Always rewrite from a clear perspective.**

This is the golden rule that prevents patchwork code.
