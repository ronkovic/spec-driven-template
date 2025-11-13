---
description: Initialize a new project with comprehensive specifications
args:
  - name: project-name
    description: Name of the project (e.g., enterprise-ai-platform)
---

Initialize a new project by creating comprehensive project specifications.

## IMPORTANT: Output Language
**All output, documentation, and communication with the user must be in Japanese (日本語).**
Only technical identifiers (variable names, function names, etc.) should remain in English.

## Task

Create comprehensive project specifications for the new project through interactive dialogue with the user.

### Step 1: Project Discovery

Ask the user about the following aspects:

#### 1.1 Project Basics
- Project name and overview
- Project purpose and vision
- Target users
- Expected use cases

#### 1.2 Technical Context
- Technology stack to be used
- Architecture principles
- Performance requirements
- Security requirements

#### 1.3 Project Scope
- MVP (Minimum Viable Product) definition
- Implementation phase breakdown
- High-priority features
- Future expansion plans

#### 1.4 Constraints
- Budget and time constraints
- Technical constraints
- Resource constraints
- External dependencies

#### 1.5 Success Criteria
- Business metrics
- Technical metrics
- User satisfaction metrics
- Performance metrics

### Step 2: Document Creation

**IMPORTANT**: Use the template files in `/specs/templates/` as the foundation for all documents.

Based on the gathered information, create the following documents by filling in the templates:

1. **Project Overview** (`/docs/PROJECT_OVERVIEW.md`)
   - **Template**: `/specs/templates/project_overview.template.md`
   - Fill in: Project basic information, vision/mission, stakeholders, project plan
   - Keep all template sections, replace placeholders with actual content

2. **Technical Architecture** (`/docs/TECHNICAL_ARCHITECTURE.md`)
   - **Template**: `/specs/templates/project_technical_architecture.template.md`
   - Fill in: System architecture, technology stack, data model overview, infrastructure
   - Keep all template sections, replace placeholders with actual content

3. **Development Standards** (`/docs/DEVELOPMENT_STANDARDS.md`)
   - **Template**: `/specs/templates/project_development_standards.template.md`
   - Fill in: Coding conventions, testing strategy, CI/CD pipeline, code review process
   - Keep all template sections, replace placeholders with actual content

4. **Phase Plan** (`/docs/PHASE_PLAN.md`)
   - **Template**: `/specs/templates/project_phase_plan.template.md`
   - Fill in: Phase-by-phase implementation plan, deliverables, milestones, dependencies
   - Keep all template sections, replace placeholders with actual content

5. **Project README** (`/README.md`)
   - **Template**: `/specs/templates/project_readme.template.md`
   - Fill in: Project overview, main features, implementation status, roadmap
   - Keep all template sections, replace placeholders with actual content

### Step 3: Directory Structure

Create the standard directory structure:

```
docs/
├── PROJECT_OVERVIEW.md
├── TECHNICAL_ARCHITECTURE.md
├── DEVELOPMENT_STANDARDS.md
└── PHASE_PLAN.md

specs/
├── requirements/         # 機能別要件定義
├── technical/           # 機能別技術仕様
├── implementation/      # 機能別実装ガイド
└── decisions/           # Architecture Decision Records (ADR)
```

Note: Project-level specs go in `docs/`, feature-level specs go in `specs/`

### Step 4: Initial Feature Planning (初期機能計画)

For each MVP feature identified, create placeholder files:
- `/specs/requirements/[feature-name].md`
- Document feature name and brief description
- Mark as "To be detailed"

### Step 5: Summary

Output a summary showing:
- ✅ Created documents
- 📋 MVP features identified
- 🎯 Next steps
- 📝 Recommended workflow

## Expected Output

After completion, provide:
1. List of created specification documents
2. Project directory structure
3. Identified MVP features
4. Suggested next command (e.g., `/add-requirements [first-feature]`)

## Notes

- Be thorough in asking questions - don't assume
- Ensure all documents follow consistent formatting
- Use markdown tables and diagrams where appropriate
- Keep user engaged throughout the process
- Validate that MVP scope is realistic
