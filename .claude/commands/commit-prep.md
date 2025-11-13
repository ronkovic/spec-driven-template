---
description: Prepare for committing changes with quality checks
---

Prepare for commit by running comprehensive checks:

## IMPORTANT: Output Language
**All output, check results, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## 1. Run All Tests
```bash
npm run test
```
- Ensure all tests pass
- Check coverage hasn't decreased
- Verify no flaky tests

## 2. Type Checking
```bash
npm run type-check
```
- No TypeScript errors
- No implicit any types

## 3. Linting
```bash
npm run lint
```
- All ESLint rules passing
- No warnings (or documented exceptions)

## 4. Code Formatting
```bash
npm run format
```
- All files formatted with Prettier

## 5. Check Spec Updates
- Verify `/specs/implementation/` files are updated
- Ensure any deviations are documented
- Update decision logs if needed

## 6. Verify Todos Completed
- All related todos marked as completed
- No pending tasks for this feature

## 7. Review Changed Files
```bash
git status
git diff
```
- List all modified files
- Ensure no unintended changes
- Check for debug code or console.logs

## 8. Generate Commit Message
Follow the template:
```
[Feature/Fix/Docs] Brief description

- Detailed change 1
- Detailed change 2
- Detailed change 3

Refs: #issue-number (if applicable)
Specs: /specs/implementation/feature-name.md
Tests: Added/Updated
```

**IMPORTANT - Commit Message Rules**:
- **DO NOT** include Claude Code signature
- **DO NOT** add `🤖 Generated with [Claude Code]`
- **DO NOT** add `Co-Authored-By: Claude <noreply@anthropic.com>`
- Keep commit messages simple and professional
- Focus on what changed and why

## 9. Pre-Commit Checklist
- [ ] Tests passing
- [ ] Types valid
- [ ] Linter passing
- [ ] Formatted
- [ ] Specs updated
- [ ] Todos completed
- [ ] No secrets exposed
- [ ] Documentation current

## 10. Ready to Commit
If all checks pass, show:
- Commit message
- List of files to be committed
- Ask user for final confirmation
