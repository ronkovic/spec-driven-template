# [feature-name] - Implementation Guide

## ドキュメント情報

- **バージョン**: 1.0
- **最終更新日**: [YYYY-MM-DD]
- **作成者**: [名前]
- **レビュー状態**: Draft / In Review / Approved
- **関連ドキュメント**:
  - Requirements: `/specs/requirements/[feature-name].md`
  - Technical: `/specs/technical/[feature-name].md`

---

## 概要

この実装ガイドでは、[feature-name] 機能を段階的に実装するための詳細な手順を提供します。

**推定実装時間**: [X] 時間

---

## Prerequisites (前提条件)

### 必要な知識
- [ ] TypeScript の基礎
- [ ] React / Next.js の基礎
- [ ] Prisma ORM の基礎
- [ ] REST API の基礎

### 必要なツール
- [ ] Node.js (v18+)
- [ ] npm / yarn / pnpm
- [ ] PostgreSQL
- [ ] Redis (optional)

### 完了している必要がある機能
- [ ] [依存機能1]
- [ ] [依存機能2]

### 環境変数
```bash
DATABASE_URL="postgresql://..."
[OTHER_ENV_VAR]="..."
```

---

## Implementation Phases (実装フェーズ)

```
Phase 1: Database & Data Models (1-2 hours)
   ↓
Phase 2: Business Logic & API Layer (2-3 hours)
   ↓
Phase 3: Frontend Components (2-3 hours)
   ↓
Phase 4: Testing & Documentation (1-2 hours)
```

---

## Phase 1: Database & Data Models

**推定時間**: 1-2 hours

### Step 1.1: Prisma Schema Update

**File**: `prisma/schema.prisma`

**Task**: Add [ModelName] model

```prisma
model [ModelName] {
  id        String   @id @default(cuid())
  [field1]  String
  [field2]  Int
  [field3]  DateTime @default(now())
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  // Relations
  [relatedModel] [RelatedModel] @relation(fields: [field], references: [id], onDelete: Cascade)

  // Indexes
  @@index([field1])
  @@index([field2])

  // Table mapping
  @@map("[table_name]")
}
```

**Why**: [理由の説明]

**Verification**:
```bash
npx prisma format
npx prisma validate
```

### Step 1.2: Update Related Models

**File**: `prisma/schema.prisma`

**Task**: Add relation to existing models

```prisma
model [ExistingModel] {
  // ... existing fields

  // Add this relation
  [newRelation] [ModelName][]
}
```

### Step 1.3: Create Migration

```bash
npx prisma migrate dev --name add_[model_name]
```

**Expected Output**:
```
Migration created: 20251113_add_[model_name]
Prisma Client generated
```

**Verification**:
```bash
npx prisma studio
# Verify new table exists
```

### Step 1.4: Generate Prisma Client

```bash
npx prisma generate
```

**Verification**:
```typescript
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();
// Type checking should show new model
```

---

## Phase 2: Business Logic & API Layer

**推定時間**: 2-3 hours

### Step 2.1: Create Zod Schemas

**File**: `src/lib/schemas/[feature].schema.ts`

```typescript
import { z } from 'zod';

/**
 * Schema for creating [resource]
 */
export const create[Resource]Schema = z.object({
  [field1]: z.string().min(1, '[Field1] is required').max(255),
  [field2]: z.number().int().positive('[Field2] must be positive'),
  [field3]: z.string().email('Invalid email format'),
});

/**
 * Schema for updating [resource]
 */
export const update[Resource]Schema = create[Resource]Schema.partial();

/**
 * Schema for filtering [resource]
 */
export const [resource]FilterSchema = z.object({
  [field1]: z.string().optional(),
  [field2]: z.number().optional(),
});

// Type exports
export type Create[Resource]Input = z.infer<typeof create[Resource]Schema>;
export type Update[Resource]Input = z.infer<typeof update[Resource]Schema>;
export type [Resource]Filter = z.infer<typeof [resource]FilterSchema>;
```

**Why**: 型安全な入力検証を実現

