---
description: Run User Acceptance Tests for a sprint
---

# Run UAT (User Acceptance Tests)

This workflow runs the UAT for a specific sprint and shows you the actual test execution, logs, and results.

## Steps

1. **Choose sprint**
Available sprints:
- `sprint-1` - Foundation & Database
- `sprint-2` - Sprint Creation & Admin
- `sprint-3` - Participant Flow & Topics
- `sprint-4` - Support System & Notes
- `sprint-5` - Moderation & LLM
- `sprint-6` - Production Hardening

2. **Navigate to UAT directory**
```bash
cd tests/uat/sprint-[N]
```
Replace `[N]` with sprint number (1-6)

3. **Review test plan**
```bash
cat README.md
```

4. **Set up environment (first time only)**
```bash
cp .env.test.example .env.test
# Edit .env.test with your database credentials
```

5. **Run all UAT tests**
```bash
// turbo
./run-all.sh
```

This will:
- Clean test database
- Run migrations
- Execute all test suites
- Generate coverage report
- Create artifacts (logs, screenshots, videos)

## Expected Output

You will see:
- ✅ Real-time test execution (not just "Done")
- ✅ Detailed logs with timestamps
- ✅ Pass/fail results for each test
- ✅ Code coverage percentage
- ✅ Artifact locations

Example:
```
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

Artifacts saved to: artifacts/2026-03-12-140000/
```

## Review Artifacts

After tests complete:

1. **View test results**
```bash
cat artifacts/latest/test-results.json
```

2. **View execution log**
```bash
cat artifacts/latest/test-log.txt
```

3. **View coverage report**
```bash
open artifacts/latest/coverage-report/index.html
```

4. **View screenshots (E2E tests)**
```bash
ls artifacts/latest/screenshots/
```

5. **View videos (E2E tests)**
```bash
ls artifacts/latest/videos/
```

## UAT Sign-Off Checklist

- [ ] All tests passed (≥95%)
- [ ] Code coverage ≥80%
- [ ] No errors in execution
- [ ] Artifacts reviewed
- [ ] Acceptance criteria met (see README.md)

## If Tests Fail

1. Review failure logs in `artifacts/latest/test-log.txt`
2. Identify root cause
3. Use "Start Exploration" workflow to debug
4. Use "Implement Clean Fix" workflow to fix
5. Re-run UAT

## Return to Project Root

```bash
cd ../../..
```
