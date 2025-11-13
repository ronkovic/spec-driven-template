---
description: Create implementation guide document for a new feature
args:
  - name: feature-name
    description: Name of the feature (e.g., report-comments)
---

Create an implementation guide document for the specified feature.

## IMPORTANT: Output Language
**All output, documentation, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## Prerequisites
Before running this command:
- Requirements document must exist at `/specs/requirements/{{feature-name}}.md`
- Technical specification must exist at `/specs/technical/{{feature-name}}.md`
- Run `/spec-check {{feature-name}}` to verify both documents are complete and consistent

## Execution Steps

### 1. Review Existing Documentation
Read and understand:
- Requirements document: User stories, acceptance criteria, business rules
- Technical specification: Architecture, data models, API design, security

### 2. Create Implementation Guide Document

**File Path**: `/specs/implementation/{{feature-name}}.md`

**IMPORTANT**: Use the template file `/specs/templates/feature_implementation.template.md` as the foundation for this document.

**Instructions**:
- Read and use the template from `/specs/templates/feature_implementation.template.md`
- Keep all template sections and structure
- Replace placeholders with actual feature-specific content
- Maintain all section headers from the template
- Fill in all required fields, code examples, and checklists

**Required Sections** (write content in Japanese):

```markdown
# [Feature Name] - Implementation Guide

## 概要 (Overview)
Brief summary of what will be implemented and the implementation approach.

## Prerequisites

### Required Tools
- Node.js 20+
- PostgreSQL 16+
- pnpm 9+
- AWS CLI (if AWS services are used)

### Environment Setup
```bash
# Clone repository
git clone <repository-url>
cd a2a-demo

# Install dependencies
pnpm install

# Setup environment variables
cp .env.example .env.local

# Start database
docker-compose up -d postgres

# Run migrations
pnpm prisma migrate dev

# Start dev server
pnpm dev
```

### Environment Variables
```bash
# Database
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/a2a_demo"

# Authentication
COGNITO_USER_POOL_ID=""
COGNITO_CLIENT_ID=""
SESSION_SECRET=""

# Feature-specific variables
EXAMPLE_API_KEY=""
```

## Project Structure
```
src/
├── app/
│   └── [tenantId]/
│       └── feature-name/           # Feature pages
│           ├── page.tsx
│           ├── [id]/page.tsx
│           ├── _components/         # Feature components
│           └── _actions/            # Server actions
├── lib/
│   ├── prisma.ts                   # Prisma client
│   ├── auth/                       # Auth utilities
│   └── feature-name/               # Feature business logic
│       ├── service.ts
│       ├── repository.ts
│       └── validation.ts
├── types/
│   └── feature-name.ts             # TypeScript types
└── prisma/
    ├── schema.prisma
    └── migrations/
```

## Implementation Phases

### Phase 1: Database & Data Models (Week 1)

#### 1.1. Update Prisma Schema
**File**: `prisma/schema.prisma`

```prisma
// Add new models
model Example {
  id             String   @id @default(cuid())
  organizationId String
  name           String
  description    String?
  status         String   @default("draft")
  createdById    String
  createdAt      DateTime @default(now())
  updatedAt      DateTime @updatedAt
  deletedAt      DateTime?

  // Relations
  organization Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)
  createdBy    User         @relation("ExampleCreatedBy", fields: [createdById], references: [id])

  // Indexes
  @@index([organizationId])
  @@index([status])
  @@index([createdById])
  @@map("examples")
}
```

#### 1.2. Create Migration
```bash
pnpm prisma migrate dev --name add-feature-name-models
```

#### 1.3. Create Repository Layer
**File**: `src/lib/feature-name/repository.ts`

```typescript
import { prisma } from '@/lib/prisma';
import type { Prisma } from '@prisma/client';

export class ExampleRepository {
  async findById(id: string, organizationId: string) {
    return await prisma.example.findFirst({
      where: { id, organizationId, deletedAt: null },
      include: { createdBy: { select: { id: true, name: true, email: true } } },
    });
  }

  async findMany(organizationId: string, options?: {
    skip?: number;
    take?: number;
    where?: Prisma.ExampleWhereInput;
    orderBy?: Prisma.ExampleOrderByWithRelationInput;
  }) {
    return await prisma.example.findMany({
      where: {
        organizationId,
        deletedAt: null,
        ...options?.where,
      },
      skip: options?.skip,
      take: options?.take,
      orderBy: options?.orderBy,
      include: { createdBy: { select: { id: true, name: true, email: true } } },
    });
  }

