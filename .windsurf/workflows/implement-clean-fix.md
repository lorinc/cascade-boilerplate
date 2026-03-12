---
description: Implement clean fix after exploration phase
---

# Implement Clean Fix

This workflow helps you implement a clean fix after you've explored and found the root cause.

**Prerequisites:** You must have completed exploration and documented the root cause.

## Steps

1. **Review exploration findings**
```bash
cat .EXPLORING
```

Make sure you have documented:
- Root cause
- Solution approach
- What you learned

2. **Return to main branch**
```bash
git checkout main
```

3. **Delete exploration branch**
```bash
git branch -D explore/[issue-description]
```
Replace with your actual exploration branch name.

4. **Create clean implementation branch**
```bash
git checkout -b fix/[issue-description]
```
Or use `feat/` for new features, `refactor/` for refactoring.

5. **Remove exploration marker**
```bash
rm -f .EXPLORING
```

## Implementation Checklist

Follow this order for clean implementation:

### Step 1: Write Failing Test
- [ ] Create test file in `tests/unit/` or `tests/integration/`
- [ ] Write test that reproduces the bug
- [ ] Verify test fails
- [ ] Commit test only:
```bash
git add tests/[path-to-test]
git commit -m "test: add failing test for [issue]"
```

### Step 2: Implement Minimal Fix
- [ ] Implement the fix in `src/`
- [ ] Use the simplest approach that solves the root cause
- [ ] No debug code (console.log, debugger)
- [ ] No commented-out code
- [ ] Clear variable and function names

### Step 3: Verify Fix
- [ ] Run the test: `npm test [test-file]`
- [ ] Verify test passes
- [ ] Run all tests: `npm test`
- [ ] Run linter: `npm run lint`

### Step 4: Commit Clean Implementation
```bash
git add src/[files-changed]
git commit
```

Use the commit message template:
```
fix: [short description]

Root cause: [what caused the issue]

Solution: [how this fixes it]

Alternatives considered: [other approaches and why rejected]

Fixes: #[issue-number]
```

### Step 5: Quality Check
```bash
npm run pre-push
```

This runs:
- All tests
- Coverage check
- Build verification
- Security audit

### Step 6: Push and Create PR
```bash
git push origin fix/[issue-description]
```

Then open a PR using the template in `.github/pull_request_template.md`

## Turbo Mode

Safe commands can be auto-run with turbo annotation:
```bash
// turbo
npm test
```
