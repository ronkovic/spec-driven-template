#!/bin/bash

# Spec-Driven Development Template - Initialization Script
# This script initializes a new project from this template

set -e

echo "🚀 Initializing Spec-Driven Development Template..."
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Check if we're in the template directory
if [ ! -d ".claude/commands" ] || [ ! -d "specs/templates" ]; then
    print_error "Error: This script must be run from the template root directory"
    exit 1
fi

# Get project name
if [ -z "$1" ]; then
    echo "Please enter your project name (kebab-case, e.g., my-awesome-project):"
    read -r PROJECT_NAME
else
    PROJECT_NAME=$1
fi

# Validate project name
if ! [[ "$PROJECT_NAME" =~ ^[a-z0-9-]+$ ]]; then
    print_error "Invalid project name. Use lowercase letters, numbers, and hyphens only."
    exit 1
fi

echo ""
print_info "Project name: $PROJECT_NAME"
echo ""

# Ask for confirmation
echo "This will:"
echo "  1. Remove git history"
echo "  2. Initialize new git repository"
echo "  3. Create initial commit"
echo ""
echo "Continue? (y/N)"
read -r CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    print_info "Initialization cancelled"
    exit 0
fi

echo ""
print_info "Starting initialization..."
echo ""

# Step 1: Remove existing git history
print_info "Removing existing git history..."
rm -rf .git
print_success "Git history removed"

# Step 2: Initialize new git repository
print_info "Initializing new git repository..."
git init
print_success "Git repository initialized"

# Step 3: Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    print_info "Creating .gitignore..."
    cat > .gitignore << 'EOF'
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
EOF
    print_success ".gitignore created"
fi

# Step 4: Stage all files
print_info "Staging files..."
git add .
print_success "Files staged"

# Step 5: Create initial commit
print_info "Creating initial commit..."
git commit -m "chore: initialize project from spec-driven-template

Project: $PROJECT_NAME

🤖 Initialized with Spec-Driven Development Template"
print_success "Initial commit created"

# Step 6: Set main as default branch
print_info "Setting main as default branch..."
git branch -M main
print_success "Default branch set to main"

# Done
echo ""
print_success "Initialization complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Run: git remote add origin <your-repository-url>"
echo "  2. Run: git push -u origin main"
echo "  3. Run: /init-project $PROJECT_NAME"
echo ""
echo "📚 Documentation:"
echo "  - Workflow Guide: docs/WORKFLOW_GUIDE.md"
echo "  - Quick Start: TEMPLATE_CHECKLIST.md"
echo ""
