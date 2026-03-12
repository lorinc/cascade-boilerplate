# Windsurf IDE - Development Discipline HOWTO

This guide shows you how to use Windsurf/Cascade workflows to follow the development discipline protocol.

## Overview

Windsurf workflows are available via slash commands. Type `/` in the chat to see available workflows.

## Available Workflows

| Workflow | Command | Purpose |
|----------|---------|---------|
| Start Exploration | `/start-exploration` | Begin debugging (no commits) |
| Implement Clean Fix | `/implement-clean-fix` | Clean rewrite after exploration |
| New Feature | `/new-feature` | TDD feature development |
| Run UAT | `/run-uat` | Execute sprint UAT tests |
| Quality Check | `/quality-check` | Pre-commit/push checks |

## Workflow 1: Debugging a Bug

### Step 1: Start Exploration

**You say:**
```
/start-exploration
```

**Cascade will:**
1. Check you're on main branch
2. Create `explore/[issue]` branch
3. Create `.EXPLORING` file for notes
4. Remind you: DO NOT COMMIT

**You do:**
- Add `console.log()` freely
- Add `debugger` statements
- Try different approaches
- Document findings in `.EXPLORING`
- Find the root cause

**Example conversation:**
```
You: /start-exploration

Cascade: I'll help you start exploration for debugging.
What issue are you investigating?

You: Auth token validation is failing for expired tokens

Cascade: [Creates explore/auth-token-validation branch]
[Creates .EXPLORING file]

🔍 EXPLORATION MODE ACTIVE
Branch: explore/auth-token-validation
Remember: DO NOT COMMIT

You can now:
- Add debug code freely
- Try different approaches
- Document findings in .EXPLORING

What would you like to explore first?

You: Add console.log to see what's happening in validateToken function

Cascade: [Adds debug logging]
I've added logging. Run the tests to see output:
npm test tests/unit/auth.test.js

You: [Reviews logs, finds issue]
The problem is we're checking expiration before signature

Cascade: Good finding! Document this in .EXPLORING:
Root cause: Token validation checks expiration before signature,
allowing invalid tokens to pass if expired.

Ready to implement the fix?

You: Yes

Cascade: Great! Run /implement-clean-fix to start clean implementation.
```

### Step 2: Implement Clean Fix

**You say:**
```
/implement-clean-fix
```

**Cascade will:**
1. Show your exploration findings
2. Delete exploration branch
3. Create `fix/[issue]` branch
4. Guide you through TDD implementation
5. Help write commit message with root cause

**Example conversation:**
```
You: /implement-clean-fix

Cascade: I'll help you implement a clean fix.

Your exploration findings:
Root cause: Token validation checks expiration before signature
Solution: Reorder validation - signature first, then expiration

I'll now:
1. Return to main branch
2. Delete explore/auth-token-validation
3. Create fix/auth-token-validation

Proceed? (yes/no)

You: yes

Cascade: [Switches branches, cleans up]

Now let's implement cleanly. First, write a failing test.
Should I create the test file?

You: Yes, create tests/unit/backend/services/auth.test.js

Cascade: [Creates test file with failing test]

Test created. Run it to verify it fails:
npm test tests/unit/backend/services/auth.test.js

You: [Runs test, confirms failure]

Cascade: Good. Now let's implement the fix.
I'll update src/backend/services/auth.js to check signature first.

[Shows proposed changes]

Approve? (yes/no)

You: yes

Cascade: [Implements fix]

Fix implemented. Run tests:
npm test

You: [Tests pass]

Cascade: Excellent! All tests pass. Ready to commit?

I'll create a commit with:
- Root cause analysis
- Solution explanation
- Test file
- Implementation file

Approve commit message? [Shows message]

You: yes

Cascade: [Commits with proper message]

Committed! Now run quality checks:
npm run pre-push

You: [Checks pass]

Cascade: Perfect! Push and create PR:
git push origin fix/auth-token-validation

You: [Pushes]

Cascade: PR created! The fix is clean and ready for review.
```

## Workflow 2: Adding a New Feature

**You say:**
```
/new-feature
```

**Cascade will:**
1. Create `feat/[feature]` branch
2. Guide you through TDD
3. Help write tests first
4. Implement feature
5. Add documentation

