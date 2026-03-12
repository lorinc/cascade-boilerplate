---
description: Start exploration phase for debugging (no commits allowed)
---

# Start Exploration Phase

This workflow helps you start the exploration phase for debugging an issue.

**Remember:** Exploration branches are for finding the root cause only. Never commit on exploration branches.

## Steps

1. **Ensure you're on main branch**
```bash
git checkout main
git pull origin main
```

2. **Create exploration branch**
```bash
git checkout -b explore/[issue-description]
```
Replace `[issue-description]` with a short description (e.g., `explore/auth-token-bug`)

3. **Set exploration mode reminder**
Create a temporary file to remind yourself:
```bash
echo "🔍 EXPLORATION MODE - DO NOT COMMIT" > .EXPLORING
echo "Root cause: [document findings here]" >> .EXPLORING
echo "Solution approach: [document approach here]" >> .EXPLORING
```

## During Exploration

You can freely:
- ✅ Add `console.log()` and debug statements
- ✅ Add `debugger` statements
- ✅ Try multiple approaches
- ✅ Comment out code to test theories
- ✅ Add temporary test code
- ✅ Make notes in `.EXPLORING` file

You should:
- 📝 Document what you try in `.EXPLORING`
- 📝 Note what works and what doesn't
- 📝 Identify the root cause
- 📝 Plan the clean solution

You must NOT:
- ❌ Run `git add`
- ❌ Run `git commit`
- ❌ Run `git push`

## When Done Exploring

When you've found the root cause and know the solution:

1. **Document findings in `.EXPLORING`**
2. **Run the "Implement Clean Fix" workflow**
3. **The exploration branch will be deleted automatically**

## Turbo Mode

If you want Cascade to auto-run safe commands during exploration:
```bash
// turbo
```
Add this comment above any command in this workflow.
