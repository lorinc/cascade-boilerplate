## Description

<!-- Provide a clear and concise description of the changes -->

## Type of Change

<!-- Mark the relevant option with an 'x' -->

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Refactoring (no functional changes)
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Test additions/updates

## Root Cause Analysis (for bug fixes)

<!-- If this is a bug fix, explain what caused the issue -->

**Root Cause:**


**Why it happened:**


## Solution Approach

<!-- Explain how this PR solves the problem -->

**Implementation:**


**Alternatives Considered:**


**Why this approach:**


## Testing

<!-- Describe the tests you ran and how to reproduce them -->

- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] E2E tests added/updated
- [ ] Manual testing performed

**Test Coverage:**
- Before: __%
- After: __%

**How to test:**
1. 
2. 
3. 

## Code Quality Checklist

<!-- Verify all items before requesting review -->

### Clarity
- [ ] Code is self-explanatory (minimal comments needed)
- [ ] Variable and function names are descriptive
- [ ] No "clever" or obscure solutions
- [ ] Logic flow is straightforward

### Completeness
- [ ] Tests added for new functionality
- [ ] Tests added for bug fixes (regression prevention)
- [ ] Documentation updated
- [ ] No debug code (console.log, debugger)
- [ ] No commented-out code
- [ ] No TODO/FIXME comments (or issues created for them)

### Minimalism
- [ ] Only necessary changes included
- [ ] No unrelated refactoring
- [ ] No "while I'm here" changes
- [ ] Smallest possible fix for the issue

### Quality
- [ ] All tests pass locally
- [ ] No linting errors
- [ ] Code coverage maintained or improved (≥80%)
- [ ] Performance impact considered
- [ ] Security implications considered

### Git Hygiene
- [ ] Atomic commits (one logical change per commit)
- [ ] Clear commit messages following template
- [ ] No merge commits (rebased on main)
- [ ] Branch up to date with main

## Clean Implementation Verification

<!-- Confirm this is NOT exploratory code -->

- [ ] This is a clean implementation, not exploratory code
- [ ] All debug/logging code removed
- [ ] No commented-out attempted fixes
- [ ] Code was reviewed and rewritten from clear perspective
- [ ] Root cause fully understood before implementation

## Related Issues

<!-- Link to related issues -->

Fixes: #
Related to: #

## Screenshots (if applicable)

<!-- Add screenshots for UI changes -->

## Deployment Notes

<!-- Any special deployment considerations -->

- [ ] Database migrations required
- [ ] Environment variables added/changed
- [ ] Infrastructure changes required
- [ ] Breaking changes (requires coordination)

## Reviewer Guidance

<!-- Help reviewers understand what to focus on -->

**Focus areas:**


**Potential concerns:**


**Questions for reviewers:**


---

## For Reviewers

### Review Checklist

- [ ] Code follows project conventions and style
- [ ] Logic is sound and handles edge cases
- [ ] Tests are meaningful and comprehensive
- [ ] No exploratory artifacts (debug code, commented attempts)
- [ ] Commit messages are clear and follow template
- [ ] Changes are minimal and focused
- [ ] Documentation is updated
- [ ] Security implications considered
- [ ] Performance implications considered

### Approval Criteria

- [ ] All automated checks pass (tests, linting, coverage)
- [ ] Code quality checklist completed
- [ ] Clean implementation verified
- [ ] At least one approval from team member
