# [プロジェクト名] - Development Standards

## ドキュメント情報

- **バージョン**: 1.0
- **最終更新日**: [YYYY-MM-DD]
- **作成者**: [Tech Lead名]
- **レビュー状態**: Draft / In Review / Approved
- **関連ドキュメント**:
  - Technical Architecture: `/specs/TECHNICAL_ARCHITECTURE.md`

---

## 1. コーディング規約

### 1.1 一般原則
1. **可読性優先**: コードは人が読むために書く
2. **KISS原則**: Keep It Simple, Stupid
3. **DRY原則**: Don't Repeat Yourself
4. **YAGNI原則**: You Aren't Gonna Need It
5. **SOLID原則**: オブジェクト指向設計の5原則

### 1.2 言語別規約

#### TypeScript
```typescript
// ✅ Good: 明確な型定義
interface User {
  id: string;
  email: string;
  name: string;
  role: UserRole;
}

async function getUserById(id: string): Promise<User> {
  // 実装
}

// ❌ Bad: any型の使用
async function getUserById(id: any): Promise<any> {
  // 実装
}
```

**規約**:
- `any`型の使用禁止（やむを得ない場合は`unknown`を使用）
- 明示的な戻り値の型定義
- インターフェースとタイプエイリアスの使い分け
  - インターフェース: オブジェクトの形状定義
  - タイプエイリアス: ユニオン型、交差型、プリミティブ

#### React/Next.js
```typescript
// ✅ Good: 関数コンポーネント + TypeScript
interface UserCardProps {
  user: User;
  onEdit: (id: string) => void;
}

export function UserCard({ user, onEdit }: UserCardProps) {
  return (
    <div className="user-card">
      <h2>{user.name}</h2>
      <button onClick={() => onEdit(user.id)}>Edit</button>
    </div>
  );
}

// ❌ Bad: props の型定義なし
export function UserCard({ user, onEdit }) {
  // 実装
}
```

**規約**:
- 関数コンポーネントを使用（クラスコンポーネント禁止）
- Props は必ず型定義
- デフォルトエクスポートより名前付きエクスポート推奨
- Server Components と Client Components の明確な分離

### 1.3 命名規則

#### ファイル名
| 種類 | 形式 | 例 |
|------|------|-----|
| コンポーネント | PascalCase.tsx | `UserCard.tsx` |
| ユーティリティ | camelCase.ts | `formatDate.ts` |
| API Route | kebab-case | `user-profile.ts` |
| テスト | *.test.ts(x) | `UserCard.test.tsx` |

#### 変数・関数名
```typescript
// ✅ Good
const userName = 'John';
const isAuthenticated = true;
const hasPermission = false;

function getUserById(id: string): Promise<User> { }
function validateEmail(email: string): boolean { }
async function fetchUserData(): Promise<User[]> { }

// ❌ Bad
const name = 'John';  // 具体性に欠ける
const auth = true;    // 略称
const perm = false;   // 略称

function get(id: string) { }  // 不明確
function validate(e: string) { }  // 略称
```

**規約**:
- 変数: camelCase
- 定数: UPPER_SNAKE_CASE（真の定数のみ）
- 関数: camelCase、動詞で始める
- クラス: PascalCase
- コンポーネント: PascalCase
- Boolean: `is`, `has`, `should` で始める

### 1.4 コメント規約

```typescript
/**
 * ユーザー情報を取得する
 *
 * @param id - ユーザーID
 * @returns ユーザーオブジェクト
 * @throws {UserNotFoundError} ユーザーが見つからない場合
 *
 * @example
 * ```typescript
 * const user = await getUserById('user-123');
 * console.log(user.name);
 * ```
 */
async function getUserById(id: string): Promise<User> {
  // 実装
}

// ✅ Good: 「なぜ」を説明するコメント
// NOTE: パフォーマンス向上のため、キャッシュを使用
const cachedUser = await getCachedUser(id);

// ❌ Bad: 「何を」説明するコメント（コード自体が説明）
// ユーザーIDでユーザーを取得
const user = await getUserById(id);
```

**規約**:
- JSDoc形式でドキュメント化
- 「なぜ」そうしたのかを説明（「何を」はコードで表現）
- TODOコメントには担当者と期限を記載: `// TODO(担当者, 2025-12-31): 説明`

---

## 2. ディレクトリ構造

