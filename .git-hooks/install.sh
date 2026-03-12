#!/bin/bash
# Install git hooks

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing git hooks...${NC}"

# Create symlinks for hooks
ln -sf ../../.git-hooks/pre-commit .git/hooks/pre-commit
ln -sf ../../.git-hooks/commit-msg .git/hooks/commit-msg
ln -sf ../../.git-hooks/pre-push .git/hooks/pre-push

# Make hooks executable
chmod +x .git-hooks/pre-commit
chmod +x .git-hooks/commit-msg
chmod +x .git-hooks/pre-push

# Configure git to use commit message template
git config commit.template .gitmessage

echo -e "${GREEN}✅ Git hooks installed successfully${NC}"
echo ""
echo "Hooks installed:"
echo "  - pre-commit:  Prevents debug code, runs linter and tests"
echo "  - commit-msg:  Validates commit message format"
echo "  - pre-push:    Runs full test suite and coverage check"
echo ""
echo "Commit message template configured"
echo ""
echo -e "${BLUE}To bypass hooks (use sparingly):${NC}"
echo "  git commit --no-verify"
echo "  git push --no-verify"