  async create(data: Prisma.ExampleCreateInput) {
    return await prisma.example.create({
      data,
      include: { createdBy: { select: { id: true, name: true, email: true } } },
    });
  }

  async update(id: string, organizationId: string, data: Prisma.ExampleUpdateInput) {
    return await prisma.example.update({
      where: { id, organizationId },
      data,
      include: { createdBy: { select: { id: true, name: true, email: true } } },
    });
  }

  async delete(id: string, organizationId: string) {
    return await prisma.example.update({
      where: { id, organizationId },
      data: { deletedAt: new Date() },
    });
  }
}

export const exampleRepository = new ExampleRepository();
```

#### 1.4. Create Validation Schemas
**File**: `src/lib/feature-name/validation.ts`

```typescript
import { z } from 'zod';

export const createExampleSchema = z.object({
  name: z.string().min(1).max(100),
  description: z.string().max(1000).optional(),
  status: z.enum(['draft', 'active', 'archived']).default('draft'),
});

export const updateExampleSchema = z.object({
  name: z.string().min(1).max(100).optional(),
  description: z.string().max(1000).optional(),
  status: z.enum(['draft', 'active', 'archived']).optional(),
});

export type CreateExampleInput = z.infer<typeof createExampleSchema>;
export type UpdateExampleInput = z.infer<typeof updateExampleSchema>;
```

**Verification**:
```bash
# Test database connection
pnpm prisma studio

# Run type check
pnpm tsc --noEmit

# Run tests
pnpm test src/lib/feature-name/
```

### Phase 2: Business Logic & API Layer (Week 2)

#### 2.1. Create Service Layer
**File**: `src/lib/feature-name/service.ts`

```typescript
import { exampleRepository } from './repository';
import { createExampleSchema, updateExampleSchema } from './validation';
import type { CreateExampleInput, UpdateExampleInput } from './validation';

export class ExampleService {
  async getExample(id: string, organizationId: string, userId: string, roles: string[]) {
    // Authorization check
    if (!roles.some(r => ['ADMIN', 'MANAGER', 'EMPLOYEE'].includes(r))) {
      throw new Error('AUTHZ_FORBIDDEN');
    }

    const example = await exampleRepository.findById(id, organizationId);
    if (!example) {
      throw new Error('EXAMPLE_NOT_FOUND');
    }

    return example;
  }

  async listExamples(
    organizationId: string,
    userId: string,
    roles: string[],
    options?: { skip?: number; take?: number; status?: string }
  ) {
    // Authorization check
    if (!roles.some(r => ['ADMIN', 'MANAGER', 'EMPLOYEE'].includes(r))) {
      throw new Error('AUTHZ_FORBIDDEN');
    }

    const examples = await exampleRepository.findMany(organizationId, {
      skip: options?.skip,
      take: options?.take,
      where: options?.status ? { status: options.status } : undefined,
      orderBy: { createdAt: 'desc' },
    });

    return examples;
  }

  async createExample(
    input: CreateExampleInput,
    organizationId: string,
    userId: string,
    roles: string[]
  ) {
    // Authorization check
    if (!roles.some(r => ['ADMIN', 'MANAGER'].includes(r))) {
      throw new Error('AUTHZ_FORBIDDEN');
    }

    // Validation
    const validated = createExampleSchema.parse(input);

    // Create
    const example = await exampleRepository.create({
      ...validated,
      organization: { connect: { id: organizationId } },
      createdBy: { connect: { id: userId } },
    });

    return example;
  }

  async updateExample(
    id: string,
    input: UpdateExampleInput,
    organizationId: string,
    userId: string,
    roles: string[]
  ) {
    // Authorization check
    if (!roles.some(r => ['ADMIN', 'MANAGER'].includes(r))) {
      throw new Error('AUTHZ_FORBIDDEN');
    }

    // Check existence
    const existing = await exampleRepository.findById(id, organizationId);
    if (!existing) {
      throw new Error('EXAMPLE_NOT_FOUND');
    }

    // Validation
    const validated = updateExampleSchema.parse(input);

    // Update
    const example = await exampleRepository.update(id, organizationId, validated);

    return example;
  }

  async deleteExample(id: string, organizationId: string, userId: string, roles: string[]) {
    // Authorization check
    if (!roles.some(r => ['ADMIN'].includes(r))) {
      throw new Error('AUTHZ_FORBIDDEN');
    }

    // Check existence
    const existing = await exampleRepository.findById(id, organizationId);
    if (!existing) {
      throw new Error('EXAMPLE_NOT_FOUND');
    }

    // Soft delete
    await exampleRepository.delete(id, organizationId);

    return { success: true };
  }
}

