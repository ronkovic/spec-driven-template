# [feature-name] - Technical Specification

## ドキュメント情報

- **バージョン**: 1.0
- **最終更新日**: [YYYY-MM-DD]
- **作成者**: [Tech Lead名]
- **レビュー状態**: Draft / In Review / Approved
- **関連ドキュメント**:
  - Requirements: `/specs/requirements/[feature-name].md`
  - Implementation: `/specs/implementation/[feature-name].md`

---

## 1. Architecture Overview (アーキテクチャ概要)

### 1.1 High-Level Architecture

```
[アーキテクチャ図]

例:
┌──────────────┐
│  Frontend    │
│ (React/Next) │
└───────┬──────┘
        │ API Call
        ▼
┌──────────────┐
│   Backend    │
│  (Next.js)   │
└───────┬──────┘
        │
        ├─────────┐
        ▼         ▼
   ┌────────┐ ┌────────┐
   │   DB   │ │ Cache  │
   └────────┘ └────────┘
```

### 1.2 Component Diagram

```
[コンポーネント図]

Frontend Components:
├── [Component1]
├── [Component2]
└── [Component3]

Backend Services:
├── [Service1]
├── [Service2]
└── [Service3]
```

### 1.3 Design Patterns

使用する設計パターン：
- **[パターン1]**: [用途と理由]
- **[パターン2]**: [用途と理由]

---

## 2. Data Models (データモデル)

### 2.1 Database Schema

#### Prisma Schema

```prisma
model [ModelName] {
  id        String   @id @default(cuid())
  [field1]  String
  [field2]  Int
  [field3]  DateTime @default(now())
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  // Relations
  [relation1] [RelatedModel] @relation(fields: [field], references: [id])

  // Indexes
  @@index([field1])
  @@index([field2])

  // Table mapping
  @@map("[table_name]")
}

enum [EnumName] {
  VALUE1
  VALUE2
  VALUE3
}
```

#### Entity Relationships

```
[ER図]

[Entity1] 1 ──── N [Entity2]
    │
    │ 1
    │
    │ N
[Entity3]
```

### 2.2 Data Types

| フィールド | 型 | 制約 | デフォルト | 説明 |
|-----------|-----|------|-----------|------|
| [field1] | String | NOT NULL, UNIQUE | - | [説明] |
| [field2] | Int | NOT NULL | 0 | [説明] |
| [field3] | DateTime | NOT NULL | now() | [説明] |

### 2.3 Data Validation Rules

```typescript
// Zod Schema
import { z } from 'zod';

export const [schemaName]Schema = z.object({
  [field1]: z.string().min(1).max(255),
  [field2]: z.number().int().positive(),
  [field3]: z.string().email(),
  [field4]: z.enum(['VALUE1', 'VALUE2']),
});

export type [TypeName] = z.infer<typeof [schemaName]Schema>;
```

### 2.4 Migration Strategy

**Phase 1: Initial Setup**
```sql
-- Migration: [migration_name]
CREATE TABLE [table_name] (
  id VARCHAR(255) PRIMARY KEY,
  [field1] VARCHAR(255) NOT NULL,
  [field2] INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE INDEX idx_[field1] ON [table_name]([field1]);
```

**Phase 2: Schema Updates** (if applicable)
```sql
-- Migration: [update_migration_name]
ALTER TABLE [table_name] ADD COLUMN [new_field] VARCHAR(255);
```

---

## 3. API Design (API設計)

### 3.1 RESTful API Endpoints

#### POST /api/[resource]

**用途**: [説明]

**Request**:
```typescript
// Headers
Authorization: Bearer <token>
Content-Type: application/json

// Body
{
  "[field1]": "value",
  "[field2]": 123,
  "[field3]": "value"
}
```

**Response**:

**Success (201 Created)**:
```json
{
  "data": {
    "id": "cuid_xxx",
    "[field1]": "value",
    "[field2]": 123,
    "createdAt": "2025-11-13T10:00:00Z"
  },
  "meta": {
    "requestId": "uuid",
    "timestamp": "2025-11-13T10:00:00Z"
  }
}
```

