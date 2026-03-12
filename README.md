# Cascade Development Discipline Boilerplate

A comprehensive development discipline framework for Cascade/Windsurf IDE to prevent patchwork code and enforce clean development practices.

## What This Is

This boilerplate provides:
- **Two-phase workflow** (Explore → Implement) to prevent exploratory code from being committed
- **Windsurf workflows** (slash commands) for common development tasks
- **Git hooks** that enforce code quality automatically
- **Cascade agent instructions** that guide AI pair programming
- **Quality automation** (linting, testing, commit validation)

## The Problem It Solves

When debugging hard-to-find errors, developers (and AI assistants) often take multiple exploratory stabs before finding the root cause. This leads to:
- Patchwork code with multiple attempted fixes layered together
- Unclear intent and technical debt
- Debug code (console.log, debugger) committed to the repository
- Commented-out code showing the "journey" rather than the solution

## The Solution

**Two-Phase Approach:**

### Phase 1: EXPLORE (No Commits)
- Create `explore/*` branch
- Debug freely, add logs, try different approaches
- Document findings in `.EXPLORING` file
- **Never commit** on exploration branches

### Phase 2: IMPLEMENT (Clean Rewrite)
- Delete exploration branch (keep `.EXPLORING` for reference)
- Create `fix/*` or `feat/*` branch
- Write tests first (TDD)
- Implement minimal, clean solution
- Commit with root cause analysis

## Installation

### 1. Clone into Your Project

```bash
cd your-project
git remote add boilerplate https://github.com/lorinc/cascade-boilerplate.git
git fetch boilerplate
git checkout boilerplate/main -- .
```

This will copy all framework files into your project.

### 2. Install Git Hooks

```bash
npm run hooks:install
```

### 3. Configure for Your Project

Edit these files to match your project:
- `package.json` - Update project name, scripts
- `.eslintrc.js` - Adjust linting rules
- `.prettierrc.js` - Adjust formatting preferences

## What's Included

### Windsurf Workflows (`.windsurf/workflows/`)

Slash commands for Cascade chat:

- `/start-exploration` - Begin debugging (blocks commits)
- `/implement-clean-fix` - Clean rewrite after exploration
- `/new-feature` - TDD feature development
- `/run-uat` - Execute UAT tests
- `/quality-check` - Pre-commit/push quality checks

### Cascade Instructions (`.cascade/instructions.md`)

Teaches Cascade to:
- Block commits on exploration branches
- Warn about debug code
- Enforce proper commit messages
- Guide through two-phase workflow
- Run quality checks automatically

### Git Hooks (`.git-hooks/`)

- **pre-commit** - Blocks debug code, runs linter and tests
- **commit-msg** - Validates commit message format
- **pre-push** - Runs full test suite, coverage check, build

### Documentation (`docs/`)

- `DEVELOPMENT_DISCIPLINE.md` - Complete protocol
- `WINDSURF_HOWTO.md` - Windsurf-specific guide
- `QUICK_REFERENCE.md` - One-page cheat sheet

### Configuration Files

- `.eslintrc.js` - Linting configuration (blocks console.log, debugger)
- `.prettierrc.js` - Code formatting
- `.gitmessage` - Commit message template
- `.github/workflows/quality-checks.yml` - CI/CD automation
- `.github/pull_request_template.md` - PR checklist

## Usage

### Debugging a Bug

```bash
# 1. Start exploration
/start-exploration

# 2. Debug freely (add console.log, try approaches)
# Document findings in .EXPLORING

# 3. Implement clean fix
/implement-clean-fix

# 4. Write test, implement, commit
```

### Adding a Feature

```bash
# 1. Start feature development
/new-feature

# 2. Follow TDD (test first, then implement)

# 3. Commit with proper message
```

### Before Committing

```bash
# Run quality checks
/quality-check

# Or manually
npm run pre-commit
```

## Workflows

### Exploration Workflow

1. Create `explore/[issue]` branch
2. Add debug code freely
3. Try multiple approaches
4. Document findings in `.EXPLORING`
5. **DO NOT COMMIT**

### Implementation Workflow

1. Review `.EXPLORING` findings
2. Delete exploration branch
3. Create `fix/[issue]` or `feat/[feature]` branch
4. Write failing test
5. Implement minimal fix
6. Verify test passes
7. Remove all debug code
8. Commit with root cause analysis

## Branch Naming

