# API Endpoint Creation Skill

This skill handles creating REST API endpoints in Next.js with proper validation, error handling, and testing.

## IMPORTANT: Output Language
**All output, code comments, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers may be in English.

## Prerequisites
- Next.js 15 with App Router
- Zod for validation
- Prisma for database access
- NextAuth for authentication

## Steps

### 1. Define API Route Structure
Determine the route path:
```
src/app/api/[resource]/route.ts           - Collection (GET, POST)
src/app/api/[resource]/[id]/route.ts      - Item (GET, PUT, DELETE)
```

### 2. Create Input/Output Schemas (Zod)
Create schemas in `src/lib/schemas/[resource].schema.ts`:

```typescript
import { z } from 'zod';

// Input schemas
export const create[Resource]Schema = z.object({
  name: z.string().min(1).max(255),
  description: z.string().optional(),
  organizationId: z.string().cuid(),
});

export const update[Resource]Schema = create[Resource]Schema.partial();

export const [resource]QuerySchema = z.object({
  page: z.coerce.number().int().positive().default(1),
  limit: z.coerce.number().int().positive().max(100).default(20),
  organizationId: z.string().cuid().optional(),
});

// Output schemas
export const [resource]ResponseSchema = z.object({
  id: z.string(),
  name: z.string(),
  description: z.string().nullable(),
  organizationId: z.string(),
  createdAt: z.date(),
  updatedAt: z.date(),
});

// TypeScript types
export type Create[Resource]Input = z.infer<typeof create[Resource]Schema>;
export type Update[Resource]Input = z.infer<typeof update[Resource]Schema>;
export type [Resource]Response = z.infer<typeof [resource]ResponseSchema>;
```

### 3. Create Service Layer
Create service in `src/services/[resource].service.ts`:

```typescript
import { prisma } from '@/lib/prisma';
import type { Create[Resource]Input, Update[Resource]Input } from '@/lib/schemas/[resource].schema';

export class [Resource]Service {
  async create(data: Create[Resource]Input, userId: string) {
    // Check permissions
    await this.checkOrganizationAccess(userId, data.organizationId);

    return prisma.[resource].create({
      data: {
        ...data,
        createdById: userId,
      },
    });
  }

  async findMany(organizationId: string, userId: string, page = 1, limit = 20) {
    await this.checkOrganizationAccess(userId, organizationId);

    const skip = (page - 1) * limit;

    const [items, total] = await Promise.all([
      prisma.[resource].findMany({
        where: { organizationId },
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      prisma.[resource].count({
        where: { organizationId },
      }),
    ]);

    return {
      items,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string, userId: string) {
    const item = await prisma.[resource].findUnique({
      where: { id },
    });

    if (!item) {
      throw new Error('[Resource] not found');
    }

    await this.checkOrganizationAccess(userId, item.organizationId);

    return item;
  }

  async update(id: string, data: Update[Resource]Input, userId: string) {
    const existing = await this.findById(id, userId);

    return prisma.[resource].update({
      where: { id },
      data,
    });
  }

  async delete(id: string, userId: string) {
    await this.findById(id, userId); // Check access

    return prisma.[resource].delete({
      where: { id },
    });
  }

  private async checkOrganizationAccess(userId: string, organizationId: string) {
    const membership = await prisma.organizationMembership.findFirst({
      where: {
        userId,
        organizationId,
      },
    });

    if (!membership) {
      throw new Error('Access denied');
    }
  }
}
```

### 4. Create API Route Handler
Create route in `src/app/api/[resource]/route.ts`:

