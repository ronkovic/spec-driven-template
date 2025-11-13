# Spec-Driven Development Template - Initialization Script (PowerShell)
# This script initializes a new project from this template

param(
    [string]$ProjectName
)

Write-Host "🚀 Initializing Spec-Driven Development Template..." -ForegroundColor Cyan
Write-Host ""

# Check if we're in the template directory
if (-not (Test-Path ".claude/commands") -or -not (Test-Path "specs/templates")) {
    Write-Host "✗ Error: This script must be run from the template root directory" -ForegroundColor Red
    exit 1
}

# Get project name
if (-not $ProjectName) {
    $ProjectName = Read-Host "Please enter your project name (kebab-case, e.g., my-awesome-project)"
}

# Validate project name
if ($ProjectName -notmatch "^[a-z0-9-]+$") {
    Write-Host "✗ Invalid project name. Use lowercase letters, numbers, and hyphens only." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "ℹ Project name: $ProjectName" -ForegroundColor Yellow
Write-Host ""

# Ask for confirmation
Write-Host "This will:"
Write-Host "  1. Remove git history"
Write-Host "  2. Initialize new git repository"
Write-Host "  3. Create initial commit"
Write-Host ""
$confirm = Read-Host "Continue? (y/N)"

if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "ℹ Initialization cancelled" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "ℹ Starting initialization..." -ForegroundColor Yellow
Write-Host ""

# Step 1: Remove existing git history
Write-Host "ℹ Removing existing git history..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Remove-Item -Recurse -Force .git
}
Write-Host "✓ Git history removed" -ForegroundColor Green

# Step 2: Initialize new git repository
Write-Host "ℹ Initializing new git repository..." -ForegroundColor Yellow
git init
Write-Host "✓ Git repository initialized" -ForegroundColor Green

# Step 3: Create .gitignore if it doesn't exist
if (-not (Test-Path ".gitignore")) {
    Write-Host "ℹ Creating .gitignore..." -ForegroundColor Yellow
    @"
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/
.nyc_output

# Next.js
.next/
out/
build/
dist/

# Environment
.env
.env*.local

# IDE
.vscode/
.idea/
*.swp
*.swo
.DS_Store

# Logs
*.log
npm-debug.log*

# Database
*.db
*.db-journal

# Prisma
prisma/migrations/*_init/
"@ | Out-File -FilePath .gitignore -Encoding UTF8
    Write-Host "✓ .gitignore created" -ForegroundColor Green
}

# Step 4: Stage all files
Write-Host "ℹ Staging files..." -ForegroundColor Yellow
git add .
Write-Host "✓ Files staged" -ForegroundColor Green

# Step 5: Create initial commit
Write-Host "ℹ Creating initial commit..." -ForegroundColor Yellow
git commit -m @"
chore: initialize project from spec-driven-template

Project: $ProjectName

🤖 Initialized with Spec-Driven Development Template
"@
Write-Host "✓ Initial commit created" -ForegroundColor Green

# Step 6: Set main as default branch
Write-Host "ℹ Setting main as default branch..." -ForegroundColor Yellow
git branch -M main
Write-Host "✓ Default branch set to main" -ForegroundColor Green

# Done
Write-Host ""
Write-Host "✓ Initialization complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Next steps:"
Write-Host "  1. Run: git remote add origin <your-repository-url>"
Write-Host "  2. Run: git push -u origin main"
Write-Host "  3. Run: /init-project $ProjectName"
Write-Host ""
Write-Host "📚 Documentation:"
Write-Host "  - Workflow Guide: docs\WORKFLOW_GUIDE.md"
Write-Host "  - Quick Start: TEMPLATE_CHECKLIST.md"
Write-Host ""