**Verification**:
```typescript
// Should compile without errors
import { create[Resource]Schema } from '@/lib/schemas/[feature].schema';
```

### Step 2.2: Create Service Class

**File**: `src/services/[feature].service.ts`

```typescript
import { PrismaClient } from '@prisma/client';
import type { Create[Resource]Input, Update[Resource]Input } from '@/lib/schemas/[feature].schema';

const prisma = new PrismaClient();

export class [Feature]Service {
  /**
   * Create a new [resource]
   * @param data - [Resource] data
   * @param userId - User ID who creates the [resource]
   * @returns Created [resource]
   * @throws {ValidationError} If data is invalid
   * @throws {AuthorizationError} If user lacks permission
   */
  async create(data: Create[Resource]Input, userId: string) {
    // 1. Authorization check
    await this.checkPermission(userId, 'create');

    // 2. Business logic validation
    await this.validateBusinessRules(data);

    // 3. Create [resource]
    const [resource] = await prisma.[modelName].create({
      data: {
        ...data,
        userId,
      },
    });

    return [resource];
  }

  /**
   * Find [resource] by ID
   * @param id - [Resource] ID
   * @param userId - User ID requesting the [resource]
   * @returns [Resource] or null
   */
  async findById(id: string, userId: string) {
    const [resource] = await prisma.[modelName].findUnique({
      where: { id },
      include: {
        // Include related data
        [relation]: true,
      },
    });

    if (![resource]) {
      throw new NotFoundError('[Resource] not found');
    }

    // Authorization check
    await this.checkAccess(userId, [resource]);

    return [resource];
  }

  /**
   * Find all [resources] with filters
   * @param filter - Filter criteria
   * @param userId - User ID
   * @returns Array of [resources]
   */
  async findAll(filter: [Resource]Filter, userId: string) {
    const where: any = {};

    // Apply filters
    if (filter.[field1]) {
      where.[field1] = { contains: filter.[field1] };
    }

    // Apply authorization filter
    where.userId = userId; // or more complex logic

    const [resources] = await prisma.[modelName].findMany({
      where,
      orderBy: { createdAt: 'desc' },
      take: 20, // Pagination
    });

    return [resources];
  }

  /**
   * Update [resource]
   * @param id - [Resource] ID
   * @param data - Update data
   * @param userId - User ID
   * @returns Updated [resource]
   */
  async update(id: string, data: Update[Resource]Input, userId: string) {
    // 1. Check exists
    const existing = await this.findById(id, userId);

    // 2. Authorization check
    await this.checkAccess(userId, existing);

    // 3. Update
    const updated = await prisma.[modelName].update({
      where: { id },
      data,
    });

    return updated;
  }

  /**
   * Delete [resource]
   * @param id - [Resource] ID
   * @param userId - User ID
   */
  async delete(id: string, userId: string) {
    // 1. Check exists
    const existing = await this.findById(id, userId);

    // 2. Authorization check
    await this.checkAccess(userId, existing);

    // 3. Delete
    await prisma.[modelName].delete({
      where: { id },
    });
  }

  /**
   * Check if user has permission
   * @param userId - User ID
   * @param action - Action to perform
   */
  private async checkPermission(userId: string, action: string) {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { role: true },
    });

    if (!user) {
      throw new UnauthorizedError('User not found');
    }

    // Permission logic
    const permissions = {
      ADMIN: ['create', 'read', 'update', 'delete'],
      USER: ['create', 'read', 'update'],
    };

    if (!permissions[user.role]?.includes(action)) {
      throw new ForbiddenError('Permission denied');
    }
  }

  /**
   * Check if user can access [resource]
   * @param userId - User ID
   * @param [resource] - [Resource] to access
   */
  private async checkAccess(userId: string, [resource]: any) {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { role: true },
    });

    if (user?.role === 'ADMIN') {
      return; // Admin can access all
    }

    if ([resource].userId !== userId) {
      throw new ForbiddenError('Access denied');
    }
  }

  /**
   * Validate business rules
   * @param data - Data to validate
   */
  private async validateBusinessRules(data: Create[Resource]Input) {
    // Business rule 1: [説明]
    if ([condition]) {
      throw new BusinessRuleError('[Error message]');
    }

    // Business rule 2: [説明]
    // ...
  }
}
```