**Example conversation:**
```
You: /new-feature

Cascade: I'll help you develop a new feature using TDD.
What feature are you building?

You: Add email verification for participants

Cascade: [Creates feat/email-verification branch]

Let's start with tests. I'll create:
tests/unit/backend/services/email-verification.test.js

What should the first test case be?

You: Test that verification code is generated with 6 digits

Cascade: [Creates test]

describe('Email Verification', () => {
  it('generates 6-digit verification code', () => {
    const code = generateVerificationCode();
    expect(code).toMatch(/^\d{6}$/);
  });
});

Run test (should fail):
npm test tests/unit/backend/services/email-verification.test.js

You: [Test fails as expected]

Cascade: Good! Now implement generateVerificationCode().
Should I create src/backend/services/email-verification.js?

You: yes

Cascade: [Implements minimal code to pass test]

Test should now pass. Run:
npm test tests/unit/backend/services/email-verification.test.js

You: [Test passes]

Cascade: Great! What's the next test case?

[Continue TDD cycle...]
```

## Workflow 3: Running UAT

**You say:**
```
/run-uat
```

**Cascade will:**
1. Ask which sprint
2. Navigate to UAT directory
3. Show test plan
4. Run all tests
5. Show results and artifacts

**Example conversation:**
```
You: /run-uat

Cascade: Which sprint UAT would you like to run?
1. Sprint 1 - Foundation & Database
2. Sprint 2 - Sprint Creation & Admin
3. Sprint 3 - Participant Flow & Topics
4. Sprint 4 - Support System & Notes
5. Sprint 5 - Moderation & LLM
6. Sprint 6 - Production Hardening

You: 1

Cascade: Running Sprint 1 UAT - Foundation & Database

First, let me show you the test plan:
[Shows README.md content]

Ready to run tests? (yes/no)

You: yes

Cascade: [Runs ./run-all.sh]

Sprint 1 UAT - Foundation & Database
====================================

✓ Database schema validation (15 tests)
  ✓ Sprint table exists with correct columns
  ✓ Participant table has foreign key to Sprint
  ...

✓ API health checks (5 tests)
  ✓ GET /health returns 200
  ...

✓ Authentication (8 tests)
  ✓ Admin token generates 256-bit entropy
  ...

Test Suites: 3 passed, 3 total
Tests:       28 passed, 28 total
Coverage:    87.5%

All tests passed! ✅

Artifacts saved to: tests/uat/sprint-1/artifacts/2026-03-12-140000/

Would you like me to show you:
1. Test results JSON
2. Execution log
3. Coverage report
4. Database schema dump

You: 2

Cascade: [Shows test-log.txt]

[Detailed execution log with timestamps...]

UAT completed successfully! Sprint 1 acceptance criteria met.
```

## Workflow 4: Quality Check

**You say:**
```
/quality-check
```

**Cascade will:**
1. Run linting
2. Run tests
3. Check coverage
4. Check for debug code
5. Report results

**Example conversation:**
```
You: /quality-check

Cascade: Running quality checks...

1. Linting...
   ✅ No linting errors

2. Unit tests...
   ✅ 156 tests passed

3. Coverage...
   ✅ 87.3% (above 80% threshold)

4. Debug code check...
   ❌ Found console.log in src/backend/services/auth.js:45

5. Build check...
   ✅ Build successful

Fix debug code before committing.
Should I remove the console.log statements? (yes/no)

You: yes

Cascade: [Removes console.log]

Removed debug code. Running checks again...

All quality checks passed! ✅
Ready to commit.
```

## Using Cascade Chat Commands

### Quick Commands

**Check current branch:**
```
What branch am I on?
```

**Check for debug code:**
```
Check if I have any console.log or debugger statements
```

**Run tests:**
```
Run unit tests
```

**Check coverage:**
```
What's my test coverage?
```

**Review exploration findings:**
```
Show me what's in .EXPLORING
```

**Create commit message:**
```
Help me write a commit message for this fix
[Explain the fix]
```

### Cascade Will Remind You

Cascade knows the development discipline protocol and will:

✅ **Warn you** if you try to commit on an exploration branch
✅ **Suggest** running quality checks before pushing
✅ **Remind you** to write tests first (TDD)
✅ **Help you** write proper commit messages
✅ **Check for** debug code before commits
✅ **Guide you** through the two-phase workflow

### Example Reminders

```
You: git add .

Cascade: ⚠️ Warning: You're on an exploration branch (explore/auth-bug).
Exploration branches should not be committed.

Did you mean to:
1. Continue exploring (don't commit yet)
2. Implement clean fix (run /implement-clean-fix)

---

You: I'm ready to commit this fix

Cascade: Before committing, let me check:
- ✅ Tests pass
- ❌ Found console.log in auth.js
- ✅ Linting passes

Remove debug code first. Should I remove it? (yes/no)

---

You: git commit -m "fix bug"

Cascade: ⚠️ Commit message doesn't follow template.

Should include:
- Type prefix (fix:, feat:, etc.)
- Root cause analysis
- Solution explanation

Would you like me to help write a proper commit message? (yes/no)
```

## Turbo Mode

Add `// turbo` comment above commands in workflows to auto-run safe commands:

