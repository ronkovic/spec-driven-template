---
description: Update specification documents with implementation details and decisions
args:
  - name: feature-name
    description: Name of the feature to update specs for
---

Update specification documents to reflect actual implementation details, decisions made during development, and any deviations from original specs.

## IMPORTANT: Output Language
**All output, documentation, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Prerequisites
- Implementation should be complete
- All quality gates should pass
- Run `/check-implementation` or "Please check implementation status" first

## Execution Steps

### 1. Analyze Implementation

Review implemented code to understand:

#### 1.1. Files Created/Modified
```bash
# Check git status
git status

# Show detailed changes
git diff --stat
git diff
```

Categorize files:
- Database models and migrations
- Business logic (services, repositories)
- API endpoints or Server Actions
- Frontend components
- Tests
- Configuration changes

#### 1.2. Implementation Decisions
Identify:
- **Architecture decisions**: Patterns used, libraries chosen
- **Design changes**: Deviations from original spec
- **Additional features**: Features added during implementation
- **Performance optimizations**: Caching, indexing, pagination
- **Security enhancements**: Additional validation, permission checks

#### 1.3. Known Issues
Document:
- Limitations
- Technical debt
- Future improvements needed
- Breaking changes

### 2. Update Implementation Guide

**File**: `/specs/implementation/[feature-name].md`

Add the following section at the end:

```markdown
---

## Implementation Completion Info

### Implementation Details
- **Implementation Date**: 2025-11-13
- **Implementer**: Claude Code + User
- **Implementation Time**: 6.5 hours (estimated: 7 hours)
- **Test Coverage**: 87%

### Files

#### Created Files
- src/lib/feature-name/repository.ts - Data access layer
- src/lib/feature-name/service.ts - Business logic layer
- src/lib/feature-name/validation.ts - Zod schemas
- src/app/[tenantId]/feature-name/page.tsx - List page (Server Component)
- src/app/[tenantId]/feature-name/_components/FeatureList.tsx - List component (Client)
- src/app/[tenantId]/feature-name/_components/FeatureForm.tsx - Form component (Client)
- src/app/[tenantId]/feature-name/_actions/feature-actions.ts - Server Actions
- tests/lib/feature-name/service.test.ts - Unit tests
- tests/app/[tenantId]/feature-name/actions.test.ts - Integration tests

#### Modified Files
- prisma/schema.prisma - Added FeatureModel
- prisma/migrations/YYYYMMDD_add_feature_model/migration.sql - Migration

### Implementation Decisions

#### Decision 1: [Decision Title]
**Changes Made**: Description of implemented changes

**Reason**: Why this decision was made

**Impact**:
- System impact
- Performance impact
- Security impact

**Alternatives**: Other options considered

**Record**: Recorded as ADR-XXX (if necessary)

#### Decision 2: Performance Optimization
**Changes Made**: Implemented pagination

**Reason**: Performance concerns when fetching large datasets

**Impact**:
- Added `page`, `limit` parameters to API
- Default: 20 items/page
- Max: 100 items/page

**Trade-off**: Prioritized performance over simplicity

### Additional Features Implemented

#### Additional Feature 1: [Feature Name]
**Description**: Explanation of added feature

**Reason**: User request / Discovered necessity during implementation

**Scope**: Include in MVP / Defer to Phase 2

### Known Issues

#### Issue 1: [Issue Title]
**Symptom**: Issue description

**Impact Area**: Where it affects

**Workaround**: Temporary solution

**Permanent Fix**: Future response plan

### Test Results

#### Coverage
- **Overall**: 87% (target: 80%)
- **Repository layer**: 95%
- **Service layer**: 90%
- **API layer**: 85%
- **Component layer**: 80%

#### Test Breakdown
- **Unit tests**: 8 tests, all passing
- **Integration tests**: 7 tests, all passing
- **E2E tests**: 3 tests, all passing

### Performance Metrics

#### API Response Time
- GET /api/[tenant]/feature: avg 45ms
- POST /api/[tenant]/feature: avg 120ms
- PUT /api/[tenant]/feature/:id: avg 85ms
- DELETE /api/[tenant]/feature/:id: avg 60ms

#### Database Queries
- Average query time: 15ms
- N+1 problem: None (all resolved with include)
- Index utilization: 100%

### Security Check

✅ Authentication check implemented
✅ Authorization check implemented
✅ Input validation implemented
✅ SQL injection protection (using Prisma)
✅ XSS protection implemented
✅ CSRF protection implemented
✅ Audit log implemented

### Deployment Readiness

✅ Environment variables defined
✅ Migration ready
✅ Rollback procedure confirmed
✅ Monitoring configured
✅ Error logging configured

### Next Phase

#### Planned for Phase 2
- [ ] Implement Feature A
- [ ] Performance improvement B
- [ ] UI/UX improvement C

#### Technical Debt
- [ ] Component commonization
- [ ] Unified error handling
- [ ] Improve test coverage (target: 90%)

### References
- [ADR-XXX: Architecture Decision Record](link)
- [Implementation Discussion](link)
- [Performance Analysis](link)
```