**Why**: ビジネスロジックを Service 層に集約

**Verification**:
```bash
# Type check
npx tsc --noEmit
```

### Step 2.3: Create Error Classes

**File**: `src/lib/errors/[feature].error.ts`

```typescript
export class [Feature]Error extends Error {
  constructor(
    public code: string,
    public message: string,
    public statusCode: number = 500
  ) {
    super(message);
    this.name = '[Feature]Error';
  }
}

export class ValidationError extends [Feature]Error {
  constructor(message: string) {
    super('VALIDATION_ERROR', message, 400);
  }
}

export class UnauthorizedError extends [Feature]Error {
  constructor(message: string = 'Unauthorized') {
    super('UNAUTHORIZED', message, 401);
  }
}

export class ForbiddenError extends [Feature]Error {
  constructor(message: string = 'Forbidden') {
    super('FORBIDDEN', message, 403);
  }
}

export class NotFoundError extends [Feature]Error {
  constructor(message: string = 'Not found') {
    super('NOT_FOUND', message, 404);
  }
}

export class BusinessRuleError extends [Feature]Error {
  constructor(message: string) {
    super('BUSINESS_RULE_ERROR', message, 422);
  }
}
```

### Step 2.4: Create API Routes

#### POST /api/[resource]

**File**: `src/app/api/[resource]/route.ts`

```typescript
import { NextRequest, NextResponse } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { [Feature]Service } from '@/services/[feature].service';
import { create[Resource]Schema } from '@/lib/schemas/[feature].schema';
import { [Feature]Error } from '@/lib/errors/[feature].error';
import { z } from 'zod';

const service = new [Feature]Service();

/**
 * POST /api/[resource]
 * Create a new [resource]
 */
export async function POST(request: NextRequest) {
  try {
    // 1. Authentication
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // 2. Parse and validate input
    const body = await request.json();
    const data = create[Resource]Schema.parse(body);

    // 3. Create [resource]
    const [resource] = await service.create(data, session.user.id);

    // 4. Return response
    return NextResponse.json(
      {
        data: [resource],
        meta: {
          requestId: crypto.randomUUID(),
          timestamp: new Date().toISOString(),
        },
      },
      { status: 201 }
    );
  } catch (error) {
    return handleError(error);
  }
}

/**
 * GET /api/[resource]
 * Get all [resources]
 */
export async function GET(request: NextRequest) {
  try {
    // 1. Authentication
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // 2. Parse query parameters
    const { searchParams } = new URL(request.url);
    const filter = {
      [field1]: searchParams.get('[field1]') || undefined,
    };

    // 3. Get [resources]
    const [resources] = await service.findAll(filter, session.user.id);

    // 4. Return response
    return NextResponse.json({
      data: [resources],
      meta: {
        requestId: crypto.randomUUID(),
        timestamp: new Date().toISOString(),
      },
    });
  } catch (error) {
    return handleError(error);
  }
}

/**
 * Error handler
 */
function handleError(error: unknown) {
  console.error('API Error:', error);

  if (error instanceof z.ZodError) {
    return NextResponse.json(
      {
        error: 'Validation error',
        details: error.errors,
      },
      { status: 400 }
    );
  }

  if (error instanceof [Feature]Error) {
    return NextResponse.json(
      { error: error.message },
      { status: error.statusCode }
    );
  }

  return NextResponse.json(
    { error: 'Internal server error' },
    { status: 500 }
  );
}
```

#### GET/PUT/DELETE /api/[resource]/[id]

**File**: `src/app/api/[resource]/[id]/route.ts`

