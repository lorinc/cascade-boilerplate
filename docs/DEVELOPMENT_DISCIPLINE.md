# Development Discipline — Preventing Patchwork Code

## The Problem

When debugging hard-to-find errors, AI (and humans) often take multiple exploratory stabs before finding the root cause. This leads to:
- **Patchwork code** - Multiple attempted fixes layered on top of each other
- **Unclear intent** - Hard to understand what the code is trying to do
- **Technical debt** - Band-aids instead of proper solutions
- **Fragile codebase** - Changes break unexpectedly

## The Solution: Exploratory vs. Implementation Phases

**Core Principle:** Separate exploration from implementation. Never commit exploratory code.

---

## Workflow: The Two-Phase Approach

### Phase 1: EXPLORE (No Git Add)

**Goal:** Find the root cause and understand the best solution path

**Rules:**
- ❌ **DO NOT** run `git add` during exploration
- ❌ **DO NOT** commit exploratory code
- ✅ **DO** try multiple approaches
- ✅ **DO** add logging and debugging code
- ✅ **DO** make notes about what works and what doesn't
- ✅ **DO** identify the root cause before moving to Phase 2

**Workflow:**
```bash
# Start exploration
git checkout -b explore/fix-participant-auth

# Try different approaches, add debug logs, experiment
# Take notes in a scratch file or comments

# When you find the root cause:
# 1. Document the root cause
# 2. Document the solution approach
# 3. DO NOT COMMIT YET
```

**Exploration Checklist:**
- [ ] Root cause identified and documented
- [ ] Solution approach validated (tests pass)
- [ ] Alternative approaches considered
- [ ] Side effects understood
- [ ] Ready to implement cleanly

### Phase 2: IMPLEMENT (Clean Rewrite)

**Goal:** Implement the fix from a clear perspective with full understanding

**Rules:**
- ✅ **DO** discard all exploratory code
- ✅ **DO** rewrite from scratch with clarity
- ✅ **DO** write the minimal fix that addresses the root cause
- ✅ **DO** add tests that prevent regression
- ✅ **DO** document why the fix works
- ❌ **DO NOT** carry over debug code or attempted fixes

**Workflow:**
```bash
# Discard exploratory code
git reset --hard origin/main

# Create clean implementation branch
git checkout -b fix/participant-auth-token-validation

# Implement the fix cleanly:
# 1. Write failing test that reproduces the bug
# 2. Implement minimal fix
# 3. Verify test passes
# 4. Remove any debug code
# 5. Add documentation

# Commit with clear message
git add <only the files needed for the fix>
git commit -m "Fix participant auth token validation

Root cause: Token expiration was checked before signature validation,
allowing expired tokens to pass if signature was invalid.

Solution: Reorder validation to check signature first, then expiration.

Fixes: #123"

# Push for review
git push origin fix/participant-auth-token-validation
```

---

## Git Workflow Strategy

### Branch Naming Convention

```
explore/<description>     # Exploratory branches (never merged)
fix/<description>         # Bug fixes (clean implementation)
feature/<description>     # New features
refactor/<description>    # Code improvements
test/<description>        # Test additions
docs/<description>        # Documentation
```

### Branch Lifecycle

**Exploratory Branches:**
```bash
# Create
git checkout -b explore/debug-duplicate-detection

# Explore freely (no commits)
# ... experiment, debug, try different approaches ...

# When done exploring:
# Option 1: Delete and start clean implementation
git checkout main
git branch -D explore/debug-duplicate-detection

# Option 2: Keep for reference (but never merge)
git checkout main
# Leave explore branch unmerged
```

**Implementation Branches:**
```bash
# Create from clean main
git checkout main
git pull origin main
git checkout -b fix/duplicate-detection-embedding-cache

# Implement cleanly
# ... write tests, implement fix, verify ...

# Commit atomically
git add src/backend/services/duplicate-detector.js
git add tests/unit/backend/services/duplicate-detector.test.js
git commit -m "Fix duplicate detection embedding cache invalidation"

# Push for review
git push origin fix/duplicate-detection-embedding-cache
```

