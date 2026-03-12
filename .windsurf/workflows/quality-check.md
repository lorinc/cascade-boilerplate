---
description: Run quality checks before committing or pushing
---

# Quality Check

Run this workflow before committing or pushing to ensure code quality.

## Quick Check (Before Commit)

```bash
// turbo
npm run pre-commit
```

This runs:
- ESLint (linting)
- Unit tests
- Checks for debug code

## Full Check (Before Push)

```bash
npm run pre-push
```

This runs:
- All tests (unit + integration)
- Code coverage check (≥80%)
- Build verification
- Security audit

## Individual Checks

### Linting
```bash
// turbo
npm run lint
```

Fix automatically:
```bash
npm run lint:fix
```

### Formatting
```bash
// turbo
npm run format:check
```

Fix automatically:
```bash
npm run format
```

### Unit Tests
```bash
// turbo
npm run test:unit
```

With coverage:
```bash
npm run test:coverage
```

### Integration Tests
```bash
npm run test:integration
```

### E2E Tests
```bash
npm run test:e2e
```

### All Tests
```bash
npm test
```

## Check for Debug Code

Manual check:
```bash
grep -r "console\.log\|debugger" src/ --include="*.js" --include="*.ts"
```

If found, remove before committing.

## Check for Commented Code

```bash
grep -r "^[[:space:]]*\/\/" src/ --include="*.js" --include="*.ts" | head -20
```

If found, remove instead of commenting.

## Coverage Report

View detailed coverage:
```bash
npm run test:coverage
open coverage/index.html
```

## Build Check

```bash
npm run build
```

## Security Audit

```bash
npm audit
```

Fix vulnerabilities:
```bash
npm audit fix
```

## All Quality Checks

Run everything:
```bash
npm run quality:check
```

Fix what can be auto-fixed:
```bash
npm run quality:fix
```

## Checklist

Before committing:
- [ ] Linting passes
- [ ] Unit tests pass
- [ ] No debug code
- [ ] No commented code

Before pushing:
- [ ] All tests pass
- [ ] Coverage ≥80%
- [ ] Build succeeds
- [ ] No security vulnerabilities
