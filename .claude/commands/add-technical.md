---
description: Create technical specification document for a new feature
args:
  - name: feature-name
    description: Name of the feature (e.g., report-comments)
---

Create a technical specification document for the specified feature.

## IMPORTANT: Output Language
**All output, documentation, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Prerequisites
Before running this command:
- Requirements document must exist at `/specs/requirements/{{feature-name}}.md`
- Run `/spec-check {{feature-name}}` to verify requirements are complete

## Execution Steps

### 1. Review Requirements Document
Read and understand the requirements document:
- User stories and acceptance criteria
- Security requirements
- Non-functional requirements
- Business rules
- Dependencies

### 2. Clarify Technical Approach
Discuss with the user to determine:

**Architecture Questions**:
- Which layer will this feature be implemented in? (Frontend, Backend, API, DB)
- What existing components/patterns should be reused?
- Are there any new technical components needed?

**Data Questions**:
- What data models are needed?
- How do they relate to existing models?
- What indexes are needed for performance?

**API Questions**:
- What API endpoints are needed?
- Request/response formats?
- Error handling approach?

**Security Questions**:
- How will authentication/authorization work?
- What validation is needed?
- Any specific security patterns to apply?

### 3. Create Technical Specification Document

**File Path**: `/specs/technical/{{feature-name}}.md`

**IMPORTANT**: Use the template file `/specs/templates/feature_technical.template.md` as the foundation for this document.

**Instructions**:
- Read and use the template from `/specs/templates/feature_technical.template.md`
- Keep all template sections and structure
- Replace placeholders with actual feature-specific content
- Maintain all section headers from the template
- Fill in all required fields and tables

**Required Sections** (write content in Japanese):

```markdown
# [Feature Name] - Technical Specification

## 概要 (Overview)
Explain the technical approach and architecture in 2-3 sentences.

## Architecture Overview

### System Architecture
- High-level architecture diagram (text/mermaid)
- Component interactions
- Data flow

### Technology Stack
- Frontend: Next.js 15 App Router, React 19, TypeScript
- Backend: Next.js API Routes, Server Actions
- Database: PostgreSQL + Prisma ORM
- Authentication: AWS Cognito (if applicable)
- Other: List relevant libraries/services

## Data Models

### Prisma Schema
```prisma
model Example {
  id        String   @id @default(cuid())
  name      String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([name])
  @@map("examples")
}
```

### Relationships
Explain relationships between models

### Migration Strategy
- Migration plan
- Data seeding requirements
- Rollback considerations

## API Specification

### Endpoints

#### POST /api/[tenantId]/examples
**Purpose**: Create new example
**Request**:
```typescript
interface CreateExampleRequest {
  name: string;
}
```
**Response**:
```typescript
interface CreateExampleResponse {
  id: string;
  name: string;
  createdAt: string;
}
```
**Errors**:
- 400: VALIDATION_ERROR
- 401: AUTH_REQUIRED
- 403: AUTHZ_FORBIDDEN

#### GET /api/[tenantId]/examples
...

### Server Actions
Document Server Actions if used instead of API routes

### Error Codes
Define all error codes used in this feature:
```typescript
enum ErrorCode {
  EXAMPLE_NOT_FOUND = 'EXAMPLE_NOT_FOUND',
  EXAMPLE_INVALID_STATUS = 'EXAMPLE_INVALID_STATUS',
}
```

## Frontend Architecture

### Component Structure
```
app/[tenantId]/feature-name/
├── page.tsx                    # Server Component (list view)
├── [id]/
│   └── page.tsx               # Server Component (detail view)
├── _components/
│   ├── ExampleList.tsx        # Client Component
│   ├── ExampleForm.tsx        # Client Component
│   └── ExampleCard.tsx        # Server Component
└── _actions/
    └── example-actions.ts     # Server Actions