### 3. Update Technical Specification (if needed)

**File**: `/specs/technical/[feature-name].md`

If there were significant changes to the technical design, update relevant sections:

#### 3.1. Data Models
If schema changed:
```markdown
## Data Models (Updated)

**Note**: The following changes were made to the schema during implementation:
- Added `mentions` field (JSON type): For user mention feature
- Added index to `status`: For performance improvement
```

#### 3.2. API Specification
If API changed:
```markdown
## API Specification (Updated)

### GET /api/[tenantId]/comments
**Changes**: Added pagination parameters

**Query Parameters**:
- `page` (number, optional): Page number (default: 1)
- `limit` (number, optional): Items per page (default: 20, max: 100)

**Response**:
```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "totalPages": 8
  }
}
```
```

#### 3.3. Error Codes
If new error codes added:
```markdown
## Error Codes (Updated)

**Added Error Codes**:
- `COMMENT_MENTION_INVALID`: Invalid mention format
- `COMMENT_TOO_LONG`: Comment too long (max 1000 chars)
```

### 4. Update Architecture Decision Records (if needed)

If significant architectural decisions were made during implementation, create ADR:

**File**: `/docs/adr/ADR-XXX-[decision-title].md`

```markdown
# ADR-XXX: [Decision Title]

## Status
Accepted

## Context
During implementation, [problem/situation] occurred.

## Decision
We decided to adopt [decision content].

## Consequences

### Positive
- Benefit 1
- Benefit 2

### Negative
- Drawback 1
- Drawback 2

### Neutral
- Impact 1

## Alternatives Considered
- Alternative 1: [Rejected because]
- Alternative 2: [Rejected because]

## Implementation Notes
- Implementation details
- Notes and caveats

## Related
- Related ADRs
- Related Issues/PRs
```

### 5. Update Project README.md

**File**: `/README.md` (project root)

Update the project README following feature implementation completion.

#### 5.1. Update Main Features Section

Add newly implemented features to the "Main Features" section:

```markdown
### Main Features

- 📝 **[Existing Feature 1]** - [Description]
- 📊 **[Existing Feature 2]** - [Description]
+ - 💬 **[New Feature Name]** - [One-line description]
```

**Example**:
```markdown
- 💬 **Report Comment Feature** - Post comments, reply, mention users
```

#### 5.2. Update Implementation Status Table

Update "Main Features Implementation Status" table:

```markdown
## 📊 Main Features Implementation Status

| Feature | Status | Phase | Notes |
|---------|--------|-------|-------|
| [Existing Feature 1] | ✅ Complete | Phase 1 | [Notes] |
- | [New Feature] | 🚧 In Progress | Phase X | [Notes] |
+ | [New Feature] | ✅ Complete | Phase X | [Additional info from implementation] |
```

**Status Symbols**:
- `✅ Complete` - Implementation done, tests pass, ready for production
- `🚧 In Progress` - Currently implementing
- `📋 Planned` - Not yet started

**Example**:
```markdown
| Report Comments | ✅ Complete | Phase 1 | Includes mention feature & pagination |
```

#### 5.3. Update Roadmap (if applicable)

Update Phase checklists:

```markdown
### Phase 1: MVP (Target: 2025-04)
- [x] Multi-tenant foundation
- [x] Basic role management
- [x] Daily reflection agent
+ - [x] Report comment feature
- [ ] Weekly report generation agent
```

#### 5.4. Update Last Modified Date

Update last modified date at end of document to today's date:

```markdown
---

**Created**: 2025-01-15
- **Last Updated**: 2025-01-20
+ **Last Updated**: 2025-11-13
**Version**: 1.0.0
**Status**: In Development
```

#### 5.5. Update Decision Criteria

Update README in the following cases:

**Must update**:
- ✅ User-facing feature implemented
- ✅ Major Phase milestone achieved
- ✅ System architecture major changes

**No update needed**:
- ❌ Internal refactoring only
- ❌ Bug fixes only (minor)
- ❌ Test additions only