### 2.1 標準構造

```
project-root/
├── src/
│   ├── app/                      # Next.js App Router
│   │   ├── (auth)/              # ルートグループ: 認証
│   │   ├── (dashboard)/         # ルートグループ: ダッシュボード
│   │   ├── api/                 # API Routes
│   │   ├── layout.tsx           # ルートレイアウト
│   │   └── page.tsx             # ルートページ
│   │
│   ├── components/              # UIコンポーネント
│   │   ├── ui/                  # 汎用UIコンポーネント
│   │   │   ├── Button.tsx
│   │   │   └── Input.tsx
│   │   └── features/            # 機能別コンポーネント
│   │       ├── user/
│   │       └── report/
│   │
│   ├── lib/                     # ライブラリ・ユーティリティ
│   │   ├── schemas/             # Zod スキーマ
│   │   ├── utils/               # ユーティリティ関数
│   │   └── constants.ts         # 定数
│   │
│   ├── services/                # ビジネスロジック
│   │   ├── user.service.ts
│   │   └── auth.service.ts
│   │
│   ├── types/                   # TypeScript型定義
│   │   ├── user.types.ts
│   │   └── api.types.ts
│   │
│   └── hooks/                   # カスタムReact Hooks
│       ├── useUser.ts
│       └── useAuth.ts
│
├── prisma/                      # Prisma設定
│   ├── schema.prisma
│   └── migrations/
│
├── public/                      # 静的ファイル
│
├── tests/                       # テストファイル
│   ├── unit/
│   ├── integration/
│   └── e2e/
│
├── docs/                        # ドキュメント
│
└── specs/                       # 仕様書
    ├── requirements/
    ├── technical/
    └── implementation/
```

### 2.2 ファイル配置規約

| ファイル種別 | 配置場所 | 命名 |
|-------------|---------|------|
| Page | `src/app/**/*.tsx` | `page.tsx` |
| Layout | `src/app/**/*.tsx` | `layout.tsx` |
| API Route | `src/app/api/**/*.ts` | `route.ts` |
| Component | `src/components/**/*.tsx` | PascalCase |
| Service | `src/services/**/*.ts` | `*.service.ts` |
| Hook | `src/hooks/**/*.ts` | `use*.ts` |
| Utility | `src/lib/utils/**/*.ts` | camelCase |
| Type | `src/types/**/*.ts` | `*.types.ts` |

---

## 3. テスト戦略

### 3.1 テストピラミッド

```
        ┌────────┐
        │   E2E  │  10%  - Playwright
        ├────────┤
        │ Integration │  30%  - Jest + Testing Library
        ├────────┤
        │   Unit   │  60%  - Jest
        └────────┘
```

### 3.2 ユニットテスト

```typescript
// src/lib/utils/formatDate.test.ts
import { formatDate } from './formatDate';

describe('formatDate', () => {
  it('should format ISO date to Japanese format', () => {
    const input = '2025-11-13T10:00:00Z';
    const expected = '2025年11月13日';

    expect(formatDate(input)).toBe(expected);
  });

  it('should handle invalid date', () => {
    expect(() => formatDate('invalid')).toThrow('Invalid date');
  });
});
```

**規約**:
- すべてのユーティリティ関数にテストを書く
- カバレッジ目標: 80%以上
- AAA (Arrange-Act-Assert) パターンを使用

### 3.3 統合テスト

```typescript
// src/services/user.service.test.ts
import { UserService } from './user.service';
import { prisma } from '@/lib/prisma';

describe('UserService', () => {
  beforeEach(async () => {
    // テストDBセットアップ
    await prisma.user.deleteMany();
  });

  it('should create a new user', async () => {
    const service = new UserService();
    const input = {
      email: 'test@example.com',
      name: 'Test User',
      role: 'USER'
    };

    const user = await service.create(input);

    expect(user).toMatchObject(input);
    expect(user.id).toBeDefined();
  });
});
```

### 3.4 E2Eテスト

```typescript
// tests/e2e/user-login.spec.ts
import { test, expect } from '@playwright/test';

test('user can login successfully', async ({ page }) => {
  await page.goto('/login');

  await page.fill('[name="email"]', 'user@example.com');
  await page.fill('[name="password"]', 'password123');
  await page.click('[type="submit"]');

  await expect(page).toHaveURL('/dashboard');
  await expect(page.locator('h1')).toContainText('Dashboard');
});
```