```typescript
import { NextRequest, NextResponse } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { [Feature]Service } from '@/services/[feature].service';
import { update[Resource]Schema } from '@/lib/schemas/[feature].schema';

const service = new [Feature]Service();

/**
 * GET /api/[resource]/:id
 */
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const [resource] = await service.findById(params.id, session.user.id);

    return NextResponse.json({ data: [resource] });
  } catch (error) {
    return handleError(error);
  }
}

/**
 * PUT /api/[resource]/:id
 */
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

    const updated = await service.update(params.id, data, session.user.id);

    return NextResponse.json({ data: updated });
  } catch (error) {
    return handleError(error);
  }
}

/**
 * DELETE /api/[resource]/:id
 */
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

    return new NextResponse(null, { status: 204 });
  } catch (error) {
    return handleError(error);
  }
}
```

**Verification**:
```bash
# Start dev server
npm run dev

# Test with curl
curl -X POST http://localhost:3000/api/[resource] \
  -H "Content-Type: application/json" \
  -d '{"[field1]": "value"}'
```

---

## Phase 3: Frontend Components

**推定時間**: 2-3 hours

### Step 3.1: Create Custom Hook

**File**: `src/hooks/use[Feature].ts`

```typescript
import { useState, useEffect } from 'react';
import type { [Resource] } from '@prisma/client';

export function use[Feature]List() {
  const [data, setData] = useState<[Resource][]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    async function fetchData() {
      try {
        setIsLoading(true);
        const res = await fetch('/api/[resource]');
        if (!res.ok) throw new Error('Failed to fetch');
        const json = await res.json();
        setData(json.data);
      } catch (err) {
        setError(err as Error);
      } finally {
        setIsLoading(false);
      }
    }

    fetchData();
  }, []);

  return { data, isLoading, error };
}

export function use[Feature]Create() {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  async function create(data: any) {
    try {
      setIsLoading(true);
      setError(null);

      const res = await fetch('/api/[resource]', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });

      if (!res.ok) {
        const error = await res.json();
        throw new Error(error.error || 'Failed to create');
      }

      const json = await res.json();
      return json.data;
    } catch (err) {
      setError(err as Error);
      throw err;
    } finally {
      setIsLoading(false);
    }
  }

  return { create, isLoading, error };
}
```

### Step 3.2: Create List Component

**File**: `src/components/[Feature]/[Resource]List.tsx`

```typescript
'use client';

import { use[Feature]List } from '@/hooks/use[Feature]';
import { [Resource]Item } from './[Resource]Item';

export function [Resource]List() {
  const { data, isLoading, error } = use[Feature]List();

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  if (data.length === 0) {
    return <div>No [resources] found</div>;
  }

  return (
    <div className="space-y-4">
      {data.map(([resource]) => (
        <[Resource]Item key={[resource].id} [resource]={[resource]} />
      ))}
    </div>
  );
}
```

### Step 3.3: Create Item Component

**File**: `src/components/[Feature]/[Resource]Item.tsx`

```typescript
'use client';

import type { [Resource] } from '@prisma/client';

interface [Resource]ItemProps {
  [resource]: [Resource];
}

export function [Resource]Item({ [resource] }: [Resource]ItemProps) {
  return (
    <div className="border rounded-lg p-4">
      <h3 className="text-lg font-semibold">{[resource].[field1]}</h3>
      <p className="text-gray-600">{[resource].[field2]}</p>
      <time className="text-sm text-gray-500">
        {new Date([resource].createdAt).toLocaleDateString()}
      </time>
    </div>
  );
}
```

### Step 3.4: Create Form Component

**File**: `src/components/[Feature]/[Resource]Form.tsx`

