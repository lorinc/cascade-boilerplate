# Installation Guide

## Quick Install

### Option 1: Clone and Copy (Recommended)

```bash
# In your project directory
cd your-project

# Add boilerplate as remote
git remote add boilerplate https://github.com/lorinc/cascade-boilerplate.git

# Fetch boilerplate files
git fetch boilerplate

# Copy all boilerplate files to your project
git checkout boilerplate/main -- .windsurf .cascade .git-hooks .github .gitmessage .eslintrc.js .prettierrc.js docs/DEVELOPMENT_DISCIPLINE.md docs/WINDSURF_HOWTO.md docs/QUICK_REFERENCE.md

# Install git hooks
chmod +x .git-hooks/install.sh
./.git-hooks/install.sh

# Install dependencies
npm install
```

### Option 2: Manual Download

```bash
# Download and extract
curl -L https://github.com/lorinc/cascade-boilerplate/archive/main.zip -o cascade-boilerplate.zip
unzip cascade-boilerplate.zip

# Copy files to your project
cp -r cascade-boilerplate-main/.windsurf your-project/
cp -r cascade-boilerplate-main/.cascade your-project/
cp -r cascade-boilerplate-main/.git-hooks your-project/
cp -r cascade-boilerplate-main/.github your-project/
cp cascade-boilerplate-main/.gitmessage your-project/
cp cascade-boilerplate-main/.eslintrc.js your-project/
cp cascade-boilerplate-main/.prettierrc.js your-project/
cp cascade-boilerplate-main/docs/DEVELOPMENT_DISCIPLINE.md your-project/docs/
cp cascade-boilerplate-main/docs/WINDSURF_HOWTO.md your-project/docs/
cp cascade-boilerplate-main/docs/QUICK_REFERENCE.md your-project/docs/

# Install hooks
cd your-project
chmod +x .git-hooks/install.sh
./.git-hooks/install.sh
```

## Post-Installation

### 1. Update package.json

Add these scripts to your `package.json`:

```json
{
  "scripts": {
    "hooks:install": "bash .git-hooks/install.sh",
    "lint": "eslint 'src/**/*.{js,jsx,ts,tsx}'",
    "lint:fix": "eslint 'src/**/*.{js,jsx,ts,tsx}' --fix",
    "format": "prettier --write 'src/**/*.{js,jsx,ts,tsx,json,css,md}'",
    "format:check": "prettier --check 'src/**/*.{js,jsx,ts,tsx,json,css,md}'",
    "pre-commit": "npm run lint && npm run test:unit",
    "pre-push": "npm run test && npm run test:coverage",
    "quality:check": "npm run lint && npm run format:check && npm run test:coverage",
    "quality:fix": "npm run lint:fix && npm run format"
  }
}
```

### 2. Install Dependencies

```bash
npm install --save-dev \
  @typescript-eslint/eslint-plugin \
  @typescript-eslint/parser \
  eslint \
  eslint-config-prettier \
  prettier
```

### 3. Configure for Your Project

#### Update .eslintrc.js

Adjust rules for your project:

```javascript
module.exports = {
  // ... existing config ...
  rules: {
    // Add your project-specific rules
    'no-console': ['error', { allow: ['warn', 'error'] }],
    // ...
  }
};
```

#### Update .prettierrc.js

Adjust formatting preferences:

```javascript
module.exports = {
  semi: true,
  singleQuote: true,
  printWidth: 100,
  // ... your preferences ...
};
```

### 4. Verify Installation

```bash
# Check git hooks are installed
ls -la .git/hooks/

# Should see:
# pre-commit -> ../../.git-hooks/pre-commit
# commit-msg -> ../../.git-hooks/commit-msg
# pre-push -> ../../.git-hooks/pre-push

# Test quality checks
npm run quality:check
```

### 5. Update .gitignore

The boilerplate includes a `.gitignore` that will prevent boilerplate files from being tracked in your project. You may want to customize it:

```bash
# Edit .gitignore to keep what you want
nano .gitignore
```

**Important:** The boilerplate `.gitignore` is designed to ignore itself and the framework files in downstream projects. If you want to track these files in your project, remove the relevant lines from `.gitignore`.

## What Gets Installed

### Directory Structure

```
your-project/
├── .windsurf/
│   └── workflows/           # Cascade workflows (slash commands)
├── .cascade/
│   └── instructions.md      # Cascade agent behavior
├── .git-hooks/
│   ├── pre-commit          # Blocks debug code
│   ├── commit-msg          # Validates commit format
│   ├── pre-push            # Runs full checks
│   └── install.sh          # Hook installer
├── .github/
│   ├── workflows/
│   │   └── quality-checks.yml  # CI/CD automation
│   └── pull_request_template.md
├── docs/
│   ├── DEVELOPMENT_DISCIPLINE.md
│   ├── WINDSURF_HOWTO.md
│   └── QUICK_REFERENCE.md
├── .gitmessage             # Commit template
├── .eslintrc.js            # Linting config
├── .prettierrc.js          # Formatting config
└── .gitignore              # Ignores boilerplate files
```

## Customization

### For JavaScript Projects

The default configuration works for JavaScript/TypeScript projects.

### For Python Projects

Replace `.eslintrc.js` and `.prettierrc.js` with Python equivalents:

```bash
# Remove JS configs
rm .eslintrc.js .prettierrc.js

# Add Python configs
# Create .flake8, .pylintrc, pyproject.toml, etc.
```

Update git hooks to use Python linters.

### For Other Languages

Adapt the configuration files and git hooks for your language:

1. Update linting configuration
2. Update formatting configuration
3. Update git hooks to use appropriate tools
4. Update package.json scripts (or equivalent)

## Troubleshooting

### Hooks Not Running

```bash
# Make hooks executable
chmod +x .git-hooks/*

# Reinstall
npm run hooks:install
```

### Cascade Not Reading Instructions

Cascade reads `.cascade/instructions.md` at session start. Restart Windsurf if needed.

### Workflows Not Appearing

Workflows in `.windsurf/workflows/` should appear when you type `/` in Cascade chat. Restart Windsurf if they don't appear.

### Git Hooks Blocking Valid Commits

Bypass hooks in emergencies:

```bash
git commit --no-verify
git push --no-verify
```

But investigate why the hook blocked the commit.

## Updating the Boilerplate

To get updates from the boilerplate:

```bash
# Fetch latest
git fetch boilerplate

# View changes
git diff HEAD boilerplate/main -- .windsurf .cascade .git-hooks

# Update specific files
git checkout boilerplate/main -- .windsurf/workflows/start-exploration.md

# Or update everything
git checkout boilerplate/main -- .windsurf .cascade .git-hooks .github
```

## Uninstalling

To remove the boilerplate:

```bash
# Remove files
rm -rf .windsurf .cascade .git-hooks
rm .gitmessage .eslintrc.js .prettierrc.js
rm docs/DEVELOPMENT_DISCIPLINE.md docs/WINDSURF_HOWTO.md docs/QUICK_REFERENCE.md
rm .github/workflows/quality-checks.yml .github/pull_request_template.md

# Remove git hooks
rm .git/hooks/pre-commit .git/hooks/commit-msg .git/hooks/pre-push

# Remove remote
git remote remove boilerplate
```

## Next Steps

After installation:

1. Read `docs/QUICK_REFERENCE.md` for a quick overview
2. Read `docs/WINDSURF_HOWTO.md` for Windsurf-specific usage
3. Read `docs/DEVELOPMENT_DISCIPLINE.md` for the complete protocol
4. Try the workflows: `/start-exploration`, `/implement-clean-fix`, etc.
5. Customize configuration files for your project

## Support

For issues or questions:
- Check the documentation in `docs/`
- Review workflow files in `.windsurf/workflows/`
- Read Cascade instructions in `.cascade/instructions.md`
- Open an issue on GitHub