---

## Commit Discipline

### Atomic Commits

Each commit should:
- ✅ Address **one** logical change
- ✅ Include **only** files related to that change
- ✅ Pass all tests
- ✅ Be deployable (if on main)
- ✅ Have a clear, descriptive message

### Commit Message Format

```
<type>: <short summary> (max 72 chars)

<detailed explanation of what and why>

<optional: root cause analysis>
<optional: alternative approaches considered>

Fixes: #<issue-number>
```

**Types:**
- `fix:` - Bug fix
- `feat:` - New feature
- `refactor:` - Code restructuring (no behavior change)
- `test:` - Add or update tests
- `docs:` - Documentation only
- `perf:` - Performance improvement
- `chore:` - Build, dependencies, tooling

**Example:**
```
fix: Prevent duplicate participant sessions from same fingerprint

Root cause: Fingerprint hash collision check was case-sensitive,
allowing same fingerprint with different casing to create multiple
sessions.

Solution: Normalize fingerprint hash to lowercase before comparison
and storage. Add unique constraint on lowercase(fingerprint_hash).

Alternative considered: Client-side normalization - rejected because
it's not enforceable and creates security risk.

Fixes: #156
```

### What NOT to Commit

❌ Debug code:
```javascript
// BAD - Don't commit this
console.log('DEBUG: participant =', participant);
console.log('DEBUG: entering validation');
debugger;
```

❌ Commented-out code:
```javascript
// BAD - Don't commit this
// const oldApproach = () => {
//   // ... 50 lines of old code ...
// };
```

❌ Multiple attempted fixes:
```javascript
// BAD - Don't commit this
function validateToken(token) {
  // First attempt - didn't work
  // if (token.exp < Date.now()) return false;
  
  // Second attempt - also didn't work
  // if (!verifySignature(token)) return false;
  
  // Third attempt - this one works
  if (!verifySignature(token)) return false;
  if (token.exp < Date.now()) return false;
  return true;
}
```

✅ Clean implementation:
```javascript
// GOOD - Commit this
function validateToken(token) {
  // Verify signature before checking expiration to prevent
  // timing attacks where invalid signatures might leak info
  if (!verifySignature(token)) {
    return false;
  }
  
  if (token.exp < Date.now()) {
    return false;
  }
  
  return true;
}
```

---

## Code Review Checklist

Before requesting review, verify:

### Clarity
- [ ] Code is self-explanatory (minimal comments needed)
- [ ] Variable and function names are descriptive
- [ ] No "clever" or obscure solutions
- [ ] Logic flow is straightforward

### Completeness
- [ ] Tests added for new functionality
- [ ] Tests added for bug fixes (regression prevention)
- [ ] Documentation updated
- [ ] No debug code or console.logs
- [ ] No commented-out code

### Minimalism
- [ ] Only necessary changes included
- [ ] No unrelated refactoring
- [ ] No "while I'm here" changes
- [ ] Smallest possible fix for the issue

### Quality
- [ ] All tests pass locally
- [ ] No linting errors
- [ ] Code coverage maintained or improved
- [ ] Performance impact considered

### Git Hygiene
- [ ] Atomic commits (one logical change per commit)
- [ ] Clear commit messages
- [ ] No merge commits (rebase instead)
- [ ] Branch up to date with main

---

## Debugging Workflow

### Step 1: Reproduce

```bash
# Create exploration branch
git checkout -b explore/bug-support-count-mismatch

# Write failing test that reproduces the bug
# tests/integration/support-allocation.test.js
it('updates topic support count when participant adds support', async () => {
  const topic = await createTopic();
  const participant = await createParticipant();
  
  await addSupport(participant.id, topic.id, 1);
  
  const updatedTopic = await getTopic(topic.id);
  expect(updatedTopic.support_count).toBe(1); // FAILS - shows 0
});
```

