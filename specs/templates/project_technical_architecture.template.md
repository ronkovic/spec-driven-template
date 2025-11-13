# [プロジェクト名] - Technical Architecture

## ドキュメント情報

- **バージョン**: 1.0
- **最終更新日**: [YYYY-MM-DD]
- **作成者**: [Tech Lead名]
- **レビュー状態**: Draft / In Review / Approved
- **関連ドキュメント**:
  - Project Overview: `/specs/PROJECT_OVERVIEW.md`
  - Development Standards: `/specs/DEVELOPMENT_STANDARDS.md`

---

## 1. システムアーキテクチャ概要

### 1.1 アーキテクチャ図
```
[システムアーキテクチャの図をここに挿入]

例:
┌─────────────┐
│   Client    │
│  (Browser)  │
└──────┬──────┘
       │ HTTPS
       ▼
┌─────────────┐
│   Next.js   │
│  Frontend   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Next.js   │
│   Backend   │
│  (API/RSC)  │
└──────┬──────┘
       │
       ├─────────────┐
       │             │
       ▼             ▼
┌──────────┐   ┌──────────┐
│PostgreSQL│   │  Redis   │
│ Database │   │  Cache   │
└──────────┘   └──────────┘
```

### 1.2 アーキテクチャパターン
- **アーキテクチャスタイル**: [例: Monolith / Microservices / Serverless]
- **設計パターン**: [例: MVC, MVVM, Clean Architecture]
- **通信パターン**: [例: REST, GraphQL, gRPC]

### 1.3 設計原則
1. **[原則1]**: [説明]
2. **[原則2]**: [説明]
3. **[原則3]**: [説明]

---

## 2. 技術スタック

### 2.1 フロントエンド
| 技術 | バージョン | 用途 | 選定理由 |
|------|-----------|------|---------|
| Next.js | [x.x.x] | フレームワーク | [理由] |
| React | [x.x.x] | UIライブラリ | [理由] |
| TypeScript | [x.x.x] | 型安全性 | [理由] |
| Tailwind CSS | [x.x.x] | スタイリング | [理由] |

### 2.2 バックエンド
| 技術 | バージョン | 用途 | 選定理由 |
|------|-----------|------|---------|
| Next.js | [x.x.x] | API/RSC | [理由] |
| Prisma | [x.x.x] | ORM | [理由] |
| Zod | [x.x.x] | バリデーション | [理由] |

### 2.3 データベース
| 技術 | バージョン | 用途 | 選定理由 |
|------|-----------|------|---------|
| PostgreSQL | [x.x.x] | メインDB | [理由] |
| Redis | [x.x.x] | キャッシュ | [理由] |

### 2.4 認証・認可
| 技術 | バージョン | 用途 | 選定理由 |
|------|-----------|------|---------|
| NextAuth.js | [x.x.x] | 認証 | [理由] |
| AWS Cognito | [x.x.x] | ID管理 | [理由] |

### 2.5 インフラストラクチャ
| 技術 | 用途 | 選定理由 |
|------|------|---------|
| Vercel | ホスティング | [理由] |
| AWS RDS | データベース | [理由] |
| AWS S3 | ファイル保存 | [理由] |
| CloudFront | CDN | [理由] |

### 2.6 開発ツール
| 技術 | 用途 |
|------|------|
| ESLint | リンター |
| Prettier | フォーマッター |
| Jest | ユニットテスト |
| Playwright | E2Eテスト |
| GitHub Actions | CI/CD |

---

## 3. データアーキテクチャ

### 3.1 データモデル概要

#### エンティティ関係図 (ER図)
```
[ER図をここに挿入]

例:
┌─────────────┐
│    User     │
├─────────────┤
│ id          │
│ email       │
│ name        │
└──────┬──────┘
       │ 1
       │
       │ N
┌──────▼──────┐
│Organization │
├─────────────┤
│ id          │
│ name        │
│ domain      │
└─────────────┘
```

### 3.2 主要エンティティ

#### User (ユーザー)
```prisma
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  name          String
  role          Role
  organizationId String
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  organization  Organization @relation(fields: [organizationId], references: [id])

  @@index([organizationId])
  @@map("users")
}
```

**説明**: [エンティティの説明]