export const exampleService = new ExampleService();
```

#### 2.2. Create Server Actions
**File**: `src/app/[tenantId]/feature-name/_actions/example-actions.ts`

```typescript
'use server';

import { revalidatePath } from 'next/cache';
import { exampleService } from '@/lib/feature-name/service';
import { getSession } from '@/lib/auth/session';
import type { CreateExampleInput, UpdateExampleInput } from '@/lib/feature-name/validation';

export async function getExampleAction(id: string, tenantId: string) {
  try {
    const session = await getSession();
    if (!session) {
      return { error: { code: 'AUTH_REQUIRED', message: 'Authentication required' } };
    }

    const example = await exampleService.getExample(
      id,
      session.organizationId,
      session.userId,
      session.roles
    );

    return { data: example };
  } catch (error) {
    if (error instanceof Error) {
      return { error: { code: error.message, message: 'Failed to get example' } };
    }
    return { error: { code: 'INTERNAL_ERROR', message: 'An unexpected error occurred' } };
  }
}

export async function listExamplesAction(
  tenantId: string,
  options?: { skip?: number; take?: number; status?: string }
) {
  try {
    const session = await getSession();
    if (!session) {
      return { error: { code: 'AUTH_REQUIRED', message: 'Authentication required' } };
    }

    const examples = await exampleService.listExamples(
      session.organizationId,
      session.userId,
      session.roles,
      options
    );

    return { data: examples };
  } catch (error) {
    if (error instanceof Error) {
      return { error: { code: error.message, message: 'Failed to list examples' } };
    }
    return { error: { code: 'INTERNAL_ERROR', message: 'An unexpected error occurred' } };
  }
}

export async function createExampleAction(input: CreateExampleInput, tenantId: string) {
  try {
    const session = await getSession();
    if (!session) {
      return { error: { code: 'AUTH_REQUIRED', message: 'Authentication required' } };
    }

    const example = await exampleService.createExample(
      input,
      session.organizationId,
      session.userId,
      session.roles
    );

    revalidatePath(`/${tenantId}/feature-name`);
    return { data: example };
  } catch (error) {
    if (error instanceof Error) {
      return { error: { code: error.message, message: 'Failed to create example' } };
    }
    return { error: { code: 'INTERNAL_ERROR', message: 'An unexpected error occurred' } };
  }
}

export async function updateExampleAction(
  id: string,
  input: UpdateExampleInput,
  tenantId: string
) {
  try {
    const session = await getSession();
    if (!session) {
      return { error: { code: 'AUTH_REQUIRED', message: 'Authentication required' } };
    }

    const example = await exampleService.updateExample(
      id,
      input,
      session.organizationId,
      session.userId,
      session.roles
    );

    revalidatePath(`/${tenantId}/feature-name`);
    revalidatePath(`/${tenantId}/feature-name/${id}`);
    return { data: example };
  } catch (error) {
    if (error instanceof Error) {
      return { error: { code: error.message, message: 'Failed to update example' } };
    }
    return { error: { code: 'INTERNAL_ERROR', message: 'An unexpected error occurred' } };
  }
}

export async function deleteExampleAction(id: string, tenantId: string) {
  try {
    const session = await getSession();
    if (!session) {
      return { error: { code: 'AUTH_REQUIRED', message: 'Authentication required' } };
    }

    await exampleService.deleteExample(id, session.organizationId, session.userId, session.roles);

    revalidatePath(`/${tenantId}/feature-name`);
    return { data: { success: true } };
  } catch (error) {
    if (error instanceof Error) {
      return { error: { code: error.message, message: 'Failed to delete example' } };
    }
    return { error: { code: 'INTERNAL_ERROR', message: 'An unexpected error occurred' } };
  }
}
```

**Verification**:
```bash
# Run tests
pnpm test src/lib/feature-name/service.test.ts
pnpm test src/app/\[tenantId\]/feature-name/_actions/

# Type check
pnpm tsc --noEmit
```

### Phase 3: Frontend Components (Week 3)

#### 3.1. Create List Page (Server Component)
**File**: `src/app/[tenantId]/feature-name/page.tsx`

```typescript
import { Suspense } from 'react';
import { listExamplesAction } from './_actions/example-actions';
import { ExampleList } from './_components/ExampleList';

