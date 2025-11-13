---
description: Create requirements specification document for a new feature
args:
  - name: feature-name
    description: Name of the feature (e.g., report-comments)
---

Create a requirements specification document for the specified feature.

## IMPORTANT: Output Language
**All output, documentation, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Execution Steps

### 1. Gather Requirements from User
Ask the following questions to clarify feature requirements:

**Required Information**:
- Who is this feature for? (Target users)
- What does this feature aim to achieve? (Purpose)
- What operations should be available? (Feature list)
- Which roles can access this feature? (Permissions)

**Recommended Information**:
- What data is needed? (Data requirements)
- Are there performance requirements? (Non-functional requirements)
- What security considerations are important? (Security requirements)
- How does this relate to existing features? (Dependencies)

### 2. Create Requirements Document

**File Path**: `/specs/requirements/{{feature-name}}.md`

**IMPORTANT**: Use the template file `/specs/templates/feature_requirements.template.md` as the foundation for this document.

**Instructions**:
- Read and use the template from `/specs/templates/feature_requirements.template.md`
- Keep all template sections and structure
- Replace placeholders with actual feature-specific content
- Maintain all section headers from the template
- Fill in all required fields, user stories, and tables

**Required Sections** (write content in Japanese):

```markdown
# [Feature Name] - Requirements

## Overview
Explain the purpose and value of the feature in 2-3 sentences.

## Business Context
- Business background
- Why this feature is needed
- Expected benefits

## User Stories

### US-1: [Story Name]
**As a** [role]
**I want to** [what they want to do]
**So that** [purpose/value]

**Acceptance Criteria:**
- [ ] Acceptance criterion 1
- [ ] Acceptance criterion 2
- [ ] Acceptance criterion 3

### US-2: [Story Name]
...

## Role Definitions
For each role (ADMIN, HR, MANAGER, TEAM_LEAD, EMPLOYEE, PROMPT_ENGINEER):
- What they can do with this feature
- Access scope limitations

## Security Requirements
- Authentication/Authorization requirements
- Data protection requirements
- Audit log requirements

## Non-Functional Requirements
- Performance targets
- Scalability requirements
- Availability requirements
- Usability requirements

## Business Rules
- BR-1: [Rule Name] - Details
- BR-2: [Rule Name] - Details

## Dependencies
### Internal Dependencies
- Dependencies on existing features
- Affected components

### External Dependencies
- External services
- Libraries

## Success Metrics
- Adoption metrics
- Performance metrics
- User satisfaction metrics

## Out of Scope (Not in MVP)
- Features planned for future
- Features not implemented at this time
```

### 3. Document Review Points

After creation, verify the following:

- [ ] All user stories have acceptance criteria
- [ ] Permissions are clearly defined for each role
- [ ] Security requirements are concrete
- [ ] Business rules are documented
- [ ] Dependencies are identified
- [ ] Success metrics are measurable
- [ ] Written in Japanese (English section names allowed)

### 4. Next Steps

After document creation, inform the user:

```
✅ Requirements specification document created: /specs/requirements/{{feature-name}}.md

Next steps:
/spec-check {{feature-name}}

Please review the requirements content and make any necessary corrections.
```

## Tips

### Handling Common Questions
- **"How detailed should I be?"** → Be concrete enough that implementers won't be confused. Avoid ambiguous expressions.
- **"Should I include technical details?"** → Focus on "what" in requirements. "How to implement" goes in technical specs.
- **"Should I include changes to existing features?"** → Yes. Document as dependencies under Dependencies section.

### Time Estimates
- Small feature: 30min - 1 hour
- Medium feature: 1 - 2 hours
- Large feature: 2 - 4 hours

## Important Notes

1. **User stories must follow "As a / I want to / So that" format**
2. **Acceptance criteria must be verifiable** (not "easy to use" but "complete within 3 clicks")
3. **Always define role-based access control**
4. **Verify consistency with existing system** (especially auth/authz, data models)
5. **Write in Japanese** (section headers may be in English)