```typescript
'use client';

import { useState } from 'react';
import { use[Feature]Create } from '@/hooks/use[Feature]';

interface [Resource]FormProps {
  onSuccess?: () => void;
}

export function [Resource]Form({ onSuccess }: [Resource]FormProps) {
  const [formData, setFormData] = useState({
    [field1]: '',
    [field2]: 0,
  });

  const { create, isLoading, error } = use[Feature]Create();

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();

    try {
      await create(formData);
      setFormData({ [field1]: '', [field2]: 0 }); // Reset form
      onSuccess?.();
    } catch (err) {
      // Error handled by hook
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div>
        <label htmlFor="[field1]" className="block text-sm font-medium">
          [Field1 Label]
        </label>
        <input
          id="[field1]"
          type="text"
          value={formData.[field1]}
          onChange={(e) => setFormData({ ...formData, [field1]: e.target.value })}
          required
          className="mt-1 block w-full rounded-md border-gray-300"
        />
      </div>

      <div>
        <label htmlFor="[field2]" className="block text-sm font-medium">
          [Field2 Label]
        </label>
        <input
          id="[field2]"
          type="number"
          value={formData.[field2]}
          onChange={(e) => setFormData({ ...formData, [field2]: Number(e.target.value) })}
          required
          className="mt-1 block w-full rounded-md border-gray-300"
        />
      </div>

      {error && (
        <div className="text-red-600 text-sm">{error.message}</div>
      )}

      <button
        type="submit"
        disabled={isLoading}
        className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 disabled:opacity-50"
      >
        {isLoading ? 'Creating...' : 'Create [Resource]'}
      </button>
    </form>
  );
}
```

**Verification**:
```bash
# Check component renders
npm run dev
# Navigate to page using components
```

---

## Phase 4: Testing & Documentation

**推定時間**: 1-2 hours

### Step 4.1: Service Unit Tests

**File**: `src/services/[feature].service.test.ts`

```typescript
import { describe, it, expect, beforeEach } from '@jest/globals';
import { [Feature]Service } from './[feature].service';
import { prisma } from '@/lib/prisma';

describe('[Feature]Service', () => {
  let service: [Feature]Service;

  beforeEach(async () => {
    service = new [Feature]Service();
    // Clean test data
    await prisma.[modelName].deleteMany();
  });

  describe('create', () => {
    it('should create [resource] with valid data', async () => {
      const input = {
        [field1]: 'test',
        [field2]: 123,
      };

      const result = await service.create(input, 'user-id');

      expect(result).toMatchObject(input);
      expect(result.id).toBeDefined();
    });

    it('should throw error when unauthorized', async () => {
      await expect(
        service.create({}, 'invalid-user')
      ).rejects.toThrow('Unauthorized');
    });
  });

  describe('findById', () => {
    it('should find [resource] by id', async () => {
      // Setup
      const created = await service.create({...}, 'user-id');

      // Test
      const found = await service.findById(created.id, 'user-id');

      expect(found).toMatchObject(created);
    });

    it('should throw error when not found', async () => {
      await expect(
        service.findById('non-existent', 'user-id')
      ).rejects.toThrow('not found');
    });
  });
});
```

**Run tests**:
```bash
npm run test src/services/[feature].service.test.ts
```

### Step 4.2: API Integration Tests

**File**: `src/app/api/[resource]/route.test.ts`

```typescript
import { describe, it, expect } from '@jest/globals';
import { POST, GET } from './route';
import { NextRequest } from 'next/server';

describe('POST /api/[resource]', () => {
  it('should create [resource] with valid data', async () => {
    const request = new NextRequest('http://localhost:3000/api/[resource]', {
      method: 'POST',
      body: JSON.stringify({
        [field1]: 'test',
        [field2]: 123,
      }),
    });

    const response = await POST(request);
    const data = await response.json();

    expect(response.status).toBe(201);
    expect(data.data).toMatchObject({
      [field1]: 'test',
      [field2]: 123,
    });
  });

  it('should return 400 for invalid data', async () => {
    const request = new NextRequest('http://localhost:3000/api/[resource]', {
      method: 'POST',
      body: JSON.stringify({
        // Invalid data
      }),
    });

    const response = await POST(request);

    expect(response.status).toBe(400);
  });
});
```

### Step 4.3: Component Tests

**File**: `src/components/[Feature]/[Resource]List.test.tsx`

```typescript
import { describe, it, expect } from '@jest/globals';
import { render, screen } from '@testing-library/react';
import { [Resource]List } from './[Resource]List';

describe('[Resource]List', () => {
  it('should render loading state', () => {
    render(<[Resource]List />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });

  it('should render [resources]', async () => {
    // Mock fetch
    global.fetch = jest.fn(() =>
      Promise.resolve({
        ok: true,
        json: () => Promise.resolve({
          data: [
            { id: '1', [field1]: 'Test' },
          ],
        }),
      })
    );

    render(<[Resource]List />);

    const item = await screen.findByText('Test');
    expect(item).toBeInTheDocument();
  });
});
```