export default async function ExamplesPage({
  params,
}: {
  params: Promise<{ tenantId: string }>;
}) {
  const { tenantId } = await params;
  const result = await listExamplesAction(tenantId);

  if (result.error) {
    return <div>Error: {result.error.message}</div>;
  }

  return (
    <div className="container mx-auto py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold">Examples</h1>
      </div>

      <Suspense fallback={<div>Loading...</div>}>
        <ExampleList initialData={result.data} tenantId={tenantId} />
      </Suspense>
    </div>
  );
}
```

#### 3.2. Create List Component (Client Component)
**File**: `src/app/[tenantId]/feature-name/_components/ExampleList.tsx`

```typescript
'use client';

import { useState } from 'react';
import Link from 'next/link';
import { ExampleForm } from './ExampleForm';
import { deleteExampleAction } from '../_actions/example-actions';

interface Example {
  id: string;
  name: string;
  description: string | null;
  status: string;
  createdAt: string;
}

interface ExampleListProps {
  initialData: Example[];
  tenantId: string;
}

export function ExampleList({ initialData, tenantId }: ExampleListProps) {
  const [examples, setExamples] = useState<Example[]>(initialData);
  const [isFormOpen, setIsFormOpen] = useState(false);

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this example?')) return;

    const result = await deleteExampleAction(id, tenantId);
    if (result.error) {
      alert(`Error: ${result.error.message}`);
      return;
    }

    setExamples(examples.filter((ex) => ex.id !== id));
  };

  return (
    <div>
      <div className="mb-4">
        <button
          onClick={() => setIsFormOpen(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
        >
          Create New Example
        </button>
      </div>

      {isFormOpen && (
        <ExampleForm
          tenantId={tenantId}
          onClose={() => setIsFormOpen(false)}
          onSuccess={(newExample) => {
            setExamples([newExample, ...examples]);
            setIsFormOpen(false);
          }}
        />
      )}

      <div className="grid gap-4">
        {examples.map((example) => (
          <div key={example.id} className="border rounded-lg p-4">
            <div className="flex justify-between items-start">
              <div>
                <Link
                  href={`/${tenantId}/feature-name/${example.id}`}
                  className="text-xl font-semibold hover:underline"
                >
                  {example.name}
                </Link>
                {example.description && (
                  <p className="text-gray-600 mt-2">{example.description}</p>
                )}
                <p className="text-sm text-gray-500 mt-2">Status: {example.status}</p>
              </div>
              <button
                onClick={() => handleDelete(example.id)}
                className="px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700"
              >
                Delete
              </button>
            </div>
          </div>
        ))}

        {examples.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            No examples found. Create one to get started!
          </div>
        )}
      </div>
    </div>
  );
}
```

#### 3.3. Create Form Component (Client Component)
**File**: `src/app/[tenantId]/feature-name/_components/ExampleForm.tsx`

```typescript
'use client';

import { useState } from 'react';
import { createExampleAction } from '../_actions/example-actions';
import type { CreateExampleInput } from '@/lib/feature-name/validation';

interface ExampleFormProps {
  tenantId: string;
  onClose: () => void;
  onSuccess: (example: any) => void;
}