### 3.5 テスト実行

```bash
# ユニット・統合テスト
npm run test

# ウォッチモード
npm run test:watch

# カバレッジ
npm run test:coverage

# E2Eテスト
npm run test:e2e
```

---

## 4. Git ワークフロー

### 4.1 ブランチ戦略

```
main (本番)
  ├── develop (開発)
  │   ├── feature/user-authentication
  │   ├── feature/report-comments
  │   └── bugfix/login-error
  └── hotfix/critical-security-fix
```

**ブランチ種別**:
| ブランチ | 命名 | 用途 | マージ先 |
|---------|------|------|---------|
| main | `main` | 本番環境 | - |
| develop | `develop` | 開発統合 | main |
| feature | `feature/[name]` | 新機能 | develop |
| bugfix | `bugfix/[name]` | バグ修正 | develop |
| hotfix | `hotfix/[name]` | 緊急修正 | main, develop |

### 4.2 コミットメッセージ規約

```bash
# フォーマット
[Type] Brief description

Detailed description (optional)

- Additional info 1
- Additional info 2

Refs: #issue-number
```

**Type一覧**:
- `[Feature]` - 新機能
- `[Fix]` - バグ修正
- `[Refactor]` - リファクタリング
- `[Docs]` - ドキュメント
- `[Test]` - テスト
- `[Chore]` - 雑務（依存関係更新など）
- `[Style]` - コードフォーマット
- `[Perf]` - パフォーマンス改善

**例**:
```bash
[Feature] Add user authentication with Cognito

- Implement Cognito integration
- Add login/logout functionality
- Create protected route middleware
- Add session management

Refs: #123
Tests: 15 new tests (coverage: 85%)
```

### 4.3 プルリクエスト規約

#### PRタイトル
```
[Type] Brief description of changes
```

#### PRテンプレート
```markdown
## 概要
[変更内容の簡潔な説明]

## 変更内容
- [ ] 機能1の実装
- [ ] 機能2の実装
- [ ] テストの追加

## テスト
- [ ] ユニットテスト追加
- [ ] 統合テスト追加
- [ ] E2Eテスト追加
- [ ] 手動テスト完了

## スクリーンショット（UI変更がある場合）
[スクリーンショット]

## 関連Issue
Closes #[issue-number]

## チェックリスト
- [ ] コードレビュー依頼済み
- [ ] テスト通過
- [ ] ドキュメント更新
- [ ] マイグレーション実行済み（該当する場合）
```

### 4.4 コードレビュープロセス

1. **PR作成者**:
   - 自己レビュー実施
   - テスト全通過確認
   - ドキュメント更新

2. **レビュアー**:
   - コード品質チェック
   - セキュリティチェック
   - テストカバレッジ確認
   - パフォーマンスチェック

3. **マージ条件**:
   - 最低1人の承認
   - すべてのテスト通過
   - コンフリクト解消済み
   - CI/CD通過

---

## 5. コード品質管理

### 5.1 静的解析

#### ESLint
```javascript
// .eslintrc.js
module.exports = {
  extends: [
    'next/core-web-vitals',
    'plugin:@typescript-eslint/recommended',
  ],
  rules: {
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/no-explicit-any': 'error',
    'no-console': 'warn',
  },
};
```

#### Prettier
```javascript
// .prettierrc
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2
}
```

### 5.2 品質ゲート

```bash
# コミット前に必ず実行
npm run quality-check

# 以下を自動実行:
# 1. Lint
# 2. Type check
# 3. Tests
# 4. Format check
```

### 5.3 カバレッジ目標

| カテゴリ | 目標 | 最低ライン |
|---------|------|-----------|
| 全体 | 80% | 70% |
| Services | 90% | 80% |
| Utils | 95% | 90% |
| Components | 70% | 60% |

---

## 6. セキュリティガイドライン

### 6.1 OWASP Top 10 対策

#### 1. Injection
```typescript
// ✅ Good: Prismaを使用（SQLインジェクション対策）
const user = await prisma.user.findUnique({
  where: { email }
});

// ❌ Bad: 生SQLの文字列連結
const query = `SELECT * FROM users WHERE email = '${email}'`;
```

#### 2. 認証の不備
```typescript
// ✅ Good: セッション検証
const session = await getServerSession(authOptions);
if (!session?.user) {
  return new Response('Unauthorized', { status: 401 });
}
```