**Run all tests**:
```bash
npm run test
```

### Step 4.4: E2E Tests

**File**: `tests/e2e/[feature].spec.ts`

```typescript
import { test, expect } from '@playwright/test';

test('user can create and view [resource]', async ({ page }) => {
  // Login
  await page.goto('/login');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'password');
  await page.click('[type="submit"]');

  // Navigate to [feature] page
  await page.goto('/[feature]');

  // Create [resource]
  await page.fill('[name="[field1]"]', 'Test [Resource]');
  await page.fill('[name="[field2]"]', '123');
  await page.click('button[type="submit"]');

  // Verify creation
  await expect(page.locator('text=Test [Resource]')).toBeVisible();
});
```

**Run E2E tests**:
```bash
npm run test:e2e
```

---

## Deployment Checklist (デプロイチェックリスト)

### Before Deployment
- [ ] すべてのテストが通過
- [ ] TypeScript 型チェック完了
- [ ] ESLint エラーなし
- [ ] 環境変数が設定されている
- [ ] データベースマイグレーション準備完了

### Deployment Steps
```bash
# 1. Run migration
npx prisma migrate deploy

# 2. Generate Prisma Client
npx prisma generate

# 3. Build application
npm run build

# 4. Deploy
npm run deploy
```

### After Deployment
- [ ] Smoke test 実行
- [ ] ログ確認
- [ ] モニタリング確認
- [ ] ユーザー通知（必要に応じて）

---

## Troubleshooting (トラブルシューティング)

### 問題: Prisma migration が失敗する

**症状**:
```
Error: Migration failed
```

**解決策**:
1. データベース接続を確認
2. 既存データとの競合を確認
3. マイグレーションファイルを手動で修正

### 問題: API が 500 エラーを返す

**症状**:
```
Internal server error
```

**解決策**:
1. ログを確認
2. データベース接続を確認
3. 認証トークンを確認

### 問題: コンポーネントが表示されない

**症状**:
コンポーネントが画面に表示されない

**解決策**:
1. ブラウザコンソールを確認
2. API レスポンスを確認
3. React DevTools で状態を確認

---

## Performance Optimization (パフォーマンス最適化)

### Database
- [ ] 適切なインデックスを追加
- [ ] N+1 クエリを回避
- [ ] 必要なフィールドのみ取得

### API
- [ ] レスポンスをキャッシュ
- [ ] ページネーションを実装
- [ ] レート制限を設定

### Frontend
- [ ] コード分割を実装
- [ ] 画像を最適化
- [ ] useMemo/useCallback を活用

---

## Monitoring & Logging (モニタリング・ログ)

### What to Monitor
- API レスポンスタイム
- エラー率
- データベースクエリ時間
- メモリ使用量

### Logging
```typescript
logger.info('[Feature].[method]', {
  userId,
  action: '[action]',
  duration: '[ms]',
});
```

---

## Next Steps (次のステップ)

実装完了後：

1. **スペック更新**:
   ```bash
   /update-specs [feature-name]
   ```

2. **コミット**:
   ```bash
   /commit-prep
   ```

3. **レビュー依頼**:
   - PR作成
   - レビュアーアサイン

4. **デプロイ**:
   - Staging環境
   - 本番環境

---

## Appendix (付録)

### Useful Commands

```bash
# Development
npm run dev

# Testing
npm run test
npm run test:watch
npm run test:coverage
npm run test:e2e

# Type checking
npm run type-check

# Linting
npm run lint
npm run lint:fix

# Formatting
npm run format

# Database
npx prisma studio
npx prisma migrate dev
npx prisma generate
```

### References
- [Prisma Documentation](https://www.prisma.io/docs)
- [Next.js Documentation](https://nextjs.org/docs)
- [Zod Documentation](https://zod.dev)

---

## 変更履歴

| バージョン | 日付 | 変更内容 | 変更者 |
|-----------|------|---------|--------|
| 1.0 | [日付] | 初版作成 | [名前] |