### Step 2: Explore

```javascript
// Add debug logging (NOT for commit)
async function addSupport(participantId, topicId, count) {
  console.log('DEBUG: addSupport called', { participantId, topicId, count });
  
  const allocation = await db.supportAllocations.create({
    participant_id: participantId,
    topic_id: topicId,
    support_count: count
  });
  console.log('DEBUG: allocation created', allocation);
  
  // Try approach 1: Update in same transaction
  // const topic = await db.topics.update(topicId, {
  //   support_count: db.raw('support_count + ?', [count])
  // });
  // console.log('DEBUG: topic updated (approach 1)', topic);
  
  // Try approach 2: Recalculate from allocations
  const total = await db.supportAllocations
    .where({ topic_id: topicId })
    .sum('support_count');
  console.log('DEBUG: calculated total', total);
  
  await db.topics.update(topicId, {
    support_count: total
  });
  
  return allocation;
}
```

### Step 3: Identify Root Cause

```markdown
# Root Cause Analysis

## Problem
Topic support_count not updating when support added.

## Investigation
1. Allocation is created successfully ✓
2. Approach 1 (increment): Fails because support_count column doesn't exist yet (migration issue)
3. Approach 2 (recalculate): Works but inefficient

## Root Cause
Migration 003_add_support_count.sql was not run in test environment.
Column exists in dev but not in test DB.

## Evidence
- `\d topics` in test DB shows no support_count column
- Migration file exists but wasn't executed
- Test DB was created before migration was added

## Solution
1. Ensure test DB runs all migrations before tests
2. Add support_count column with default 0
3. Use calculated field approach (more reliable than increments)
```

### Step 4: Discard and Rewrite

```bash
# Discard all exploratory code
git checkout main
git branch -D explore/bug-support-count-mismatch

# Create clean implementation branch
git checkout -b fix/support-count-calculation

# Implement cleanly
# 1. Fix test DB migration runner
# 2. Add migration for support_count column
# 3. Implement calculated field approach
# 4. Remove all debug code
# 5. Verify tests pass

git add tests/helpers/database.js
git add src/backend/migrations/003_add_support_count.sql
git add src/backend/services/support-service.js
git add tests/integration/support-allocation.test.js

git commit -m "Fix support count calculation in test environment

Root cause: Test database was not running all migrations, causing
support_count column to be missing in test environment.

Solution:
1. Updated test DB helper to run all migrations before tests
2. Modified support service to use calculated field approach
   (sum of allocations) instead of incremental updates
3. Added migration for support_count with default value

Calculated approach is more reliable and self-healing than
incremental updates, which can drift due to race conditions.

Fixes: #234"
```

---

## Quality Gates

### Pre-Commit (Local)

```bash
# Run before every commit
npm run pre-commit
```

**Pre-commit script checks:**
- [ ] All tests pass
- [ ] No linting errors
- [ ] No debug code (console.log, debugger)
- [ ] No commented-out code blocks
- [ ] Code formatted consistently

### Pre-Push (Local)

```bash
# Run before pushing
npm run pre-push
```

**Pre-push script checks:**
- [ ] All tests pass (including integration)
- [ ] Code coverage ≥ 80%
- [ ] No TypeScript errors
- [ ] No security vulnerabilities (npm audit)
- [ ] Build succeeds

### Pre-Merge (CI/CD)

**Automated checks:**
- [ ] All tests pass in clean environment
- [ ] Code coverage ≥ 80%
- [ ] No linting errors
- [ ] No security vulnerabilities
- [ ] Build succeeds
- [ ] No merge conflicts
- [ ] Branch up to date with main

**Manual review required:**
- [ ] Code review approved by 1+ reviewer
- [ ] Changes align with architecture
- [ ] Tests are meaningful (not just for coverage)
- [ ] Documentation updated

