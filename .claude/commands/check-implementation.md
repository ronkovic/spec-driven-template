---
description: Check implementation status and run quality gates
args:
  - name: feature-name
    description: Name of the feature to check (optional, checks current implementation if omitted)
---

Check the implementation status, verify todos completion, and run quality gates.

## IMPORTANT: Output Language
**All output, documentation, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Execution Steps

### 1. Check Todo Status

Verify all todos are completed:

```typescript
// Check todo list
const todos = getTodoList();
const completed = todos.filter(t => t.status === 'completed').length;
const total = todos.length;

console.log(`✅ Todos: ${completed}/${total} completed`);

// If not all completed, list remaining
if (completed < total) {
  const remaining = todos.filter(t => t.status !== 'completed');
  console.log('⚠️  Remaining todos:');
  remaining.forEach(t => console.log(`  - ${t.content}`));
}
```

### 2. Run Quality Gates

Execute quality checks in the following order:

#### 2.1. Run All Tests
```bash
npm run test
```

**Check**:
- All tests pass
- Coverage meets threshold (80%)
- No test failures

#### 2.2. TypeScript Type Check
```bash
npm run type-check
# or
npx tsc --noEmit
```

**Check**:
- No TypeScript errors
- All types properly defined

#### 2.3. Linting Check
```bash
npm run lint
```

**Check**:
- No ESLint errors
- Code follows style guidelines

#### 2.4. Format Check
```bash
npm run format:check
# or
npx prettier --check .
```

**Check**:
- All files properly formatted
- Consistent code style

### 3. Analyze Files Changed

List all files created or modified:

```bash
# Check git status
git status

# Show file changes
git diff --stat
```

Categorize files:
- **Database**: Prisma schema, migrations
- **Backend**: Services, repositories, validation schemas
- **API**: API routes, Server Actions
- **Frontend**: Components, pages
- **Tests**: Unit tests, integration tests, E2E tests
- **Other**: Configuration, documentation

### 4. Generate Status Report

Create a comprehensive status report in Japanese:

```markdown
=== Implementation Status Check ===

## Todo Status
✅ All todos complete (13/13)
  ✅ Database & Schema (3/3)
  ✅ Validation & Service (4/4)
  ✅ API Endpoints (2/2)
  ✅ UI Components (3/3)
  ✅ Testing (1/1)

## Quality Gates
✅ Tests: 24 passed, 0 failed
✅ Coverage: 87% (target: 80%)
✅ TypeScript: No errors
✅ ESLint: No errors
✅ Prettier: All formatted

## Test Breakdown
- Unit tests: 8 passed
- Integration tests: 7 passed
- Component tests: 9 passed

## File Changes
### Modified Files (2)
- prisma/schema.prisma
- prisma/migrations/20251113_add_comment_model/migration.sql

### Created Files (9)
- src/lib/schemas/comment.schema.ts
- src/services/comment.service.ts
- src/services/comment.service.test.ts
- src/app/api/reports/[id]/comments/route.ts
- src/app/api/reports/[id]/comments/route.test.ts
- src/components/CommentList.tsx
- src/components/CommentItem.tsx
- src/components/CommentForm.tsx
- src/components/CommentList.test.tsx

## Status
✅ Implementation complete
✅ All quality gates passed
✅ Ready to update specs and prepare commit

## Next Steps
1. Reflect implementation in specs: "Please update specs with implementation details"
2. Prepare commit: `/commit-prep`
```

### 5. Identify Issues

If any quality gate fails, provide clear guidance:

```markdown
⚠️  Issues found in quality gates

## Failed Items
❌ Tests: 2 tests failed
  - src/services/comment.service.test.ts: "should validate permissions"
  - src/components/CommentList.test.tsx: "should display comments"

❌ TypeScript: 3 errors found
  - src/services/comment.service.ts:45:12 - Type 'string | undefined' is not assignable to type 'string'
  - src/components/CommentForm.tsx:78:5 - Property 'onSubmit' does not exist on type 'FormProps'

## Recommended Actions
1. Fix test errors
2. Fix TypeScript errors
3. Run quality gates again

## Re-check After Fixes
After fixes, run this command again:
"Please check implementation status"
```

### 6. Next Steps Recommendation

Based on the status, recommend next steps:

**If all checks pass**:
```
✅ Implementation complete and all quality gates passed.

Next steps:
1. Please update specs to reflect implementation details
2. Run `/commit-prep` to prepare commit
```

**If checks fail**:
```
⚠️  Some issues found. Fixes required.

Recommended actions:
1. Fix the issues listed above
2. Run this command again after fixes
```

**If todos incomplete**:
```
⚠️  Some todos are not yet complete.

Remaining todos:
- [pending] Create UI component tests
- [in_progress] Implement API endpoints

Recommended action:
Continue implementation. Run this command again after completion.
```

## Output Format

The output should be structured and easy to read:

1. **Summary Section**: High-level overview (todos, quality gates)
2. **Details Section**: Detailed breakdown (test results, file changes)
3. **Issues Section**: Any problems found (only if issues exist)
4. **Next Steps Section**: Clear guidance on what to do next

## Tips

### Quality Gate Standards
- **Tests**: Must all pass, coverage ≥ 80%
- **TypeScript**: Zero errors
- **ESLint**: Zero errors or warnings
- **Prettier**: All files formatted

### Common Issues
- **Test failures**: Focus on fixing logic errors
- **Type errors**: Add proper type annotations
- **Lint errors**: Follow project style guide
- **Format errors**: Run `npm run format`

### Time Estimates
- Check with all gates passing: 2-5 minutes
- Check with failures: 5-15 minutes (includes analysis)

## Important Notes

1. **Run all quality gates** - Don't skip any checks
2. **Provide clear feedback** - Users should understand what's wrong
3. **Be actionable** - Always suggest concrete next steps
4. **Write in Japanese** - All user-facing text in Japanese
5. **Include metrics** - Show test counts, coverage percentages
6. **Categorize files** - Group changed files by type
