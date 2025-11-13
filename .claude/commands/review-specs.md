---
description: Comprehensive review of project specification documents
args:
  - name: scope
    description: "Scope of review: 'project' (all project specs) or feature name (e.g., 'multi-tenant-auth')"
---

Conduct a comprehensive review of specification documents to ensure consistency, completeness, and quality.

## IMPORTANT: Output Language
**All output, review comments, and communication with the user must be in Japanese (日本語).**
Only technical identifiers (variable names, function names, etc.) should remain in English.

## Task

Perform a thorough review of specification documents based on the specified scope.

### Scope Types

#### 1. Project Scope (`scope = "project"`)
Review project-level specifications:
- `/specs/PROJECT_OVERVIEW.md`
- `/specs/TECHNICAL_ARCHITECTURE.md`
- `/specs/DEVELOPMENT_STANDARDS.md`
- `/specs/PHASE_PLAN.md`

#### 2. Feature Scope (`scope = [feature-name]`)
Review feature-specific specifications:
- `/specs/requirements/[feature-name].md`
- `/specs/technical/[feature-name].md`
- `/specs/implementation/[feature-name].md`

---

## Review Checklist

### For Project-Level Specs

#### PROJECT_OVERVIEW.md Review

**1. Completeness Check**
- [ ] Executive summary is clear
- [ ] Vision and mission are specific
- [ ] Business goals are quantitative
- [ ] Stakeholders are comprehensive
- [ ] MVP features are clearly defined
- [ ] Phase plan is realistic
- [ ] Success criteria are measurable
- [ ] Risks are identified
- [ ] Budget is appropriately planned

**2. Quality Check**
- [ ] No ambiguous expressions
- [ ] No contradictions
- [ ] Has specific numerical targets
- [ ] Priorities are clear
- [ ] Scope is achievable

**3. Consistency Check**
- [ ] Aligned with TECHNICAL_ARCHITECTURE
- [ ] Aligned with PHASE_PLAN
- [ ] Business goals and MVP features are aligned

#### TECHNICAL_ARCHITECTURE.md Review

**1. Completeness Check**
- [ ] System architecture diagram exists
- [ ] Technology stack is fully defined
- [ ] Data models are clear
- [ ] Security measures are comprehensive
- [ ] Performance goals are quantitative
- [ ] API design conventions are clear
- [ ] Monitoring and logging strategy is specific
- [ ] Deployment plan is detailed

**2. Quality Check**
- [ ] Technology selection rationale is documented
- [ ] Architecture patterns are appropriate
- [ ] Scalability is considered
- [ ] Failure countermeasures are specific
- [ ] Security best practices are followed

**3. Consistency Check**
- [ ] Aligned with PROJECT_OVERVIEW technical requirements
- [ ] Aligned with DEVELOPMENT_STANDARDS
- [ ] Aligned with PHASE_PLAN technical implementation

#### DEVELOPMENT_STANDARDS.md Review

**1. Completeness Check**
- [ ] Coding conventions are specific
- [ ] Directory structure is clear
- [ ] Test strategy is comprehensive
- [ ] Git workflow is detailed
- [ ] Quality gates are defined
- [ ] Security guidelines are comprehensive
- [ ] CI/CD pipeline is specific

**2. Quality Check**
- [ ] Conventions are actionable
- [ ] Good/Bad examples are provided
- [ ] Concrete code examples exist
- [ ] Tool configurations are included
- [ ] Team-wide consensus is achievable

**3. Consistency Check**
- [ ] Aligned with TECHNICAL_ARCHITECTURE technology stack
- [ ] Conventions are appropriate for project scale

#### PHASE_PLAN.md Review

**1. Completeness Check**
- [ ] All phases are defined
- [ ] Goals for each phase are clear
- [ ] Feature list is comprehensive
- [ ] Priorities are set
- [ ] Effort estimates exist
- [ ] Dependencies are clear
- [ ] Resource plan is specific
- [ ] Budget allocation is appropriate

**2. Quality Check**
- [ ] Schedule is realistic
- [ ] Effort estimates are appropriate
- [ ] Risks are identified
- [ ] Milestones are specific
- [ ] Success metrics are measurable

**3. Consistency Check**
- [ ] Aligned with PROJECT_OVERVIEW MVP definition
- [ ] Aligned with TECHNICAL_ARCHITECTURE implementation
- [ ] Resources and budget are aligned

---

### For Feature-Level Specs

#### requirements/[feature-name].md Review

**1. Completeness Check**
- [ ] Overview is clear
- [ ] User Stories are specific
- [ ] Acceptance Criteria are measurable
- [ ] Role Definitions are clear
- [ ] Business Context is understandable
- [ ] Security Requirements are comprehensive
- [ ] Non-Functional Requirements are quantitative