```typescript
import { NextRequest, NextResponse } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { [Resource]Service } from '@/services/[resource].service';
import { create[Resource]Schema, [resource]QuerySchema } from '@/lib/schemas/[resource].schema';
import { ZodError } from 'zod';

const service = new [Resource]Service();

// GET /api/[resource]
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { searchParams } = new URL(request.url);
    const query = [resource]QuerySchema.parse({
      page: searchParams.get('page'),
      limit: searchParams.get('limit'),
      organizationId: searchParams.get('organizationId'),
    });

    const result = await service.findMany(
      query.organizationId!,
      session.user.id,
      query.page,
      query.limit
    );

    return NextResponse.json(result);
  } catch (error) {
    return handleError(error);
  }
}

// POST /api/[resource]
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body = await request.json();
    const data = create[Resource]Schema.parse(body);

    const item = await service.create(data, session.user.id);

    return NextResponse.json(item, { status: 201 });
  } catch (error) {
    return handleError(error);
  }
}

function handleError(error: unknown) {
  if (error instanceof ZodError) {
    return NextResponse.json(
      { error: 'Validation error', details: error.errors },
      { status: 400 }
    );
  }

  if (error instanceof Error) {
    if (error.message.includes('not found')) {
      return NextResponse.json({ error: error.message }, { status: 404 });
    }
    if (error.message.includes('Access denied')) {
      return NextResponse.json({ error: error.message }, { status: 403 });
    }
  }

  console.error('API Error:', error);
  return NextResponse.json(
    { error: 'Internal server error' },
    { status: 500 }
  );
}
```

### 5. Create Item Route
Create route in `src/app/api/[resource]/[id]/route.ts`:

```typescript
import { NextRequest, NextResponse } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { [Resource]Service } from '@/services/[resource].service';
import { update[Resource]Schema } from '@/lib/schemas/[resource].schema';

const service = new [Resource]Service();

// GET /api/[resource]/[id]
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const item = await service.findById(params.id, session.user.id);
    return NextResponse.json(item);
  } catch (error) {
    return handleError(error);
  }
}

// PUT /api/[resource]/[id]
export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body = await request.json();
    const data = update[Resource]Schema.parse(body);

    const item = await service.update(params.id, data, session.user.id);
    return NextResponse.json(item);
  } catch (error) {
    return handleError(error);
  }
}

// DELETE /api/[resource]/[id]
export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    await service.delete(params.id, session.user.id);
    return NextResponse.json({ success: true }, { status: 204 });
  } catch (error) {
    return handleError(error);
  }
}

function handleError(error: unknown) {
  // Same as collection route
}
```

### 6. Create Tests
Create test file `src/app/api/[resource]/route.test.ts`:

```typescript
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { GET, POST } from './route';
import { NextRequest } from 'next/server';

vi.mock('next-auth', () => ({
  getServerSession: vi.fn(),
}));

describe('API: /api/[resource]', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('GET', () => {
    it('should return 401 if not authenticated', async () => {
      const { getServerSession } = await import('next-auth');
      (getServerSession as any).mockResolvedValue(null);

      const request = new NextRequest(
        new URL('http://localhost/api/[resource]')
      );
      const response = await GET(request);

      expect(response.status).toBe(401);
    });

    it('should return items for authenticated user', async () => {
      const { getServerSession } = await import('next-auth');
      (getServerSession as any).mockResolvedValue({
        user: { id: 'user-1' },
      });

      // Mock service
      // Add test implementation
    });
  });

  describe('POST', () => {
    it('should create resource with valid data', async () => {
      // Add test implementation
    });

    it('should return 400 with invalid data', async () => {
      // Add test implementation
    });
  });
});
```

### 7. Add API Documentation
Update `/docs/API.md`:

```markdown
## [Resource] API

### Create [Resource]
```
POST /api/[resource]
```

**Request Body:**
```json
{
  "name": "string",
  "description": "string (optional)",
  "organizationId": "string"
}
```

**Response:** `201 Created`
```json
{
  "id": "string",
  "name": "string",
  "description": "string | null",
  "organizationId": "string",
  "createdAt": "ISO8601 datetime",
  "updatedAt": "ISO8601 datetime"
}
```

### List [Resources]
```
GET /api/[resource]?organizationId={id}&page={num}&limit={num}
```

**Response:** `200 OK`
```json
{
  "items": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "totalPages": 5
  }
}
```
```

### 8. Test Endpoint
```bash
# Start dev server
npm run dev

# Test with curl
curl -X POST http://localhost:3000/api/[resource] \
  -H "Content-Type: application/json" \
  -d '{"name": "Test", "organizationId": "org-123"}'

# Or use API testing tool (Postman, Insomnia, etc.)
```

## Checklist
- [ ] Zod schemas created
- [ ] Service layer implemented
- [ ] Route handlers created
- [ ] Error handling added
- [ ] Authentication checked
- [ ] Authorization implemented
- [ ] Tests written
- [ ] API documentation updated
- [ ] Endpoint tested manually
