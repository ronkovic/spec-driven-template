# user-authentication - Implementation Guide

## ドキュメント情報

- **バージョン**: 1.0
- **最終更新日**: 2025-01-17
- **作成者**: Engineering Team
- **レビュー状態**: Ready for Implementation
- **推定工数**: 40時間（5日間）

---

## 概要 (Overview)

AWS Cognitoを使用したユーザー認証システムの実装ガイド。5つのフェーズに分けて段階的に実装する。

---

## Prerequisites (前提条件)

### Required Tools
- Node.js 20+
- PostgreSQL 16+
- Redis 7+
- AWS CLI
- pnpm 9+

### Environment Setup

```bash
# Clone repository
git clone <repository-url>
cd project-name

# Install dependencies
pnpm install

# Setup environment variables
cp .env.example .env.local

# Start database and Redis
docker-compose up -d

# Run migrations
pnpm prisma migrate dev

# Start dev server
pnpm dev
```

### Environment Variables

```bash
# Database
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/myapp"

# AWS Cognito
COGNITO_USER_POOL_ID="ap-northeast-1_xxxxxxxx"
COGNITO_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxx"
AWS_REGION="ap-northeast-1"

# Session
SESSION_SECRET="generate-random-32-char-string"
REDIS_URL="redis://localhost:6379"
```

---

## Implementation Phases (実装フェーズ)

### Phase 1: Database & Data Models (2時間)

**Tasks**:
1. Prismaスキーマ作成
2. マイグレーション実行
3. Seed data作成

**Files to Create**:
- `prisma/schema.prisma`
- `prisma/migrations/xxx_init/migration.sql`
- `prisma/seed.ts`

**Example Code**:
```typescript
// prisma/schema.prisma
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  cognitoId     String   @unique
  role          Role     @default(USER)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  @@map("users")
}
```

**Verification**:
```bash
pnpm prisma migrate dev
pnpm prisma studio
```

---

### Phase 2: Validation & Service Layer (6時間)

**Tasks**:
1. Zodバリデーションスキーマ作成
2. Repository層実装
3. Service層実装

**Files to Create**:
- `src/lib/auth/validation.ts`
- `src/lib/auth/repository.ts`
- `src/lib/auth/service.ts`
- `src/lib/auth/cognito.ts`

**Example Code**:
```typescript
// src/lib/auth/validation.ts
import { z } from 'zod';

export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

// src/lib/auth/service.ts
export class AuthService {
  async login(email: string, password: string) {
    // 1. Authenticate with Cognito
    // 2. Create/update user in DB
    // 3. Create session
    // 4. Return user data
  }
}
```

---

### Phase 3: Server Actions & API (4時間)

**Tasks**:
1. Server Actions作成
2. エラーハンドリング実装
3. Rate limiting追加

**Files to Create**:
- `src/app/_actions/auth-actions.ts`
- `src/lib/auth/errors.ts`

**Example Code**:
```typescript
// src/app/_actions/auth-actions.ts
'use server';

export async function loginAction(formData: FormData) {
  const data = {
    email: formData.get('email') as string,
    password: formData.get('password') as string,
  };

  const validated = loginSchema.parse(data);
  const result = await authService.login(validated.email, validated.password);

  if (result.success) {
    await setSessionCookie(result.session);
  }

  return result;
}
```

---

### Phase 4: Frontend Components (6時間)

**Tasks**:
1. Login formコンポーネント作成
2. Logout buttonコンポーネント作成
3. Password reset formコンポーネント作成
4. Protected layoutコンポーネント作成

**Files to Create**:
- `src/app/(auth)/login/page.tsx`
- `src/app/_components/LoginForm.tsx`
- `src/app/_components/LogoutButton.tsx`
- `src/app/(protected)/layout.tsx`
- `src/middleware.ts`