**Error (400 Bad Request)**:
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input",
    "details": {
      "[field1]": ["Field is required"]
    }
  },
  "meta": {
    "requestId": "uuid",
    "timestamp": "2025-11-13T10:00:00Z"
  }
}
```

#### GET /api/[resource]

**用途**: [説明]

**Query Parameters**:
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| page | number | No | 1 | Page number |
| limit | number | No | 20 | Items per page |
| sort | string | No | createdAt | Sort field |
| order | string | No | desc | Sort order |
| [filter] | string | No | - | Filter criteria |

**Response**:

**Success (200 OK)**:
```json
{
  "data": [
    {
      "id": "cuid_xxx",
      "[field1]": "value"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "totalPages": 5
  },
  "meta": {
    "requestId": "uuid",
    "timestamp": "2025-11-13T10:00:00Z"
  }
}
```

#### PUT /api/[resource]/:id

**用途**: [説明]

**Request**:
```json
{
  "[field1]": "updated_value",
  "[field2]": 456
}
```

**Response**: (200 OK)

#### DELETE /api/[resource]/:id

**用途**: [説明]

**Response**: (204 No Content)

### 3.2 API Error Codes

| Code | HTTP Status | Description | User Message |
|------|------------|-------------|--------------|
| VALIDATION_ERROR | 400 | 入力検証エラー | 入力内容を確認してください |
| UNAUTHORIZED | 401 | 認証エラー | ログインが必要です |
| FORBIDDEN | 403 | 権限エラー | この操作を実行する権限がありません |
| NOT_FOUND | 404 | リソース未発見 | 指定されたリソースが見つかりません |
| CONFLICT | 409 | 競合エラー | データが既に存在します |
| RATE_LIMIT_EXCEEDED | 429 | レート制限 | リクエストが多すぎます |
| INTERNAL_ERROR | 500 | サーバーエラー | システムエラーが発生しました |

### 3.3 Rate Limiting

- **制限**: [X] requests / [時間]
- **Headers**:
  ```
  X-RateLimit-Limit: 100
  X-RateLimit-Remaining: 95
  X-RateLimit-Reset: 1699876543
  ```

---

## 4. Frontend Architecture (フロントエンド設計)

### 4.1 Component Structure

```
src/
├── components/
│   ├── [FeatureName]/
│   │   ├── [Component1].tsx
│   │   ├── [Component2].tsx
│   │   └── [Component3].tsx
│   └── ui/
│       └── [SharedComponent].tsx
├── hooks/
│   └── use[Feature].ts
└── lib/
    └── [feature]-utils.ts
```

### 4.2 Component Specifications

#### [Component1]

**Props**:
```typescript
interface [Component1Props] {
  [prop1]: string;
  [prop2]: number;
  [prop3]?: boolean;
  on[Event]: (data: [Type]) => void;
}
```

**State**:
```typescript
const [state1, setState1] = useState<Type>(initialValue);
const [state2, setState2] = useState<Type>(initialValue);
```

**Behavior**:
- [動作1の説明]
- [動作2の説明]

### 4.3 State Management

**Strategy**: [Context API / Redux / Zustand / etc.]

```typescript
// State shape
interface [FeatureName]State {
  [field1]: Type;
  [field2]: Type;
  [field3]: Type;
}

// Actions
type [FeatureName]Action =
  | { type: 'ACTION1'; payload: Type }
  | { type: 'ACTION2'; payload: Type };
```

### 4.4 Client-Side Validation

```typescript
// Form validation
const validationSchema = z.object({
  [field1]: z.string().min(1, 'Required'),
  [field2]: z.number().positive('Must be positive'),
});
```

---

## 5. Business Logic (ビジネスロジック)

### 5.1 Service Layer

#### [FeatureName]Service

**Purpose**: [サービスの目的]

**Methods**:

```typescript
export class [FeatureName]Service {
  /**
   * [メソッドの説明]
   * @param data - [パラメータ説明]
   * @returns [戻り値説明]
   * @throws {Error} [エラー条件]
   */
  async [methodName](data: Type): Promise<ReturnType> {
    // 1. Validation
    // 2. Authorization check
    // 3. Business logic
    // 4. Database operation
    // 5. Return result
  }
}
```

### 5.2 Business Rules Implementation

**BR-1: [ルール名]**

```typescript
function validate[RuleName](data: Type): boolean {
  // Implementation
  if (condition) {
    throw new BusinessRuleError('Rule violation');
  }
  return true;
}
```

### 5.3 Transaction Management

```typescript
async function [operationName]() {
  return await prisma.$transaction(async (tx) => {
    // Step 1
    const result1 = await tx.[model1].create({ ... });

    // Step 2
    const result2 = await tx.[model2].update({ ... });

    // Step 3
    return { result1, result2 };
  });
}
```

---

## 6. Security Design (セキュリティ設計)

### 6.1 Authentication Flow

```
[認証フロー図]

1. User Login → 2. Cognito Auth → 3. JWT Token →
4. Session Creation → 5. Authenticated Request
```

### 6.2 Authorization Logic

```typescript
async function checkPermission(
  userId: string,
  resource: string,
  action: string
): Promise<boolean> {
  // 1. Get user role
  // 2. Check role permissions
  // 3. Check resource-level permissions
  // 4. Return result
}
```

**Permission Matrix**:

| Role | Create | Read | Update | Delete |
|------|--------|------|--------|--------|
| ADMIN | ✅ | ✅ | ✅ | ✅ |
| MANAGER | ✅ | ✅ | ✅ | ❌ |
| USER | ✅ | ✅ (own) | ✅ (own) | ❌ |

### 6.3 Input Sanitization

```typescript
function sanitize[Input](input: string): string {
  // 1. Trim whitespace
  // 2. Escape HTML
  // 3. Remove dangerous characters
  // 4. Validate format
  return sanitized;
}
```

### 6.4 SQL Injection Prevention

- ✅ Use Prisma ORM (parameterized queries)
- ❌ Never use raw SQL with string concatenation
- ✅ Validate all inputs with Zod

### 6.5 XSS Prevention

- ✅ React auto-escaping
- ❌ Never use `dangerouslySetInnerHTML` without sanitization
- ✅ Content Security Policy headers

### 6.6 CSRF Prevention

- ✅ NextAuth built-in CSRF protection
- ✅ SameSite cookie attribute
- ✅ Double-submit cookie pattern

---

## 7. Performance Considerations (パフォーマンス考慮事項)

### 7.1 Performance Goals

| Metric | Target | Measurement |
|--------|--------|-------------|
| API Response Time | < 500ms | Application Insights |
| Database Query Time | < 100ms | Prisma logging |
| Frontend Load Time | < 2s | Lighthouse |
| Time to Interactive | < 3s | Web Vitals |

### 7.2 Optimization Strategies

#### Database Optimization
```typescript
// ✅ Good: Select only needed fields
const user = await prisma.user.findUnique({
  where: { id },
  select: { id: true, name: true, email: true }
});

// ✅ Good: Use include for relations (avoid N+1)
const users = await prisma.user.findMany({
  include: { posts: true }
});

// ✅ Good: Add indexes
@@index([userId, createdAt])
```

#### Caching Strategy
```typescript
// Redis caching
const cached = await redis.get(`user:${id}`);
if (cached) {
  return JSON.parse(cached);
}

const user = await fetchUser(id);
await redis.set(`user:${id}`, JSON.stringify(user), 'EX', 3600);
```

#### Frontend Optimization
```typescript
// Code splitting
const [Component] = dynamic(() => import('./Component'));

// Image optimization
<Image src="/image.jpg" width={800} height={600} alt="..." />

// Memoization
const memoizedValue = useMemo(() => expensive(a, b), [a, b]);
```

### 7.3 Scalability Considerations

- **Horizontal Scaling**: [戦略]
- **Connection Pooling**: [設定]
- **Background Jobs**: [実装方法]

---

## 8. Testing Strategy (テスト戦略)

### 8.1 Unit Tests

**Target Coverage**: 90%

```typescript
// Example: Service test
describe('[FeatureName]Service', () => {
  describe('[methodName]', () => {
    it('should [expected behavior]', async () => {
      // Arrange
      const input = { ... };

      // Act
      const result = await service.[methodName](input);

      // Assert
      expect(result).toMatchObject({ ... });
    });

    it('should throw error when [condition]', async () => {
      // Test error cases
    });
  });
});
```

### 8.2 Integration Tests

```typescript
// Example: API test
describe('POST /api/[resource]', () => {
  it('should create [resource] with valid data', async () => {
    const response = await request(app)
      .post('/api/[resource]')
      .set('Authorization', `Bearer ${token}`)
      .send({ ... });

    expect(response.status).toBe(201);
    expect(response.body.data).toMatchObject({ ... });
  });
});
```

### 8.3 E2E Tests

```typescript
// Example: Playwright test
test('user can [action]', async ({ page }) => {
  await page.goto('/[path]');
  await page.fill('[name="field"]', 'value');
  await page.click('[type="submit"]');

  await expect(page).toHaveURL('/[expected-path]');
  await expect(page.locator('h1')).toContainText('[expected-text]');
});
```

### 8.4 Test Data

```typescript
// Test fixtures
export const mockUser = {
  id: 'test-user-1',
  email: 'test@example.com',
  name: 'Test User',
};
```

---

## 9. Error Handling (エラーハンドリング)

### 9.1 Error Classes

```typescript
export class [FeatureName]Error extends Error {
  constructor(
    public code: string,
    public message: string,
    public statusCode: number = 500
  ) {
    super(message);
    this.name = '[FeatureName]Error';
  }
}

export class ValidationError extends [FeatureName]Error {
  constructor(message: string) {
    super('VALIDATION_ERROR', message, 400);
  }
}
```

### 9.2 Error Handling Pattern

```typescript
export async function [handler](req: Request) {
  try {
    // Main logic
    return NextResponse.json(result);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Validation error', details: error.errors },
        { status: 400 }
      );
    }

    if (error instanceof [FeatureName]Error) {
      return NextResponse.json(
        { error: error.message },
        { status: error.statusCode }
      );
    }

    // Unexpected errors
    console.error('Unexpected error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

---

## 10. Logging & Monitoring (ログ・モニタリング)

### 10.1 Logging Strategy

```typescript
// Log levels
enum LogLevel {
  ERROR = 'error',
  WARN = 'warn',
  INFO = 'info',
  DEBUG = 'debug'
}

// Log structure
logger.info('[FeatureName].[methodName]', {
  userId,
  action: '[action]',
  result: '[result]',
  duration: '[ms]'
});
```

### 10.2 Monitoring Metrics

| Metric | Description | Alert Threshold |
|--------|-------------|----------------|
| Error Rate | エラー発生率 | > 1% |
| Response Time | API応答時間 | > 1s |
| Throughput | リクエスト数 | - |
| Database Connections | DB接続数 | > 80% |

### 10.3 Alerts

- **Critical**: エラー率 > 5%
- **Warning**: レスポンスタイム > 1秒
- **Info**: 新規デプロイ

---

## 11. Deployment Considerations (デプロイ考慮事項)

### 11.1 Environment Variables

```bash
# Required
DATABASE_URL="postgresql://..."
REDIS_URL="redis://..."
JWT_SECRET="..."

# Optional
FEATURE_FLAG_[FEATURE]="true/false"
```

### 11.2 Database Migration

```bash
# Run migration
npx prisma migrate deploy

# Generate Prisma Client
npx prisma generate
```

### 11.3 Rollback Plan

1. Identify issue
2. Revert deployment
3. Run reverse migration (if needed)
4. Verify rollback
5. Investigate root cause

---

## 12. Dependencies (依存関係)

### 12.1 External Libraries

| Library | Version | Purpose |
|---------|---------|---------|
| [library1] | ^X.Y.Z | [用途] |
| [library2] | ^X.Y.Z | [用途] |

### 12.2 Internal Dependencies

- Depends on: [他機能]
- Used by: [他機能]

---

## 13. Known Limitations (既知の制限事項)

- [制限1]: [詳細]
- [制限2]: [詳細]

---

## 14. Future Enhancements (将来の拡張)

- [拡張1]: [詳細]
- [拡張2]: [詳細]

---

## 変更履歴

| バージョン | 日付 | 変更内容 | 変更者 |
|-----------|------|---------|--------|
| 1.0 | [日付] | 初版作成 | [名前] |

---

## Approval (承認)

| 役割 | 氏名 | 承認日 | 署名 |
|------|------|--------|------|
| Tech Lead | [名前] | [日付] | [ ] |
| Architect | [名前] | [日付] | [ ] |
| Security | [名前] | [日付] | [ ] |