#### [その他のエンティティ]
[同様に記述]

### 3.3 データフロー
```
[データフローの図]

例:
User Input → Validation → Business Logic → Database → Cache → Response
```

### 3.4 データ保持ポリシー
| データ種別 | 保持期間 | 削除ポリシー |
|-----------|---------|-------------|
| ユーザーデータ | アカウント削除後30日 | [ポリシー] |
| ログデータ | 90日 | [ポリシー] |
| 分析データ | 1年 | [ポリシー] |

---

## 4. セキュリティアーキテクチャ

### 4.1 認証フロー
```
[認証フローの図]

例:
1. ユーザーログイン
2. Cognito認証
3. JWTトークン発行
4. セッション確立
5. アクセス
```

### 4.2 認可モデル
- **モデル**: [例: RBAC (Role-Based Access Control)]
- **役割定義**:
  | Role | 権限 | 説明 |
  |------|------|------|
  | ADMIN | 全権限 | [説明] |
  | MANAGER | [権限] | [説明] |
  | USER | [権限] | [説明] |

### 4.3 セキュリティ対策

#### OWASP Top 10への対策
| 脅威 | 対策 | 実装方法 |
|------|------|---------|
| Injection | 入力検証 | Zod, Prisma |
| Broken Authentication | MFA, セッション管理 | Cognito, NextAuth |
| XSS | エスケープ処理 | React auto-escape |
| CSRF | CSRFトークン | NextAuth built-in |

#### データ保護
- **暗号化**:
  - At Rest: [方法]
  - In Transit: TLS 1.3
- **個人情報保護**: [GDPR/個人情報保護法対応]

### 4.4 監査ログ
- **記録対象**: [操作、アクセス、変更]
- **保存期間**: [期間]
- **アクセス制御**: [誰がアクセスできるか]

---

## 5. パフォーマンスアーキテクチャ

### 5.1 パフォーマンス目標
| 指標 | 目標値 | 測定方法 |
|------|--------|---------|
| 初回ページロード | < 2秒 | Lighthouse |
| API応答時間 | < 500ms | Application Insights |
| Time to Interactive (TTI) | < 3秒 | Web Vitals |
| Largest Contentful Paint (LCP) | < 2.5秒 | Web Vitals |

### 5.2 最適化戦略

#### フロントエンド
- **コード分割**: [戦略]
- **画像最適化**: [方法]
- **キャッシング**: [戦略]
- **CDN活用**: [方法]

#### バックエンド
- **データベースクエリ最適化**: [戦略]
- **キャッシング**: Redis活用
- **非同期処理**: [方法]
- **コネクションプーリング**: [設定]

### 5.3 スケーラビリティ
- **水平スケーリング**: [戦略]
- **垂直スケーリング**: [戦略]
- **負荷分散**: [方法]
- **オートスケーリング**: [設定]

---

## 6. 可用性とレジリエンス

### 6.1 可用性目標
- **SLA (Service Level Agreement)**: 99.9% uptime
- **RTO (Recovery Time Objective)**: [時間]
- **RPO (Recovery Point Objective)**: [時間]

### 6.2 障害対策

#### 障害検知
- **監視ツール**: [ツール名]
- **アラート設定**: [設定]
- **ヘルスチェック**: [方法]

#### 障害復旧
- **バックアップ戦略**: [戦略]
- **復旧手順**: [手順]
- **フェイルオーバー**: [方法]

### 6.3 災害復旧計画
- **バックアップ**: [頻度、保管場所]
- **DR環境**: [構成]
- **復旧手順**: [リンク]

---

## 7. API設計

### 7.1 API規約
- **スタイル**: [REST / GraphQL]
- **バージョニング**: [方法]
- **エンドポイント命名**: [規約]

### 7.2 共通仕様

#### リクエスト
```typescript
// 共通ヘッダー
{
  "Authorization": "Bearer <token>",
  "Content-Type": "application/json",
  "X-Request-ID": "<uuid>"
}
```