**Example Code**:
```typescript
// src/app/_components/LoginForm.tsx
'use client';

export function LoginForm() {
  const [state, formAction] = useFormState(loginAction, null);

  return (
    <form action={formAction}>
      <input type="email" name="email" required />
      <input type="password" name="password" required />
      {state?.error && <p>{state.error}</p>}
      <button type="submit">Login</button>
    </form>
  );
}
```

---

### Phase 5: Testing & Documentation (4時間)

**Tasks**:
1. Unit tests作成
2. Integration tests作成
3. E2E tests作成
4. APIドキュメント更新

**Files to Create**:
- `tests/lib/auth/service.test.ts`
- `tests/app/_actions/auth-actions.test.ts`
- `tests/e2e/auth.spec.ts`

**Example Code**:
```typescript
// tests/lib/auth/service.test.ts
describe('AuthService', () => {
  it('should login successfully', async () => {
    const result = await authService.login('test@example.com', 'password');
    expect(result.success).toBe(true);
  });
});
```

---

## Coding Standards (コーディング標準)

### TypeScript
- Strict mode有効
- すべての関数に型定義
- anyの使用禁止

### React
- Server Componentsを優先
- 'use client'は必要な場合のみ
- コンポーネントは単一責任

### Error Handling
- try-catchで例外処理
- ユーザーフレンドリーなエラーメッセージ
- すべてのエラーをログに記録

---

## Testing Strategy (テスト戦略)

### Unit Tests
- すべてのサービス関数
- すべてのバリデーションスキーマ
- カバレッジ目標: 85%

### Integration Tests
- Server Actions
- Database operations
- 外部API呼び出し（mocked）

### E2E Tests
- ログインフロー
- ログアウトフロー
- パスワードリセットフロー

**Test Commands**:
```bash
pnpm test              # Run all tests
pnpm test:unit         # Unit tests only
pnpm test:integration  # Integration tests
pnpm test:e2e          # E2E tests
pnpm test:coverage     # Coverage report
```

---

## Deployment Checklist (デプロイチェックリスト)

### Pre-Deployment
- [ ] すべてのテストがパス
- [ ] TypeScript型チェック完了
- [ ] ESLintエラーなし
- [ ] 環境変数設定完了
- [ ] データベースマイグレーション準備完了

### Deployment
- [ ] マイグレーション実行
- [ ] 環境変数デプロイ
- [ ] アプリケーションデプロイ
- [ ] ヘルスチェック確認

### Post-Deployment
- [ ] ログイン機能動作確認
- [ ] パフォーマンスモニタリング確認
- [ ] エラーログ確認
- [ ] ロールバック手順確認済み

---

## Rollback Procedure (ロールバック手順)

1. アプリケーションを前のバージョンにロールバック
2. データベースマイグレーションをロールバック（必要な場合）
3. 動作確認

```bash
# Database rollback
pnpm prisma migrate resolve --rolled-back [migration-name]
```

---

## Troubleshooting (トラブルシューティング)

### Issue: Cognito認証エラー
**Symptom**: 正しい認証情報でもログイン失敗
**Solution**:
1. Cognito User Pool IDとClient IDを確認
2. AWS region設定を確認
3. Cognitoコンソールでユーザーステータス確認

### Issue: セッションが保持されない
**Symptom**: ログイン後すぐにログアウトされる
**Solution**:
1. Cookie設定を確認（HTTPOnly、Secure、SameSite）
2. Redisサーバーが起動しているか確認
3. SESSION_SECRETが設定されているか確認

---

## Performance Optimization (パフォーマンス最適化)

### Database
- Connectionプーリング設定
- 頻繁なクエリのインデックス追加
- N+1問題の回避

### Caching
- セッションデータのRedisキャッシュ
- ユーザープロファイルのキャッシュ

### Monitoring
- ログイン時間のメトリクス
- エラーレートの監視
- データベースクエリ時間の監視

---

**実装開始日**: 2025-01-20
**実装完了予定日**: 2025-01-24
**担当者**: Backend Team + Frontend Team