---

## Anti-Patterns to Avoid

### ❌ The "Try Everything" Commit

```bash
# BAD
git add .
git commit -m "fix stuff"
```

**Why it's bad:**
- Includes exploratory code
- Unclear what actually fixed the issue
- Hard to review
- Hard to revert if needed

### ❌ The "Debug Artifact" Commit

```javascript
// BAD - Committed debug code
function processParticipant(participant) {
  console.log('=== PROCESSING PARTICIPANT ===');
  console.log('participant:', JSON.stringify(participant, null, 2));
  console.log('timestamp:', new Date().toISOString());
  
  // ... actual logic ...
  
  console.log('=== DONE ===');
}
```

### ❌ The "Commented History" Commit

```javascript
// BAD - Committed commented-out attempts
function calculateSupports(participant) {
  // Old way - didn't work
  // return participant.allocations.length;
  
  // Second try - also wrong
  // return participant.allocations.reduce((sum, a) => sum + 1, 0);
  
  // Third try - still wrong
  // return participant.allocations.map(a => a.count).reduce((a, b) => a + b);
  
  // Final version
  return participant.allocations.reduce((sum, a) => sum + a.support_count, 0);
}
```

### ❌ The "While I'm Here" Commit

```bash
# BAD - Mixing unrelated changes
git add src/backend/services/auth.js          # Bug fix
git add src/backend/services/participant.js   # Unrelated refactor
git add src/frontend/components/Button.jsx    # Unrelated style change
git commit -m "fix auth bug and other stuff"
```

---

## Best Practices

### ✅ The Clean Fix

```bash
# Create exploration branch
git checkout -b explore/auth-token-issue

# Explore, debug, find root cause
# ... (no commits) ...

# Document findings
cat > FINDINGS.md << EOF
Root Cause: Token validation order incorrect
Solution: Check signature before expiration
EOF

# Discard exploration
git checkout main
git branch -D explore/auth-token-issue

# Implement cleanly
git checkout -b fix/auth-token-validation

# Write test
# tests/unit/backend/services/auth.test.js
it('rejects tokens with invalid signature even if not expired', () => {
  const token = createToken({ exp: futureDate });
  const tamperedToken = tamperWithSignature(token);
  expect(validateToken(tamperedToken)).toBe(false);
});

# Implement fix
# src/backend/services/auth.js
function validateToken(token) {
  if (!verifySignature(token)) return false;
  if (token.exp < Date.now()) return false;
  return true;
}

# Commit atomically
git add src/backend/services/auth.js
git add tests/unit/backend/services/auth.test.js
git commit -m "Fix auth token validation order

Root cause: Expiration was checked before signature, allowing
invalid tokens to pass if they were expired (short-circuit logic).

Solution: Check signature first, then expiration. This prevents
timing attacks and ensures all invalid tokens are rejected.

Fixes: #145"
```

### ✅ The Documented Decision

```javascript
// GOOD - Clear intent and reasoning
function validateToken(token) {
  // Check signature before expiration to prevent timing attacks.
  // If we checked expiration first, an attacker could distinguish
  // between expired-but-valid and invalid signatures based on
  // response timing.
  if (!verifySignature(token)) {
    return false;
  }
  
  if (token.exp < Date.now()) {
    return false;
  }
  
  return true;
}
```

### ✅ The Minimal Change

```bash
# GOOD - Only files needed for the fix
git add src/backend/services/auth.js
git add tests/unit/backend/services/auth.test.js
git commit -m "Fix auth token validation order"

# Not included:
# - Debug logging
# - Commented-out attempts
# - Unrelated refactoring
# - "While I'm here" changes
```

---

## Tools and Automation

### Pre-Commit Hook

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash

echo "Running pre-commit checks..."

# Check for debug code
if git diff --cached | grep -E "console\.(log|debug|info|warn)" > /dev/null; then
  echo "❌ Error: Found console.log statements"
  echo "Remove debug code before committing"
  exit 1