#### レスポンス
```typescript
// 成功レスポンス
{
  "data": { ... },
  "meta": {
    "requestId": "uuid",
    "timestamp": "ISO8601"
  }
}

// エラーレスポンス
{
  "error": {
    "code": "ERROR_CODE",
    "message": "エラーメッセージ",
    "details": { ... }
  },
  "meta": {
    "requestId": "uuid",
    "timestamp": "ISO8601"
  }
}
```

### 7.3 エラーコード
| コード | HTTP Status | 説明 |
|--------|------------|------|
| AUTH_001 | 401 | 認証エラー |
| AUTH_002 | 403 | 権限エラー |
| VAL_001 | 400 | バリデーションエラー |
| SYS_001 | 500 | システムエラー |

### 7.4 レート制限
- **制限**: [リクエスト数/時間]
- **ヘッダー**: `X-RateLimit-*`
- **超過時**: 429 Too Many Requests

---

## 8. インテグレーション

### 8.1 外部サービス連携
| サービス | 用途 | API | 認証方式 |
|---------|------|-----|---------|
| [サービス1] | [用途] | [API] | [方式] |

### 8.2 Webhook
| イベント | URL | ペイロード |
|---------|-----|-----------|
| [イベント1] | [URL] | [構造] |

### 8.3 メッセージング
- **メッセージブローカー**: [ツール名]
- **トピック/キュー**: [構成]
- **メッセージ形式**: [フォーマット]

---

## 9. 監視とロギング

### 9.1 ロギング戦略
```typescript
// ログレベル
enum LogLevel {
  ERROR = 'error',   // エラー（即座に対応が必要）
  WARN = 'warn',     // 警告（注意が必要）
  INFO = 'info',     // 情報（重要なイベント）
  DEBUG = 'debug'    // デバッグ（開発時のみ）
}

// ログ構造
{
  level: LogLevel,
  timestamp: string,
  requestId: string,
  userId?: string,
  message: string,
  context: object,
  error?: Error
}
```

### 9.2 監視項目
| カテゴリ | 項目 | しきい値 | アクション |
|---------|------|---------|-----------|
| パフォーマンス | API応答時間 | > 1秒 | [アクション] |
| エラー | エラー率 | > 1% | [アクション] |
| リソース | CPU使用率 | > 80% | [アクション] |

### 9.3 分析とレポート
- **使用分析**: [ツール]
- **エラー追跡**: [ツール]
- **パフォーマンス分析**: [ツール]

---

## 10. デプロイメントアーキテクチャ

### 10.1 環境構成
| 環境 | 用途 | URL | デプロイ方法 |
|------|------|-----|-------------|
| Development | 開発 | [URL] | 自動 (main push) |
| Staging | 検証 | [URL] | 自動 (release branch) |
| Production | 本番 | [URL] | 手動承認後 |

### 10.2 CI/CDパイプライン
```
[CI/CDフロー図]

例:
Code Push → Lint → Test → Build → Deploy to Staging →
Manual Approval → Deploy to Production → Smoke Test
```

### 10.3 デプロイメント戦略
- **戦略**: [Blue-Green / Canary / Rolling]
- **ロールバック手順**: [手順]
- **ゼロダウンタイム**: [方法]

---

## 11. 技術的負債管理

### 11.1 既知の技術的負債
| 項目 | 影響度 | 対応計画 | 担当 | 期限 |
|------|--------|---------|------|------|
| [負債1] | High/Medium/Low | [計画] | [担当] | [期限] |

### 11.2 リファクタリング計画
- **Phase 1**: [内容]
- **Phase 2**: [内容]

---

## 12. 拡張性と将来計画

### 12.1 拡張ポイント
- [拡張ポイント1]: [説明]
- [拡張ポイント2]: [説明]

### 12.2 技術ロードマップ
| 時期 | 技術要素 | 目的 |
|------|---------|------|
| Q[x] YYYY | [技術要素] | [目的] |

---

## 13. 参考資料

### 13.1 技術ドキュメント
- [ドキュメント名] - [URL]

### 13.2 関連ドキュメント
- [Project Overview](/specs/PROJECT_OVERVIEW.md)
- [Development Standards](/specs/DEVELOPMENT_STANDARDS.md)

---

## 変更履歴

| バージョン | 日付 | 変更内容 | 変更者 |
|-----------|------|---------|--------|
| 1.0 | [日付] | 初版作成 | [名前] |