#### 3. XSS
```typescript
// ✅ Good: Reactの自動エスケープ
<div>{user.name}</div>

// ❌ Bad: dangerouslySetInnerHTML
<div dangerouslySetInnerHTML={{ __html: userInput }} />
```

### 6.2 環境変数管理

```bash
# ✅ Good: .env.local (Gitに含めない)
DATABASE_URL="postgresql://..."
JWT_SECRET="random-secret"
COGNITO_CLIENT_ID="..."

# ❌ Bad: コード内にハードコード
const secret = "my-secret-key";
```

### 6.3 セキュリティチェックリスト

- [ ] 環境変数を適切に管理
- [ ] 機密情報をログに出力しない
- [ ] HTTPS通信のみ許可
- [ ] CSRF対策実装
- [ ] レート制限実装
- [ ] 入力検証実装
- [ ] 権限チェック実装
- [ ] セキュリティヘッダー設定

---

## 7. パフォーマンスガイドライン

### 7.1 フロントエンド最適化

```typescript
// ✅ Good: 動的インポート
const DynamicComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <LoadingSpinner />,
});

// ✅ Good: 画像最適化
import Image from 'next/image';
<Image src="/image.jpg" alt="..." width={800} height={600} />

// ✅ Good: メモ化
const memoizedValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);
```

### 7.2 バックエンド最適化

```typescript
// ✅ Good: 必要なフィールドのみ取得
const user = await prisma.user.findUnique({
  where: { id },
  select: { id: true, name: true, email: true }
});

// ✅ Good: N+1問題の回避
const users = await prisma.user.findMany({
  include: { posts: true }  // 1クエリで取得
});

// ❌ Bad: N+1問題
const users = await prisma.user.findMany();
for (const user of users) {
  user.posts = await prisma.post.findMany({ where: { userId: user.id } });
}
```

---

## 8. エラーハンドリング

### 8.1 エラークラス定義

```typescript
// src/lib/errors.ts
export class AppError extends Error {
  constructor(
    public code: string,
    public message: string,
    public statusCode: number = 500
  ) {
    super(message);
    this.name = 'AppError';
  }
}

export class ValidationError extends AppError {
  constructor(message: string) {
    super('VALIDATION_ERROR', message, 400);
  }
}

export class UnauthorizedError extends AppError {
  constructor(message: string = 'Unauthorized') {
    super('UNAUTHORIZED', message, 401);
  }
}
```

### 8.2 エラーハンドリングパターン

```typescript
// API Route
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const data = createUserSchema.parse(body);

    const user = await userService.create(data);

    return NextResponse.json(user, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Validation error', details: error.errors },
        { status: 400 }
      );
    }

    if (error instanceof AppError) {
      return NextResponse.json(
        { error: error.message },
        { status: error.statusCode }
      );
    }

    // 予期しないエラーはログに記録
    console.error('Unexpected error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

---

## 9. ドキュメンテーション

### 9.1 必須ドキュメント

- **README.md**: プロジェクト概要、セットアップ手順
- **API.md**: API仕様書
- **ARCHITECTURE.md**: アーキテクチャ概要
- **CONTRIBUTING.md**: 貢献ガイド

### 9.2 コードドキュメント

```typescript
/**
 * ユーザーサービス
 *
 * ユーザーの作成、取得、更新、削除を行うサービスクラス
 */
export class UserService {
  /**
   * 新規ユーザーを作成する
   *
   * @param data - ユーザー作成データ
   * @returns 作成されたユーザー
   * @throws {ValidationError} バリデーションエラーの場合
   * @throws {DuplicateError} メールアドレスが重複している場合
   */
  async create(data: CreateUserInput): Promise<User> {
    // 実装
  }
}
```

---

## 10. CI/CD

### 10.1 CI パイプライン

```yaml
# .github/workflows/ci.yml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm run test:coverage
      - run: npm run build
```

### 10.2 デプロイフロー

```
PR作成 → CI実行 → レビュー → マージ →
自動デプロイ（Staging） → 手動承認 →
本番デプロイ → Smoke Test
```

---

## 変更履歴

| バージョン | 日付 | 変更内容 | 変更者 |
|-----------|------|---------|--------|
| 1.0 | [日付] | 初版作成 | [名前] |