fi

if git diff --cached | grep -E "debugger" > /dev/null; then
  echo "❌ Error: Found debugger statements"
  exit 1
fi

# Check for commented-out code blocks
if git diff --cached | grep -E "^[+].*\/\/ .*{$" > /dev/null; then
  echo "⚠️  Warning: Found commented-out code blocks"
  echo "Consider removing instead of commenting"
fi

# Run tests
echo "Running tests..."
npm run test:unit
if [ $? -ne 0 ]; then
  echo "❌ Error: Tests failed"
  exit 1
fi

# Run linter
echo "Running linter..."
npm run lint
if [ $? -ne 0 ]; then
  echo "❌ Error: Linting failed"
  exit 1
fi

echo "✅ Pre-commit checks passed"
exit 0
```

### Commit Message Template

Create `.gitmessage`:

```
# <type>: <short summary> (max 72 chars)
#
# <detailed explanation of what and why>
#
# Root cause: <what caused the issue>
# Solution: <how this fixes it>
# Alternatives considered: <other approaches and why rejected>
#
# Fixes: #<issue-number>

# Types: fix, feat, refactor, test, docs, perf, chore
# 
# Example:
# fix: Prevent duplicate participant sessions from same fingerprint
#
# Root cause: Fingerprint hash collision check was case-sensitive
# Solution: Normalize to lowercase before comparison
# Alternatives: Client-side normalization (rejected - not enforceable)
#
# Fixes: #156
```

Configure git to use it:
```bash
git config commit.template .gitmessage
```

### Branch Protection Rules

Configure in GitHub/GitLab:

```yaml
main:
  require_pull_request: true
  required_approvals: 1
  require_status_checks:
    - tests
    - lint
    - coverage
  require_up_to_date_branch: true
  no_force_push: true
  no_delete: true
```

---

## Sprint-Specific Rules

### During Development
- Use exploration branches freely
- Never merge exploration branches
- Always rewrite from clean perspective
- Commit only clean implementation

### During UAT
- No exploratory branches during UAT
- All fixes must be clean implementations
- Document root cause in commit message
- Add regression tests

### Before Sprint End
- [ ] All exploration branches deleted
- [ ] All commits are clean implementations
- [ ] No debug code in codebase
- [ ] No commented-out code
- [ ] All tests pass
- [ ] Code coverage ≥ 80%

---

## Enforcement

### Automated (CI/CD)
- Pre-commit hooks block debug code
- CI fails if tests don't pass
- CI fails if coverage drops
- Branch protection prevents direct pushes to main

### Manual (Code Review)
- Reviewer checks for exploratory artifacts
- Reviewer verifies commit atomicity
- Reviewer validates root cause analysis
- Reviewer ensures minimal changes

### Cultural
- Team discusses "patchwork" anti-patterns
- Celebrate clean fixes in retrospectives
- Share examples of good exploration → implementation
- Mentor on two-phase approach

---

## Summary

### The Golden Rule
**Never commit exploratory code. Always rewrite from a clear perspective.**

### The Workflow
1. **Explore** freely on `explore/*` branch (no commits)
2. **Document** root cause and solution
3. **Discard** exploratory code
4. **Implement** cleanly on `fix/*` or `feature/*` branch
5. **Test** thoroughly
6. **Commit** atomically with clear message
7. **Review** before merge

### The Benefits
- ✅ Clean, understandable codebase
- ✅ Clear git history
- ✅ Easy to review changes
- ✅ Easy to revert if needed
- ✅ Minimal technical debt
- ✅ Confidence in code quality

### The Discipline
- 🚫 No `git add` during exploration
- 🚫 No debug code in commits
- 🚫 No commented-out code
- 🚫 No "while I'm here" changes
- ✅ Atomic commits
- ✅ Clear commit messages
- ✅ Root cause analysis
- ✅ Clean rewrites