```

### Component Specifications

#### ExampleList Component
- **Type**: Client Component
- **Props**:
  ```typescript
  interface ExampleListProps {
    initialData: Example[];
    organizationId: string;
  }
  ```
- **State**: List data, loading state, error state
- **Events**: Create, update, delete operations

### State Management
- Server Components: Fetch data directly
- Client Components: Use React hooks (useState, useReducer)
- Form state: React Hook Form
- Global state: Zustand (if needed)

## Security Design

### Authentication & Authorization
- Middleware: Tenant isolation, session validation
- API/Server Actions: Permission checks using role-based access control
- Database: Row-level security via Prisma middleware

### Authorization Rules
```typescript
// Example authorization rules
const permissions = {
  'examples.create': ['ADMIN', 'MANAGER'],
  'examples.read': ['ADMIN', 'MANAGER', 'EMPLOYEE'],
  'examples.update': ['ADMIN', 'MANAGER'],
  'examples.delete': ['ADMIN'],
};
```

### Input Validation
- Request validation using Zod schemas
- Sanitization requirements
- Error messages (no sensitive info)

### Audit Logging
Operations to log:
- Create/Update/Delete actions
- Permission changes
- Access denials

## Performance Considerations

### Database Optimization
- Required indexes
- Query optimization strategies
- Connection pooling

### Caching Strategy
- What data to cache
- Cache invalidation rules
- TTL settings

### Pagination & Filtering
- Default page size
- Maximum page size
- Filterable fields
- Sortable fields

## Testing Strategy

### Unit Tests
- Model validation tests
- Business logic tests
- Utility function tests

### Integration Tests
- API endpoint tests
- Server Action tests
- Database operation tests

### E2E Tests
- Critical user flows
- Permission boundary tests
- Error scenario tests

## Error Handling

### Error Response Format
```typescript
interface ErrorResponse {
  error: {
    code: ErrorCode;
    message: string;
    details?: Record<string, unknown>;
  };
}
```

### Error Handling Patterns
- API/Server Action error handling
- Frontend error display
- Error logging

## Deployment Considerations

### Environment Variables
```bash
# List required environment variables
EXAMPLE_API_KEY=xxx
EXAMPLE_ENDPOINT=https://...
```

### Database Migrations
- Migration execution timing
- Backward compatibility

### Feature Flags (if applicable)
- Feature toggle strategy

## Dependencies

### Internal Dependencies
- Existing components/modules used
- Shared utilities

### External Dependencies
```json
{
  "dependencies": {
    "example-lib": "^1.0.0"
  }
}
```

## Architecture Decision Records (ADR)

### ADR-1: [Decision Title]
**Status**: Accepted
**Context**: Background and problem
**Decision**: What was decided
**Consequences**: Positive and negative impacts

## Open Questions
- List unresolved technical questions
- Areas needing further investigation

## References
- Related RFCs
- External documentation
- Design inspiration
```

### 4. Document Review Points

After creation, verify the following:

- [ ] Requirements are fully covered by technical design
- [ ] Data models have proper indexes and relationships
- [ ] API endpoints follow RESTful conventions
- [ ] Authorization rules are clearly defined
- [ ] Error codes are comprehensive
- [ ] Performance considerations are addressed
- [ ] Testing strategy is complete
- [ ] Written in Japanese (English section names allowed)

### 5. Next Steps

After document creation, inform the user:

```
✅ Technical specification document created: /specs/technical/{{feature-name}}.md

Next steps:
/spec-check {{feature-name}}

Please review the technical specification content and make any necessary corrections.
If there are no issues, proceed to creating the implementation guide.
```

## Tips

### Architecture Decisions
- **Prefer Server Components** for data fetching
- **Use Client Components** only when needed (interactivity, browser APIs)
- **Leverage Server Actions** for mutations when possible
- **Follow existing patterns** in the codebase

### Data Modeling
- **Use cuid()** for primary keys
- **Always include** createdAt, updatedAt timestamps
- **Add organizationId** for multi-tenant data
- **Use soft deletes** (deletedAt) for important data

### API Design
- **Follow RESTful patterns**
- **Use proper HTTP status codes**
- **Version APIs** if needed (/api/v1/...)
- **Document all error cases**

### Time Estimates
- Small feature: 1 - 2 hours
- Medium feature: 2 - 4 hours
- Large feature: 4 - 8 hours

## Important Notes

1. **Always base technical specs on requirements document**
2. **Ensure consistency with existing architecture**
3. **Consider performance and scalability from the start**
4. **Document security considerations thoroughly**
5. **Make error handling comprehensive**
6. **Write in Japanese** (section headers may be in English)