**2. Quality Check**
- [ ] Written from user perspective
- [ ] Acceptance criteria are clear
- [ ] Business value is explicit
- [ ] No ambiguous expressions

**3. Consistency Check**
- [ ] Aligned with PROJECT_OVERVIEW scope
- [ ] Aligned with PHASE_PLAN feature list
- [ ] Dependencies with other features are clear

#### technical/[feature-name].md Review

**1. Completeness Check**
- [ ] Architecture Overview is clear
- [ ] Data Models (Prisma schema) are complete
- [ ] API Specification is detailed
- [ ] Frontend Architecture is specific
- [ ] Security Design is comprehensive
- [ ] Performance Considerations are quantitative
- [ ] Testing Strategy is comprehensive
- [ ] Error Handling is clear

**2. Quality Check**
- [ ] Technical feasibility is verified
- [ ] Performance is considered
- [ ] Security is considered
- [ ] Testability is considered
- [ ] Extensibility is considered

**3. Consistency Check**
- [ ] Aligned with Requirements
- [ ] Aligned with TECHNICAL_ARCHITECTURE
- [ ] Aligned with DEVELOPMENT_STANDARDS
- [ ] Data models are aligned with overall system

#### implementation/[feature-name].md Review

**1. Completeness Check**
- [ ] Prerequisites are clear
- [ ] Implementation Steps are detailed
- [ ] Phase-specific implementation procedures are concrete
- [ ] Coding Standards are documented
- [ ] Testing Strategy is comprehensive
- [ ] Deployment Checklist is comprehensive

**2. Quality Check**
- [ ] Steps are implementable
- [ ] Steps have appropriate granularity
- [ ] Verification methods are clear
- [ ] Troubleshooting is included
- [ ] Complete code examples are provided

**3. Consistency Check**
- [ ] Aligned with Requirements
- [ ] Aligned with Technical Spec
- [ ] Aligned with DEVELOPMENT_STANDARDS
- [ ] Aligned with PHASE_PLAN schedule

---

## Review Process

### Step 1: Document Reading

Read all relevant specification documents based on the scope.

### Step 2: Checklist Verification

Go through each checklist item systematically and mark:
- ✅ Pass: Requirement is met
- ⚠️ Warning: Room for improvement
- ❌ Fail: Requirement is not met
- ➖ N/A: Not applicable

### Step 3: Issue Identification

Identify and categorize issues:

**Critical** - Must fix before implementation:
- Ambiguous scope
- Technical infeasibility
- Security risks
- Major contradictions

**Important** - May cause issues during implementation:
- Incomplete specifications
- Performance concerns
- Lack of test strategy
- Minor contradictions

**Minor** - Improvements for quality:
- Document clarity
- Add examples
- Format improvements

### Step 4: Recommendations

For each issue, provide:
1. **Issue**: What is the problem
2. **Impact**: What impact it has
3. **Recommended Action**: How to fix it
4. **Priority**: Critical / Important / Minor
5. **Owner**: Who should handle it

### Step 5: Summary Report

Generate a comprehensive review report:

```markdown
# Specification Review Report

## Overview
- **Review Scope**: [Project / Feature Name]
- **Review Date**: [Date]
- **Reviewer**: Claude Code
- **Status**: ✅ Ready / ⚠️ Needs Improvement / ❌ Needs Major Revision

## Scores
| Category | Score | Details |
|----------|-------|---------|
| Completeness | [%] | [Comment] |
| Quality | [%] | [Comment] |
| Consistency | [%] | [Comment] |
| **Overall** | **[%]** | **[Rating]** |

## Issue Summary
- 🔴 Critical: [Count] items
- 🟡 Important: [Count] items
- 🟢 Minor: [Count] items

## Critical Issues
[Detailed list]

## Important Issues
[Detailed list]

## Minor Issues
[Detailed list]

## Recommended Next Steps
1. [Action 1]
2. [Action 2]

## Approval Decision
- [ ] Approved - Ready to start implementation
- [ ] Conditionally approved - Can start after minor fixes
- [ ] Not approved - Major fixes required
```

---

## Output Format

Provide the review in the following structure:

### 1. Executive Summary
- Overall assessment
- Key issues
- Recommended actions

### 2. Detailed Review Results
- Checklist results
- Issue details
- Specific improvement suggestions

### 3. Scorecard
- Completeness score
- Quality score
- Consistency score
- Overall rating

### 4. Action Items
- Prioritized task list
- Owner assignment recommendations
- Deadline suggestions

### 5. Next Steps
- Implementation readiness
- Required fixes
- Recommended next command

---

## Example Usage

### Project-level review
```bash
/review-specs project
```

### Feature-level review
```bash
/review-specs multi-tenant-auth
```

---

## Notes

- Be thorough but constructive
- Focus on actionable feedback
- Prioritize issues by impact
- Suggest specific improvements
- Consider project context and constraints
- Engage in dialogue if clarification is needed
