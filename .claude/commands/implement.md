---
description: Implement a feature following spec-driven workflow
args:
  - name: feature-name
    description: Name of the feature to implement
---

Implement the feature following the spec-driven workflow:

## IMPORTANT: Output Language
**All output, implementation notes, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Step 0: Check Review Actions (NEW)

**レビュー結果の確認と対処**

Before starting implementation, check for any pending review actions:

1. **Check for pending review**:
   ```bash
   # レビュー結果ファイルの存在確認
   if exists `/specs/reviews/pending/{{feature-name}}.md`:
     - Display review summary and score
     - List Critical/Important issues that must be addressed
     - Ask user if they want to address issues first
   ```

2. **Load improvement items**:
   ```bash
   # Important Issues の確認
   for each file in `/specs/improvements/important/`:
     if related to {{feature-name}}:
       - Display issue summary
       - Check if deadline is before current phase
       - Warn if action required
   ```

3. **Decision point**:
   ```markdown
   ## レビュー結果が存在します

   ### スコア: 92% (Approved with conditions)

   ### 要対処項目:
   - 🟡 環境依存の暗号化キー管理強化 (期限: 実装開始前)
   - 🟡 レート制限の実装詳細化 (期限: Phase 3前)

   対処しますか？
   1. はい - 改善項目を先に実装 → /implement-improvements
   2. いいえ - そのまま実装を進める（リスクを理解した上で）
   3. 詳細を確認 → /review-actions {{feature-name}}
   ```

## Step 1: Read Implementation Guide

Read `/specs/implementation/{{feature-name}}.md` and extract:

**From Prerequisites Section**:
- Required tools and environment setup
- Environment variables needed
- Dependencies to install

**From Implementation Phases Section**:
- Phase 1: Database & Schema changes
- Phase 2: Validation & Service layer
- Phase 3: API/Server Actions
- Phase 4: Frontend components
- Phase 5: Testing

**From Coding Standards Section**:
- File naming conventions
- Code organization patterns
- Error handling approach
- Security requirements

## Step 2: Create Detailed Todos

Use TodoWrite tool to create granular tasks based on the implementation guide:

**Todo Structure** (follows template phases):
```javascript
[
  // Phase 1: Database & Schema
  { content: "Create Prisma schema for [model]", status: "pending", activeForm: "Creating Prisma schema" },
  { content: "Generate and run database migration", status: "pending", activeForm: "Running migration" },

  // Phase 2: Validation & Service
  { content: "Create Zod validation schemas", status: "pending", activeForm: "Creating validation schemas" },
  { content: "Implement repository layer", status: "pending", activeForm: "Implementing repository" },
  { content: "Implement service layer with business logic", status: "pending", activeForm: "Implementing service" },

  // Phase 3: API/Server Actions
  { content: "Create API endpoints/Server Actions", status: "pending", activeForm: "Creating API" },
  { content: "Add permission checks", status: "pending", activeForm: "Adding permission checks" },

  // Phase 4: Frontend
  { content: "Create page components (Server Components)", status: "pending", activeForm: "Creating pages" },
  { content: "Create interactive components (Client Components)", status: "pending", activeForm: "Creating client components" },

  // Phase 5: Testing
  { content: "Write unit tests for service layer", status: "pending", activeForm: "Writing unit tests" },
  { content: "Write integration tests for API", status: "pending", activeForm: "Writing integration tests" },
  { content: "Write E2E tests for critical flows", status: "pending", activeForm: "Writing E2E tests" }
]
```

**Guidelines**:
- Each todo should be 2-4 hours of work
- Follow the phase order from implementation guide
- Mark dependencies between tasks
- Include verification steps

## Step 3: Confirm Implementation Plan
- Show the user:
  - List of todos created
  - Estimated time
  - Files that will be modified
  - Any risks or blockers
- Wait for user confirmation before proceeding

## Step 4: Execute Implementation (TDD Approach with Review Integration)

For each todo:
1. **Check phase-specific improvements**:
   ```bash
   # 現在のフェーズに関連する改善項目を確認
   if current_phase matches improvement_deadline:
     - Alert user about pending improvements
     - Suggest running: /implement-improvements [improvement-name]
   ```

2. Mark todo as in_progress

3. **Apply improvement suggestions**:
   - Check `/specs/improvements/` for relevant code patterns
   - Apply security enhancements from review
   - Use recommended implementations

4. Write tests first (if applicable)
5. Implement the feature
6. Run tests to verify
7. Mark todo as completed
8. Commit incrementally with review reference:
   ```bash
   git commit -m "feat: [feature] - implements [todo]

   Addresses review items:
   - Issue #1: [if applicable]
   - Issue #2: [if applicable]

   Refs: /specs/reviews/pending/{{feature-name}}.md"
   ```

## Step 5: Update Specs
- Document any deviations from original spec
- Add implementation notes
- Update decision log if architecture changed

## Step 6: Quality Check
- Run full test suite
- Check TypeScript types
- Run linter
- Verify security best practices

## Step 7: Prepare Commit
- Generate commit message following template
- List all changed files
- Reference spec document
