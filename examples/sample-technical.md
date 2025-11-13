# user-authentication - Technical Specification

## ドキュメント情報

- **バージョン**: 1.0
- **最終更新日**: 2025-01-16
- **作成者**: Engineering Team
- **レビュー状態**: Approved
- **関連ドキュメント**:
  - Requirements: `/specs/requirements/user-authentication.md`
  - Implementation: `/specs/implementation/user-authentication.md`

---

## 概要 (Overview)

AWS Cognitoを使用したユーザー認証システムの技術設計。Next.js App Routerのミドルウェアで認証状態を管理し、Server Actionsで認証操作を実装する。

---

## Architecture Overview (アーキテクチャ概要)

### System Architecture

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │ HTTPS
       ▼
┌─────────────────────────────────┐
│     Next.js Middleware          │
│  - Session validation           │
│  - Route protection             │
└──────┬──────────────────────────┘
       │
       ▼
┌─────────────────────────────────┐
│   Next.js App Router (RSC)      │
│  - Server Components            │
│  - Server Actions               │
└──────┬──────────────────────────┘
       │
       ├─────────────┬──────────────┐
       ▼             ▼              ▼
┌──────────┐  ┌──────────┐  ┌──────────┐
│   AWS    │  │  Redis   │  │PostgreSQL│
│ Cognito  │  │ (Session)│  │   (DB)   │
└──────────┘  └──────────┘  └──────────┘
```

### Component Interactions

1. ユーザーがログインフォーム送信
2. Server ActionがAWS Cognitoに認証リクエスト
3. Cognito認証成功後、セッションをRedisに保存
4. 暗号化Cookieをクライアントに返す
5. 以降のリクエストはMiddlewareでセッション検証

---

## Technology Stack (技術スタック)

### Frontend
- **Framework**: Next.js 15 (App Router)
- **UI Library**: React 19
- **Language**: TypeScript 5.3
- **Form Handling**: React Hook Form + Zod
- **Styling**: Tailwind CSS

### Backend
- **Runtime**: Node.js 20
- **API**: Next.js Server Actions
- **Authentication**: AWS Cognito
- **Session Store**: Redis 7
- **Database**: PostgreSQL 16 + Prisma ORM

### Security
- **Password Hashing**: bcrypt (Cognito managed)
- **Session**: Iron-session (encrypted cookies)
- **CSRF Protection**: Next.js built-in

---

## Data Models (データモデル)

### Prisma Schema

```prisma
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  emailVerified Boolean  @default(false)
  cognitoId     String   @unique

  // Profile
  firstName     String?
  lastName      String?
  avatar        String?

  // Role
  role          Role     @default(USER)

  // Timestamps
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  lastLoginAt   DateTime?

  // Relations
  sessions      Session[]
  auditLogs     AuditLog[]

  @@index([email])
  @@index([cognitoId])
  @@map("users")
}

model Session {
  id        String   @id @default(cuid())
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)

  token     String   @unique
  expiresAt DateTime

  // Device info
  ipAddress String?
  userAgent String?

  createdAt DateTime @default(now())

  @@index([userId])
  @@index([token])
  @@index([expiresAt])
  @@map("sessions")
}

model AuditLog {
  id        String   @id @default(cuid())
  userId    String?
  user      User?    @relation(fields: [userId], references: [id], onDelete: SetNull)

  action    String   // LOGIN_SUCCESS, LOGIN_FAILED, LOGOUT, PASSWORD_CHANGE, etc.
  ipAddress String?
  userAgent String?
  metadata  Json?

  createdAt DateTime @default(now())

  @@index([userId])
  @@index([action])
  @@index([createdAt])
  @@map("audit_logs")
}

enum Role {
  ADMIN
  USER
}
```

### Relationships
- User → Session: 1対多（ユーザーは複数のセッションを持てる）
- User → AuditLog: 1対多（ユーザーの操作履歴）

### Migration Strategy
1. 初期マイグレーション: `prisma migrate dev --name init`
2. Cognitoユーザープールの設定
3. 管理者ユーザーのシード

---

## API Specification (API仕様)

### Server Actions

#### 1. loginAction

**Purpose**: ユーザーログイン

**Input**:
```typescript
interface LoginInput {
  email: string;
  password: string;
}
```

**Output**:
```typescript
interface LoginOutput {
  success: boolean;
  user?: {
    id: string;
    email: string;
    role: Role;
  };
  error?: string;
}
```

**Errors**:
- `INVALID_CREDENTIALS`: 認証情報が正しくない
- `ACCOUNT_LOCKED`: アカウントがロックされている
- `SERVER_ERROR`: サーバーエラー

**Implementation**:
```typescript
'use server';

