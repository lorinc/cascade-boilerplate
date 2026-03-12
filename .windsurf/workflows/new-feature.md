---
description: Start new feature development with TDD
---

# New Feature Development

This workflow helps you develop a new feature using Test-Driven Development (TDD).

## Steps

1. **Create feature branch**
```bash
git checkout main
git pull origin main
git checkout -b feat/[feature-name]
```

2. **Write tests first (TDD)**

### Unit Tests
Create test file: `tests/unit/[module]/[feature].test.js`

```javascript
describe('[Feature Name]', () => {
  it('should [expected behavior]', () => {
    // Arrange
    const input = ...;
    
    // Act
    const result = featureFunction(input);
    
    // Assert
    expect(result).toBe(expected);
  });
});
```

### Integration Tests
Create test file: `tests/integration/[feature].test.js`

```javascript
describe('[Feature Name] Integration', () => {
  it('should [expected behavior] end-to-end', async () => {
    // Test the full flow
  });
});
```

3. **Run tests (should fail)**
```bash
// turbo
npm test tests/unit/[your-test]
```

4. **Implement feature**
- [ ] Create files in `src/`
- [ ] Implement minimal code to make tests pass
- [ ] Follow existing code style
- [ ] Add JSDoc comments for public APIs

5. **Run tests (should pass)**
```bash
// turbo
npm test
```

6. **Add documentation**
- [ ] Update relevant docs in `docs/`
- [ ] Add inline comments for complex logic
- [ ] Update README if needed

7. **Commit atomically**
```bash
git add src/[files] tests/[files]
git commit -m "feat: [feature description]

Implements [feature] with [approach].

Includes:
- Unit tests
- Integration tests
- Documentation

Related to: #[issue-number]"
```

8. **Quality check**
```bash
// turbo
npm run pre-push
```

9. **Push and create PR**
```bash
git push origin feat/[feature-name]
```

## TDD Cycle

Follow the Red-Green-Refactor cycle:

1. **🔴 Red:** Write failing test
2. **🟢 Green:** Write minimal code to pass
3. **🔵 Refactor:** Improve code quality
4. **Repeat** for next test case

## Feature Checklist

- [ ] Tests written first
- [ ] All tests pass
- [ ] Code coverage ≥ 80%
- [ ] No debug code
- [ ] No commented code
- [ ] Documentation updated
- [ ] Linting passes
- [ ] Build succeeds