export function ExampleForm({ tenantId, onClose, onSuccess }: ExampleFormProps) {
  const [formData, setFormData] = useState<CreateExampleInput>({
    name: '',
    description: '',
    status: 'draft',
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const result = await createExampleAction(formData, tenantId);

    if (result.error) {
      setError(result.error.message);
      setIsSubmitting(false);
      return;
    }

    onSuccess(result.data);
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div className="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 className="text-2xl font-bold mb-4">Create New Example</h2>

        {error && (
          <div className="mb-4 p-3 bg-red-100 text-red-700 rounded">{error}</div>
        )}

        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label className="block text-sm font-medium mb-1">Name *</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              className="w-full px-3 py-2 border rounded"
              required
            />
          </div>

          <div className="mb-4">
            <label className="block text-sm font-medium mb-1">Description</label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              className="w-full px-3 py-2 border rounded"
              rows={3}
            />
          </div>

          <div className="mb-4">
            <label className="block text-sm font-medium mb-1">Status</label>
            <select
              value={formData.status}
              onChange={(e) => setFormData({ ...formData, status: e.target.value as any })}
              className="w-full px-3 py-2 border rounded"
            >
              <option value="draft">Draft</option>
              <option value="active">Active</option>
              <option value="archived">Archived</option>
            </select>
          </div>

          <div className="flex justify-end gap-2">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 border rounded hover:bg-gray-100"
              disabled={isSubmitting}
            >
              Cancel
            </button>
            <button
              type="submit"
              className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
              disabled={isSubmitting}
            >
              {isSubmitting ? 'Creating...' : 'Create'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
```

**Verification**:
```bash
# Start dev server
pnpm dev

# Test in browser
open http://localhost:3000/[tenantId]/feature-name

# Run component tests
pnpm test src/app/\[tenantId\]/feature-name/_components/
```

### Phase 4: Testing & Documentation (Week 4)

#### 4.1. Write Unit Tests
**File**: `src/lib/feature-name/__tests__/service.test.ts`

```typescript
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { exampleService } from '../service';
import { exampleRepository } from '../repository';

vi.mock('../repository');

describe('ExampleService', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('getExample', () => {
    it('should return example when user has permission', async () => {
      const mockExample = { id: '1', name: 'Test', organizationId: 'org1' };
      vi.mocked(exampleRepository.findById).mockResolvedValue(mockExample as any);

      const result = await exampleService.getExample('1', 'org1', 'user1', ['ADMIN']);

      expect(result).toEqual(mockExample);
      expect(exampleRepository.findById).toHaveBeenCalledWith('1', 'org1');
    });

    it('should throw error when user lacks permission', async () => {
      await expect(
        exampleService.getExample('1', 'org1', 'user1', ['INVALID_ROLE'])
      ).rejects.toThrow('AUTHZ_FORBIDDEN');
    });

    it('should throw error when example not found', async () => {
      vi.mocked(exampleRepository.findById).mockResolvedValue(null);

      await expect(
        exampleService.getExample('1', 'org1', 'user1', ['ADMIN'])
      ).rejects.toThrow('EXAMPLE_NOT_FOUND');
    });
  });

  // Add more test cases...
});
```

#### 4.2. Write Integration Tests
**File**: `src/app/[tenantId]/feature-name/__tests__/actions.test.ts`

```typescript
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { createExampleAction } from '../_actions/example-actions';
import { getSession } from '@/lib/auth/session';
import { exampleService } from '@/lib/feature-name/service';

vi.mock('@/lib/auth/session');
vi.mock('@/lib/feature-name/service');

describe('Example Actions', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('createExampleAction', () => {
    it('should create example when authenticated', async () => {
      const mockSession = { userId: 'user1', organizationId: 'org1', roles: ['ADMIN'] };
      const mockExample = { id: '1', name: 'Test' };

      vi.mocked(getSession).mockResolvedValue(mockSession as any);
      vi.mocked(exampleService.createExample).mockResolvedValue(mockExample as any);

      const result = await createExampleAction(
        { name: 'Test', status: 'draft' },
        'tenant1'
      );

      expect(result.data).toEqual(mockExample);
    });

    it('should return error when not authenticated', async () => {
      vi.mocked(getSession).mockResolvedValue(null);

      const result = await createExampleAction(
        { name: 'Test', status: 'draft' },
        'tenant1'
      );

      expect(result.error?.code).toBe('AUTH_REQUIRED');
    });
  });
});
```

#### 4.3. Write E2E Tests
**File**: `tests/e2e/feature-name.spec.ts`

```typescript
import { test, expect } from '@playwright/test';

test.describe('Example Feature', () => {
  test.beforeEach(async ({ page }) => {
    // Login
    await page.goto('/tenant1/login');
    await page.fill('[name="email"]', 'admin@example.com');
    await page.fill('[name="password"]', 'password');
    await page.click('button[type="submit"]');
    await expect(page).toHaveURL('/tenant1/dashboard');
  });

  test('should create new example', async ({ page }) => {
    await page.goto('/tenant1/feature-name');
    await page.click('text=Create New Example');

    await page.fill('[name="name"]', 'Test Example');
    await page.fill('[name="description"]', 'This is a test');
    await page.selectOption('[name="status"]', 'active');
    await page.click('button[type="submit"]');

    await expect(page.locator('text=Test Example')).toBeVisible();
  });

  test('should delete example', async ({ page }) => {
    await page.goto('/tenant1/feature-name');

    // Assume there's at least one example
    await page.click('button:text("Delete")').first();

    // Confirm dialog
    page.on('dialog', dialog => dialog.accept());

    await expect(page.locator('text=Example deleted successfully')).toBeVisible();
  });
});
```

**Verification**:
```bash
# Run all tests
pnpm test

# Run E2E tests
pnpm test:e2e

# Generate coverage report
pnpm test:coverage
```

## Coding Standards

### TypeScript
- Use strict type checking
- Avoid `any` type
- Define interfaces for all data structures
- Use type guards for runtime type checking

### React Components
- Prefer Server Components by default
- Use Client Components only when needed
- Keep components focused and small
- Use proper TypeScript props interfaces

### Error Handling
- Use try-catch blocks in all async operations
- Return structured error responses
- Never expose sensitive information in errors
- Log errors appropriately

### Database
- Always use transactions for multi-step operations
- Use proper indexes for query performance
- Implement soft deletes for important data
- Use Prisma middleware for tenant isolation

## Testing Strategy

### Unit Tests (Target: 80% coverage)
- All business logic functions
- Validation schemas
- Utility functions

### Integration Tests (Target: 70% coverage)
- Server Actions
- API routes
- Service layer with database

### E2E Tests (Critical paths only)
- Main user flows
- Permission boundaries
- Error scenarios

## Deployment Checklist

### Pre-deployment
- [ ] All tests passing
- [ ] Type check passing
- [ ] Lint check passing
- [ ] Build succeeds
- [ ] Environment variables documented
- [ ] Database migrations tested
- [ ] Security review completed

### Deployment Steps
```bash
# 1. Run database migrations
pnpm prisma migrate deploy

# 2. Build application
pnpm build

# 3. Deploy to Vercel
vercel --prod

# 4. Verify deployment
curl https://your-domain.com/api/health
```

### Post-deployment
- [ ] Smoke tests in production
- [ ] Monitor error logs
- [ ] Verify performance metrics
- [ ] Check audit logs

## Troubleshooting

### Common Issues

**Issue**: Prisma client out of sync
```bash
# Solution
pnpm prisma generate
```

**Issue**: Authentication errors
```bash
# Check session token
# Verify Cognito configuration
# Check middleware logic
```

**Issue**: Permission denied errors
```bash
# Verify user roles in database
# Check authorization logic in service layer
# Review permission constants
```

## Performance Optimization

### Database Queries
- Use `select` to limit returned fields
- Add indexes for frequently queried fields
- Use pagination for large datasets
- Consider caching for read-heavy operations

### Frontend
- Use Server Components for data fetching
- Implement loading states
- Use React Suspense boundaries
- Optimize images with Next.js Image

## Monitoring & Logging

### Application Logs
- Use structured logging
- Include correlation IDs
- Log all errors with context
- Monitor critical operations

### Performance Metrics
- API response times
- Database query performance
- Frontend rendering metrics
- Error rates

## Next Steps

After implementation:
1. Run `/spec-check {{feature-name}}` to verify completeness
2. Update user documentation
3. Create demo/training materials
4. Plan rollout strategy
5. Monitor production metrics

## References
- [Next.js Documentation](https://nextjs.org/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- Project architecture documentation
```

### 3. Document Review Points

After creation, verify the following:

- [ ] All phases have concrete implementation steps
- [ ] Code examples are complete and functional
- [ ] File paths and structure match project conventions
- [ ] Testing strategy covers unit, integration, and E2E
- [ ] Deployment checklist is comprehensive
- [ ] Troubleshooting section addresses common issues
- [ ] Written in Japanese (English section names allowed)

### 4. Next Steps

After document creation, inform the user:

```
✅ Implementation guide document created: /specs/implementation/{{feature-name}}.md

Next steps:
/spec-check {{feature-name}}

Please review the implementation guide content and make any necessary corrections.
If there are no issues, start implementation:
/implement {{feature-name}}
```

## Tips

### Implementation Strategy
- **Start with data layer** (models, migrations)
- **Build service layer next** (business logic)
- **Then add API/actions** (Server Actions preferred)
- **Finally build UI** (Server Components first)

### Code Quality
- **Write tests first** (TDD approach)
- **Use TypeScript strictly** (no any types)
- **Follow existing patterns** in the codebase
- **Keep components small** and focused

### Common Patterns
- **Repository pattern** for data access
- **Service pattern** for business logic
- **Server Actions** for mutations
- **Server Components** for data fetching

### Time Estimates
- Small feature: 1 - 2 weeks
- Medium feature: 2 - 4 weeks
- Large feature: 1 - 2 months

## Important Notes

1. **Always provide complete, working code examples**
2. **Include all necessary imports and dependencies**
3. **Show both happy path and error handling**
4. **Follow project coding standards**
5. **Include comprehensive testing examples**
6. **Provide troubleshooting guidance**
7. **Write in Japanese** (section headers may be in English)