export async function loginAction(data: LoginInput): Promise<LoginOutput> {
  try {
    // 1. Validate input
    const validated = loginSchema.parse(data);

    // 2. Authenticate with Cognito
    const cognitoUser = await authenticateWithCognito(
      validated.email,
      validated.password
    );

    // 3. Get or create user in DB
    const user = await prisma.user.upsert({
      where: { cognitoId: cognitoUser.sub },
      create: {
        cognitoId: cognitoUser.sub,
        email: cognitoUser.email,
        emailVerified: cognitoUser.email_verified,
      },
      update: {
        lastLoginAt: new Date(),
      },
    });

    // 4. Create session
    const session = await createSession(user.id);

    // 5. Set cookie
    await setSessionCookie(session.token);

    // 6. Audit log
    await logAudit('LOGIN_SUCCESS', user.id);

    return {
      success: true,
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
      },
    };
  } catch (error) {
    await logAudit('LOGIN_FAILED', undefined, { email: data.email });
    return {
      success: false,
      error: handleAuthError(error),
    };
  }
}
```

---

#### 2. logoutAction

**Purpose**: ユーザーログアウト

**Output**:
```typescript
interface LogoutOutput {
  success: boolean;
}
```

---

#### 3. requestPasswordResetAction

**Purpose**: パスワードリセットリクエスト

**Input**:
```typescript
interface PasswordResetInput {
  email: string;
}
```

**Output**:
```typescript
interface PasswordResetOutput {
  success: boolean;
  message: string;
}
```

---

## Frontend Architecture (フロントエンドアーキテクチャ)

### Component Structure

```
app/
├── (auth)/                        # Auth route group
│   ├── login/
│   │   └── page.tsx              # Login page (Server Component)
│   ├── signup/
│   │   └── page.tsx              # Signup page (Server Component)
│   └── reset-password/
│       └── page.tsx              # Password reset (Server Component)
├── (protected)/                   # Protected route group
│   ├── layout.tsx                # Protected layout with auth check
│   └── dashboard/
│       └── page.tsx              # Dashboard (Server Component)
├── _components/
│   ├── LoginForm.tsx             # Client Component
│   ├── SignupForm.tsx            # Client Component
│   └── PasswordResetForm.tsx     # Client Component
├── _actions/
│   └── auth-actions.ts           # Server Actions
└── middleware.ts                  # Authentication middleware
```

### State Management
- **Server State**: React Server Components で直接データフェッチ
- **Client State**: useStateとuseFormState for form handling
- **Session State**: Middleware + Cookies

---

## Security Design (セキュリティ設計)

### Authentication Flow

```
User Input → Validation → AWS Cognito → Session Creation → Cookie
                ↓
           Rate Limiting
                ↓
           Audit Logging
```

### Authorization Rules
```typescript
const permissions = {
  '/dashboard': ['USER', 'ADMIN'],
  '/admin': ['ADMIN'],
  '/profile': ['USER', 'ADMIN'],
};
```

### Input Validation

```typescript
import { z } from 'zod';

export const loginSchema = z.object({
  email: z.string().email('有効なメールアドレスを入力してください'),
  password: z
    .string()
    .min(8, 'パスワードは8文字以上である必要があります')
    .regex(/[A-Z]/, '大文字を1文字以上含む必要があります')
    .regex(/[a-z]/, '小文字を1文字以上含む必要があります')
    .regex(/[0-9]/, '数字を1文字以上含む必要があります'),
});
```

### Session Security
- HTTPOnly cookies
- Secure flag (HTTPS only)
- SameSite=Strict
- 30分タイムアウト
- Redis TTL設定

---

## Performance Considerations (パフォーマンス考慮事項)

### Database Optimization
- email、cognitoIdにインデックス
- Session tokenにインデックス
- Connection pooling（最大20接続）

### Caching Strategy
- セッションデータをRedisにキャッシュ（TTL: 30分）
- ユーザープロファイルをメモリキャッシュ（1分）

### Rate Limiting
- ログインエンドポイント: 5回/15分/IP
- パスワードリセット: 3回/1時間/IP

---

## Testing Strategy (テスト戦略)

### Unit Tests
- Validation schemas (Zod)
- Auth helper functions
- Error handling

### Integration Tests
- Server Actions
- Database operations
- Cognito integration (mocked)

### E2E Tests
- Login flow
- Logout flow
- Password reset flow
- Session expiration

**Target Coverage**: 80%以上

---

## Error Handling (エラーハンドリング)

### Error Response Format
```typescript
interface AuthError {
  code: ErrorCode;
  message: string;
  details?: Record<string, unknown>;
}

enum ErrorCode {
  INVALID_CREDENTIALS = 'INVALID_CREDENTIALS',
  ACCOUNT_LOCKED = 'ACCOUNT_LOCKED',
  SESSION_EXPIRED = 'SESSION_EXPIRED',
  SERVER_ERROR = 'SERVER_ERROR',
}
```

---

## Deployment Considerations (デプロイ考慮事項)

### Environment Variables
```bash
# AWS Cognito
COGNITO_USER_POOL_ID=
COGNITO_CLIENT_ID=
COGNITO_CLIENT_SECRET=
AWS_REGION=ap-northeast-1

# Session
SESSION_SECRET=
REDIS_URL=

# Database
DATABASE_URL=
```

### Database Migrations
- Pre-deployment: マイグレーション実行
- Rollback plan: マイグレーションロールバックスクリプト

---

## Architecture Decision Records (ADR)

### ADR-1: AWS Cognitoの採用

**Status**: Accepted

**Context**: 認証システムの選定

**Decision**: AWS Cognitoを採用

**Consequences**:
- **Positive**: マネージドサービスで運用負荷軽減、スケーラブル、セキュリティ機能豊富
- **Negative**: AWS依存、カスタマイズに制限

---

**最終レビュー**: Tech Lead
**承認日**: 2025-01-16