- `explore/*` - Exploration only (never merged)
- `fix/*` - Bug fixes
- `feat/*` - New features
- `refactor/*` - Code improvements
- `test/*` - Test additions
- `docs/*` - Documentation

## Commit Message Format

```
<type>: <short description> (max 72 chars)

<detailed explanation>

Root cause: <what caused the issue>
Solution: <how this fixes it>

Fixes: #<issue-number>
```

**Types:** `fix`, `feat`, `refactor`, `test`, `docs`, `perf`, `chore`

## Git Hooks

Hooks automatically enforce quality:

- **pre-commit:** Blocks debug code, runs linter and unit tests
- **commit-msg:** Validates commit message format
- **pre-push:** Runs all tests, checks coverage (≥80%), verifies build

**Bypass (emergency only):**
```bash
git commit --no-verify
git push --no-verify
```

## Cascade Integration

Cascade (the AI agent in Windsurf) reads `.cascade/instructions.md` and will:

- ✅ Block commits on exploration branches
- ✅ Warn about debug code
- ✅ Guide through two-phase workflow
- ✅ Validate commit messages
- ✅ Run quality checks
- ✅ Provide helpful reminders

### Example Cascade Interaction

```
You: /start-exploration

Cascade: I'll help you start exploration. What issue are you investigating?

You: Auth token validation failing

Cascade: [Creates explore/auth-token-validation branch]
        🔍 EXPLORATION MODE - DO NOT COMMIT
        
        You can now debug freely. What would you like to explore first?

[After finding root cause...]

You: /implement-clean-fix

Cascade: [Guides through clean implementation with TDD]
```

## Quality Standards

All code must meet:

- **Test pass rate:** 100%
- **Code coverage:** ≥ 80%
- **Linting:** No errors
- **No debug code:** No console.log, debugger
- **No commented code:** Remove instead of commenting
- **Proper commits:** Follow message template

## CI/CD Integration

Included GitHub Actions workflow (`.github/workflows/quality-checks.yml`) runs on every PR:

- Linting
- Unit tests
- Integration tests
- E2E tests
- Coverage check
- Build verification
- Security audit
- Branch name validation
- Commit message validation

## Customization

### For Your Project

1. **Update package.json:**
   - Change project name
   - Adjust test scripts
   - Add project-specific dependencies

2. **Adjust linting rules:**
   - Edit `.eslintrc.js`
   - Add project-specific rules

3. **Customize workflows:**
   - Edit files in `.windsurf/workflows/`
   - Add project-specific steps

4. **Update documentation:**
   - Keep `DEVELOPMENT_DISCIPLINE.md` as reference
   - Add project-specific guides

### Optional: Remove UAT Files

If you don't need the UAT (User Acceptance Testing) structure:

```bash
rm -rf tests/uat
```

Update documentation references accordingly.

## Anti-Patterns Prevented

This framework prevents:

❌ Committing exploratory code  
❌ Debug code in commits (console.log, debugger)  
❌ Commented-out code showing "the journey"  
❌ Multiple attempted fixes layered together  
❌ Vague commit messages  
❌ Skipping tests  
❌ Mixed unrelated changes in one commit  

## Best Practices Enforced

This framework enforces:

✅ Explore freely, commit cleanly  
✅ Write tests first (TDD)  
✅ Document root cause in commits  
✅ Keep commits atomic and focused  
✅ Run quality checks before pushing  
✅ Proper commit message format  
✅ No debug code in production  

## Documentation

After installation, read:

1. `docs/QUICK_REFERENCE.md` - One-page cheat sheet
2. `docs/WINDSURF_HOWTO.md` - Windsurf-specific guide
3. `docs/DEVELOPMENT_DISCIPLINE.md` - Complete protocol

## Requirements

- Node.js 18+
- Git 2.0+
- Windsurf IDE with Cascade
- npm or yarn

## License

MIT License - Feel free to use in your projects

## Contributing

Improvements welcome! Please follow the development discipline protocol when contributing.

## Support

For issues or questions:
- Read the documentation in `docs/`
- Check workflow files in `.windsurf/workflows/`
- Review Cascade instructions in `.cascade/instructions.md`

## Credits

Created to solve the "patchwork code" problem that occurs when AI and humans take multiple exploratory stabs at debugging before finding the root cause.

## The Golden Rule

> **Never commit exploratory code. Always rewrite from a clear perspective.**

This is the core principle that prevents patchwork code and keeps your codebase clean.