#### 5.6. Update Example (Complete)

Before implementation:
```markdown
### Main Features

- 📝 **Daily Reflection** - Reflect on your day with AI
- 📊 **Auto Report Generation** - Auto-create weekly/monthly reports

## 📊 Main Features Implementation Status

| Feature | Status | Phase | Notes |
|---------|--------|-------|-------|
| Daily Reflection | ✅ Complete | Phase 1 | - |
| Report Comments | 🚧 In Progress | Phase 1 | - |
```

After implementation:
```markdown
### Main Features

- 📝 **Daily Reflection** - Reflect on your day with AI
- 📊 **Auto Report Generation** - Auto-create weekly/monthly reports
- 💬 **Comment Feature** - Post comments, reply, mention users

## 📊 Main Features Implementation Status

| Feature | Status | Phase | Notes |
|---------|--------|-------|-------|
| Daily Reflection | ✅ Complete | Phase 1 | - |
| Report Comments | ✅ Complete | Phase 1 | Includes mention & pagination |
```

### 6. Update Feature Documentation (if needed)

If user-facing features were added, update feature documentation:

**File**: `/docs/features/[feature-name].md` or relevant docs

```markdown
# [Feature Name] User Guide

## Overview
Description of this feature

## How to Use

### Basic Operations
1. Step 1
2. Step 2

### Advanced Usage
- Feature A
- Feature B

## Notes and Precautions
- Note 1
- Note 2
```

### 7. Verify Consistency

After updates, verify:

```bash
# Run spec-check to verify consistency
/spec-check [feature-name]
```

Check:
- Requirements ↔ Technical Spec consistency
- Technical Spec ↔ Implementation Guide consistency
- README.md ↔ Implementation status consistency
- All decisions documented
- No contradictions between specs

### 8. Generate Update Summary

Create a summary of what was updated:

```markdown
=== Spec Update Complete ===

## Updated Files

### Implementation Guide
✅ /specs/implementation/[feature-name].md
   - Added implementation completion info section
   - Listed files
   - Recorded implementation decisions
   - Listed test results
   - Listed performance metrics

### Technical Specification (if needed)
✅ /specs/technical/[feature-name].md
   - Reflected data model changes
   - Updated API specification
   - Added error codes

### Project README
✅ /README.md
   - Added [feature name] to main features section
   - Updated implementation status table (🚧 In Progress → ✅ Complete)
   - Updated roadmap (if applicable)
   - Updated last modified date

### ADR (if needed)
✅ /docs/adr/ADR-XXX-[decision-title].md
   - Created new

## Recorded Content

### Implementation Details
- Implementation date/time
- Implementation time
- Test coverage: 87%

### File Changes
- Created: 9 files
- Modified: 2 files

### Decisions Made
- Decision 1: [Title]
- Decision 2: Performance optimization

### Additional Features
- Mention feature
- Pagination

### Known Issues
- Issue 1: [Title]

### README Update Details
- Added "[feature name]" to main features
- Status: 🚧 In Progress → ✅ Complete
- Notes: [Additional info]

## Next Steps
Implementation and spec updates are complete. Prepare for commit:

/commit-prep

or

"Please prepare commit"
```

## Tips

### What to Document

**Always document**:
- Implementation completion details
- Files created/modified
- Test results and coverage
- Performance metrics

**Document if significant**:
- Architecture decisions (ADR)
- Design changes from original spec
- Additional features added
- Known issues or limitations
- Breaking changes

**Document if user-facing**:
- New features
- API changes
- Configuration changes
- Migration guides

### Writing Style

- **Be factual**: Document what was actually done
- **Be specific**: Include numbers, dates, file names
- **Be honest**: Document problems and tradeoffs
- **Be forward-looking**: Note future improvements needed

### Common Updates

1. **Added pagination**: Document API changes, performance impact
2. **Added validation**: Document new error codes, validation rules
3. **Performance optimization**: Document metrics, optimization techniques
4. **Security enhancement**: Document security measures added
5. **UI/UX improvement**: Document user-facing changes

### Time Estimates
- Simple updates: 15-30 minutes
- Complex updates with ADR: 30-60 minutes

## Important Notes

1. **Update immediately after implementation** - Don't wait
2. **Document deviations** - Especially important for future reference
3. **Be thorough** - Future developers will thank you
4. **Run spec-check** - Verify consistency after updates
5. **Write in Japanese** - All user-facing text in Japanese
6. **Include metrics** - Coverage, performance, response times
7. **Document tradeoffs** - Why decisions were made
