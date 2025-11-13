---
description: Validate specifications for a feature
args:
  - name: feature-name
    description: Name of the feature to check
---

Validate specifications for a feature to ensure completeness, consistency, and alignment with templates.

## IMPORTANT: Output Language
**All output, analysis results, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Validation Process

### Step 1: Read All Specification Documents

Read the following files:
- `/specs/requirements/{{feature-name}}.md` (Required)
- `/specs/technical/{{feature-name}}.md` (Required if past requirements phase)
- `/specs/implementation/{{feature-name}}.md` (Required if past technical phase)

### Step 2: Validate Requirements Document

**Template Adherence** (`feature_requirements.template.md`):
- [ ] Document metadata section exists (version, date, author, review state)
- [ ] Overview section with purpose and target users
- [ ] Business Context with problem statement and value
- [ ] Success Metrics table with measurable KPIs
- [ ] User Stories with acceptance criteria
- [ ] Role Definitions for all relevant roles
- [ ] Security Requirements section
- [ ] Non-Functional Requirements (performance, scalability)
- [ ] Business Rules
- [ ] Dependencies and constraints
- [ ] Priority and effort estimation

**Content Quality**:
- [ ] All user stories follow "As a... I want... So that..." format
- [ ] Each user story has clear acceptance criteria
- [ ] Success metrics are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- [ ] Security requirements are comprehensive
- [ ] Performance targets are quantified

### Step 3: Validate Technical Specification

**Template Adherence** (`feature_technical.template.md`):
- [ ] Document metadata section
- [ ] Architecture Overview with diagrams
- [ ] Technology Stack clearly defined
- [ ] Data Models with complete Prisma schema
- [ ] Relationships and migration strategy
- [ ] API Specification with all endpoints
- [ ] Request/Response TypeScript interfaces
- [ ] Error codes defined
- [ ] Frontend Architecture with component structure
- [ ] State Management approach
- [ ] Security Design (auth, validation, audit logging)
- [ ] Performance Considerations (indexes, caching, pagination)
- [ ] Testing Strategy (unit, integration, e2e)
- [ ] Error Handling patterns
- [ ] Deployment Considerations
- [ ] Dependencies (internal and external)

**Content Quality**:
- [ ] Data models have proper indexes
- [ ] API follows RESTful conventions
- [ ] All error cases documented
- [ ] Security measures comprehensive
- [ ] Performance targets quantified

### Step 4: Validate Implementation Guide

**Template Adherence** (`feature_implementation.template.md`):
- [ ] Document metadata section
- [ ] Prerequisites and environment setup
- [ ] Project structure overview
- [ ] Step-by-step implementation phases
- [ ] Coding standards and conventions
- [ ] Testing strategy with examples
- [ ] Deployment checklist
- [ ] Rollback procedures
- [ ] Troubleshooting guide

**Content Quality**:
- [ ] Steps are clear and actionable
- [ ] Code examples are complete
- [ ] Test cases are comprehensive
- [ ] Security checks included

### Step 5: Cross-Document Consistency

Validate consistency across all documents:
- [ ] Requirements → Technical: All user stories have technical implementation
- [ ] Technical → Implementation: All technical components have implementation steps
- [ ] Data models match across Technical and Implementation
- [ ] API endpoints consistent across documents
- [ ] Security requirements addressed in all layers
- [ ] Performance targets consistent
- [ ] Dependencies identified in all relevant documents

### Step 6: Dependency Validation

Check for:
- [ ] External library dependencies documented
- [ ] API dependencies identified
- [ ] Database schema dependencies
- [ ] Inter-feature dependencies
- [ ] Blocking issues

### Step 7: Generate Validation Report

Provide a comprehensive report in Japanese:

```markdown
=== Specification Validation Report ===

## Overall Status
✅ Passed / ⚠️ Warnings / ❌ Failed

## Documents Checked
- Requirements: [Status] ([Missing sections])
- Technical: [Status] ([Missing sections])
- Implementation: [Status] ([Missing sections])

## Template Adherence
### Requirements Document
- Missing sections: [List]
- Incomplete sections: [List]

### Technical Specification
- Missing sections: [List]
- Incomplete sections: [List]

### Implementation Guide
- Missing sections: [List]
- Incomplete sections: [List]

## Content Quality Issues
- User stories: [Issues]
- Technical design: [Issues]
- Implementation steps: [Issues]

## Consistency Issues
- Requirements ↔ Technical: [Issues]
- Technical ↔ Implementation: [Issues]
- Data model conflicts: [Issues]

## Recommendations
1. [High priority fixes]
2. [Medium priority improvements]
3. [Low priority enhancements]

## Next Steps
[What needs to be fixed before proceeding]
```