```markdown
Run tests:
```bash
// turbo
npm test
```
```

Cascade will automatically run these without asking for confirmation.

## Tips for Working with Cascade

### 1. Be Explicit About Phase

Tell Cascade what phase you're in:
```
I'm exploring a bug in auth validation
```
or
```
I'm ready to implement the fix cleanly
```

### 2. Ask for Workflow Guidance

```
What's the next step in the clean fix workflow?
```

### 3. Request Quality Checks

```
Run quality checks before I commit
```

### 4. Ask for Documentation

```
What does the development discipline say about this?
```

### 5. Get Workflow Help

```
Show me how to use the exploration workflow
```

## Common Scenarios

### Scenario 1: Found a Bug While Developing Feature

```
You: I found a bug while working on my feature

Cascade: Let's handle this properly:
1. Commit your current feature work (if clean)
2. Run /start-exploration for the bug
3. After fixing, return to feature branch

Should I help you commit current work first? (yes/no)
```

### Scenario 2: Exploration Taking Too Long

```
You: I've been exploring for a while and haven't found the root cause

Cascade: That's okay. Exploration can take time.

Current findings in .EXPLORING:
[Shows what you've documented]

Would you like to:
1. Continue exploring (try different approach)
2. Ask for help (I can suggest debugging strategies)
3. Take a break (commit findings to .EXPLORING)

What would help most?
```

### Scenario 3: Forgot to Create Exploration Branch

```
You: I've been debugging on main branch with console.logs

Cascade: ⚠️ You're making exploratory changes on main.

Let's fix this:
1. Stash your changes: git stash
2. Create exploration branch: git checkout -b explore/issue
3. Apply changes: git stash pop
4. Continue exploring (don't commit)

Should I do this for you? (yes/no)
```

### Scenario 4: Ready to Push But Tests Fail

```
You: Ready to push but tests are failing

Cascade: Let's diagnose:

Running tests...
❌ 3 tests failing in auth.test.js

Failures:
1. Token validation rejects expired tokens
2. Token validation accepts valid tokens
3. Token expiration check works

This suggests the fix may have broken existing functionality.

Would you like to:
1. Review the test failures
2. Revert changes and re-explore
3. Fix the tests (if they're wrong)

What would you like to do?
```

## Keyboard Shortcuts (Windsurf)

You can set up custom shortcuts in Windsurf settings:

- `Ctrl+Shift+E` - Start exploration
- `Ctrl+Shift+I` - Implement clean fix
- `Ctrl+Shift+Q` - Quality check
- `Ctrl+Shift+T` - Run tests
- `Ctrl+Shift+U` - Run UAT

## Integration with Git Hooks

The workflows work seamlessly with git hooks:

1. **Pre-commit hook** blocks commits on exploration branches
2. **Commit-msg hook** validates commit message format
3. **Pre-push hook** runs full quality checks

Cascade will remind you if hooks block an action.

## Workflow Files Location

All workflows are in `.windsurf/workflows/`:

```
.windsurf/workflows/
├── start-exploration.md
├── implement-clean-fix.md
├── new-feature.md
├── run-uat.md
└── quality-check.md
```

You can customize these files to match your preferences.

## Getting Help

### In Cascade Chat

```
How do I use the exploration workflow?
Show me the development discipline protocol
What's the difference between explore and fix branches?
Help me write a commit message
```

### In Documentation

- `docs/DEVELOPMENT_DISCIPLINE.md` - Full protocol
- `docs/QUICK_START.md` - Quick reference
- `docs/ROADMAP.md` - Sprint structure
- `docs/TESTING_STRATEGY.md` - Testing approach

## Summary

### The Protocol in Windsurf

1. **Bug found** → `/start-exploration`
2. **Debug freely** → Add logs, try approaches
3. **Root cause found** → Document in `.EXPLORING`
4. **Ready to fix** → `/implement-clean-fix`
5. **Write test** → Cascade helps with TDD
6. **Implement** → Clean, minimal code
7. **Quality check** → `/quality-check`
8. **Commit** → Cascade validates message
9. **Push** → Hooks run final checks

### Key Principles

- 🚫 Never commit on `explore/*` branches
- ✅ Always rewrite cleanly on `fix/*` or `feat/*` branches
- 📝 Document root cause in commits
- 🧪 Write tests first (TDD)
- 🔍 Use Cascade to guide you through workflows
- ✨ Let hooks and automation enforce quality

### Quick Reference Card

```
/start-exploration     → Begin debugging (no commits)
/implement-clean-fix   → Clean rewrite after exploration
/new-feature          → TDD feature development
/run-uat              → Execute sprint UAT
/quality-check        → Pre-commit/push checks

Cascade knows the protocol and will guide you!
```
