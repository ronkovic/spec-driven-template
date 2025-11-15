# Spec-Driven Development Template

A comprehensive template for building software projects using spec-driven development methodology with Claude Code and AI agents.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 概要

このテンプレートは、仕様駆動開発（Spec-Driven Development）を実践するための完全なワークフローとテンプレート集です。Claude Codeのスラッシュコマンドと統合され、ドキュメントファースト、テスト駆動、品質重視の開発を実現します。

### 主な特徴

- 📋 **11ステップのワークフロー** - プロジェクト初期化からコミットまでの完全な開発サイクル
- 📝 **包括的なテンプレート** - プロジェクトレベル＆機能レベルの仕様書テンプレート（11個）
- 🤖 **17のスラッシュコマンド** - 開発プロセスとメンテナンスを自動化
- ⭐ **レビュー管理システム（新機能）** - スペックレビュー結果の追跡と改善項目管理
- ✅ **品質ゲート** - テスト、型チェック、Lint、セキュリティチェックの自動実行
- 🎯 **TDD対応** - テスト駆動開発をサポート
- 📊 **ADR管理** - アーキテクチャ決定の記録
- 🔄 **自動メンテナンス** - テンプレート健全性チェックと更新管理システム

## クイックスタート

### 1. このテンプレートを使用

```bash
# このリポジトリをテンプレートとして使用
git clone https://github.com/your-org/spec-driven-template.git my-project
cd my-project

# 初期化スクリプトを実行（プロジェクト名を指定）
./scripts/init.sh my-awesome-project

# または、Windowsの場合
# .\scripts\init.ps1 my-awesome-project
```

初期化スクリプトが以下を実行：
- 既存のGit履歴を削除
- 新しいGitリポジトリとして初期化
- 初回コミットを作成
- 次のステップをガイド

### 2. プロジェクト初期化

```bash
# Claude Codeでプロジェクトスペックを作成
/init-project my-awesome-project
```

このコマンドが以下を作成します：
- `docs/PROJECT_OVERVIEW.md` - プロジェクト概要
- `docs/TECHNICAL_ARCHITECTURE.md` - 技術アーキテクチャ
- `docs/DEVELOPMENT_STANDARDS.md` - 開発標準
- `docs/PHASE_PLAN.md` - フェーズ別実装計画

### 3. スペックのレビューと調整

```bash
# スペックの包括的レビュー
/review-specs project

# 対話的な調整
/adjust-specs project
```

### 4. 最初の機能を実装（⭐ レビュー管理統合版）

```bash
# 要件定義から開始
/add-requirements user-authentication

# スペックの一貫性チェック
/spec-check user-authentication

# 技術仕様作成
/add-technical user-authentication

# 実装ガイド作成
/add-implementation user-authentication

# ⭐ 新機能: スペックレビューの実行
/review-specs user-authentication
# → レビュー結果が /specs/reviews/pending/ に保存される

# ⭐ 新機能: レビュー結果の確認
/review-actions user-authentication
# → 改善項目を優先度順に表示

# ⭐ 新機能: 重要な改善項目を先に実装（必要に応じて）
/implement-improvements encryption-key-management

# 実装開始（レビュー結果を自動参照）
/implement user-authentication
```

## ワークフロー

```
┌─────────────────────────────────────────────────────────────────┐
│              11ステップワークフロー（⭐ レビュー管理統合）              │
└─────────────────────────────────────────────────────────────────┘

1. プロジェクト初期化 (/init-project)
   └─> プロジェクトレベルの4つの仕様書を作成

2. スペックレビュー・調整 (/review-specs, /adjust-specs)
   └─> スコープ洗練、技術スタック検証、リスク軽減

3. 要件追加 (/add-requirements)
   └─> 新機能の要件定義を作成

4. スペック確認 (/spec-check)
   └─> 仕様の一貫性と完全性をチェック

5. 技術仕様追加 (/add-technical)
   └─> データモデル、API設計、セキュリティ設計

6. 実装ガイド作成 (/add-implementation)
   └─> フェーズ別の実装手順、完全なコード例

7. ⭐ スペックレビュー (/review-specs) 【新機能】
   └─> 3種のスペックを包括的にレビュー、改善項目を優先度別に分類

8. ⭐ レビュー結果確認 (/review-actions) 【新機能】
   └─> 改善項目を確認、対処方法を決定

9. ⭐ 改善項目実装 (/implement-improvements) 【新機能・条件付き】
   └─> Critical/Important項目を個別に実装

10. 実装 (/implement) ⭐ レビュー統合版
    └─> レビュー結果を自動参照、TDD方式で実装、Todo管理

11. 実装チェック (/check-implementation)
    └─> 品質ゲート（テスト、型、Lint）通過確認

12. スペック更新 (/update-specs)
    └─> 実装内容を仕様書に反映、ADR作成

13. コミット準備 (/commit-prep)
    └─> 最終チェック、コミットメッセージ生成（レビュー参照含む）
```

詳細な説明は [WORKFLOW_GUIDE.md](./docs/WORKFLOW_GUIDE.md) を参照してください。

## 利用可能なスラッシュコマンド

### プロジェクトレベル

| コマンド | 用途 | 所要時間 |
|---------|------|---------|
| `/init-project [name]` | プロジェクト初期化とスペック作成 | 5-10分 |
| `/review-specs [scope]` | スペックの包括的レビュー | 5-10分 |
| `/adjust-specs [scope]` | スペックの対話的調整 | 10-30分 |

### 機能レベル

| コマンド | 用途 | 所要時間 |
|---------|------|---------|
| `/add-requirements [feature]` | 要件定義作成 | 5-10分 |
| `/add-technical [feature]` | 技術仕様作成 | 5-10分 |
| `/add-implementation [feature]` | 実装ガイド作成 | 5-10分 |
| `/spec-check [feature]` | 仕様の一貫性チェック | 2-5分 |
| `/implement [feature]` | 実装開始（⭐ レビュー統合版） | 機能による |
| `/check-implementation [feature]` | 実装状況確認 | 2-5分 |
| `/update-specs [feature]` | スペック更新 | 5-10分 |

### ⭐ レビュー管理（新機能）

| コマンド | 用途 | 所要時間 |
|---------|------|---------|
| `/review-actions [feature]` | レビュー結果確認と改善項目管理 | 2-5分 |
| `/implement-improvements [improvement]` | 個別改善項目の段階的実装 | 項目による |

### コード品質

| コマンド | 用途 | 所要時間 |
|---------|------|---------|
| `/review [files]` | コードレビュー | 5-10分 |
| `/commit-prep` | コミット前チェック | 2-5分 |

## ディレクトリ構造

```
.
├── .claude/
│   └── commands/           # スラッシュコマンド定義
│       ├── init-project.md
│       ├── review-specs.md
│       ├── adjust-specs.md
│       ├── add-requirements.md
│       ├── add-technical.md
│       ├── add-implementation.md
│       ├── spec-check.md
│       ├── implement.md
│       ├── check-implementation.md
│       ├── update-specs.md
│       ├── review.md
│       ├── commit-prep.md
│       ├── ⭐ review-actions.md    # 新: レビュー結果確認
│       └── ⭐ implement-improvements.md  # 新: 改善項目実装
│
├── docs/                   # プロジェクトドキュメント
│   ├── WORKFLOW_GUIDE.md   # ワークフロー詳細ガイド
│   ├── WORKFLOW_STEPS_DETAIL.md  # 各ステップの詳細説明
│   ├── SPEC_TEMPLATES_GUIDE.md   # テンプレート使用ガイド
│   └── MCP_SETUP.md        # MCP (Model Context Protocol) セットアップ
│
├── specs/
│   ├── templates/          # スペックテンプレート集
│   │   ├── PROJECT_OVERVIEW.template.md
│   │   ├── TECHNICAL_ARCHITECTURE.template.md
│   │   ├── DEVELOPMENT_STANDARDS.template.md
│   │   ├── PHASE_PLAN.template.md
│   │   ├── requirements.template.md
│   │   ├── technical.template.md
│   │   ├── implementation.template.md
│   │   ├── ⭐ review_result.template.md     # 新: レビュー結果
│   │   ├── ⭐ improvement_item.template.md  # 新: 改善項目詳細
│   │   └── ⭐ minor_improvements.template.md # 新: Minor改善項目リスト
│   │
│   ├── requirements/       # 機能要件定義（実際のプロジェクトで作成）
│   ├── technical/          # 技術仕様（実際のプロジェクトで作成）
│   ├── implementation/     # 実装ガイド（実際のプロジェクトで作成）
│   ├── decisions/          # ADR (Architecture Decision Records)
│   │
│   ├── ⭐ reviews/         # レビュー管理（新機能）
│   │   ├── index.md       # レビューメトリクスと管理方法
│   │   ├── pending/       # 対応待ちレビュー結果
│   │   └── completed/     # 対応完了レビュー結果
│   │
│   └── ⭐ improvements/    # 改善項目管理（新機能）
│       ├── critical/      # 🔴 実装前に必須の改善項目
│       ├── important/     # 🟡 実装中に対処推奨の改善項目
│       ├── minor/         # 🟢 品質向上のための改善項目
│       └── archive/       # 対処完了の改善項目アーカイブ
│
└── README.md              # このファイル
```

## テンプレート一覧

### プロジェクトレベルテンプレート（5個）

#### 1. project_overview.template.md (2000+ lines)
プロジェクトの全体像を定義する包括的なテンプレート

**主要セクション**:
- エグゼクティブサマリー
- ビジネスコンテキスト（ビジョン、ミッション、ビジネスモデル）
- ステークホルダー分析
- スコープ定義（MVP、Phase別機能、スコープ外項目）
- 成功指標とKPI
- リスク管理
- 依存関係
- 予算計画
- コミュニケーション計画
- タイムライン

**使用タイミング**: プロジェクト開始時、`/init-project` コマンドで自動生成

#### 2. project_technical_architecture.template.md (2000+ lines)
技術的なアーキテクチャを詳細に定義

**主要セクション**:
- システムアーキテクチャ（システム構成図、コンポーネント図）
- 技術スタック（フロントエンド、バックエンド、インフラ）
- データモデル（ERD、Prismaスキーマ）
- セキュリティアーキテクチャ（認証/認可、暗号化、監査）
- パフォーマンス設計（キャッシング、最適化戦略）
- API設計（REST、GraphQL、エラーハンドリング）
- モニタリング・ログ戦略
- デプロイメント戦略（CI/CD、環境管理）

**使用タイミング**: プロジェクト開始時、`/init-project` コマンドで自動生成

#### 3. project_development_standards.template.md (1800+ lines)
開発標準とベストプラクティスを定義

**主要セクション**:
- コーディング規約（TypeScript、React、Node.js）
- テスト戦略（Unit、Integration、E2E）
- Gitワークフロー（ブランチ戦略、コミット規約）
- コードレビュープロセス
- 品質管理（静的解析、カバレッジ目標）
- セキュリティガイドライン
- CI/CDパイプライン
- ドキュメント規約

**使用タイミング**: プロジェクト開始時、`/init-project` コマンドで自動生成

#### 4. project_phase_plan.template.md (1700+ lines)
フェーズ別の実装計画を詳細に定義

**主要セクション**:
- タイムライン概要
- Phase別詳細計画（機能リスト、マイルストーン、リスク）
- リソース計画（チーム構成、役割分担）
- 予算配分
- 品質保証計画
- デプロイメント計画
- リスク管理計画
- コミュニケーション計画

**使用タイミング**: プロジェクト開始時、`/init-project` コマンドで自動生成

#### 5. project_readme.template.md
プロジェクトのREADMEファイルのテンプレート

**主要セクション**:
- プロジェクト概要
- 主要機能
- ドキュメント一覧
- システムアーキテクチャ
- クイックスタート（前提条件、インストール、環境変数）
- プロジェクト構成
- 技術スタック
- 開発コマンド
- 開発ワークフロー
- 主要機能の実装状況（ステータステーブル）
- セキュリティ
- ロードマップ（Phase別）
- コントリビューションガイドライン
- テスト
- チーム情報

**使用タイミング**:
- プロジェクト開始時、`/init-project` 実行後に手動でテンプレートをコピー
- 機能実装完了時、`/update-specs` コマンドで自動更新

### 機能レベルテンプレート（3個）

#### 6. feature_requirements.template.md
個別機能の要件を定義

**主要セクション**:
- 概要（目的、対象ユーザー）
- ビジネスコンテキスト（課題、ビジネス価値、成功指標）
- ユーザーストーリー（受入基準、優先度、工数見積）
- ユーザーペルソナ
- ロール定義（権限、制約）
- 機能要件（入力、処理、出力）
- 非機能要件（パフォーマンス、スケーラビリティ、可用性）
- セキュリティ要件（認証、認可、データ保護）
- UI要件（ワイヤーフレーム、UIフロー）
- データ要件（エンティティ、データ量、保持期間）
- 統合要件（外部システム、API）
- ビジネスルール
- エッジケース・エラーハンドリング

**使用タイミング**: 新機能追加時、`/add-requirements [feature-name]` で生成

#### 7. feature_technical.template.md
個別機能の技術仕様を定義

**主要セクション**:
- アーキテクチャ概要
- データモデル（Prismaスキーマ、マイグレーション戦略）
- API設計（エンドポイント、リクエスト/レスポンス、認証/認可）
- フロントエンドアーキテクチャ（コンポーネント構造、状態管理、ルーティング）
- バックエンドアーキテクチャ（Service層、Repository層、ビジネスロジック）
- セキュリティ設計（入力検証、SQLインジェクション対策、XSS対策）
- パフォーマンス設計（DBクエリ最適化、キャッシング、ページネーション）
- テスト戦略（Unit/Integration/E2Eテスト）
- エラーハンドリング（エラーコード、エラーレスポンス形式）
- デプロイメント考慮事項（環境変数、マイグレーション、モニタリング）

**使用タイミング**: 要件定義後、`/add-technical [feature-name]` で生成

#### 8. feature_implementation.template.md
実装手順を詳細に記述

**主要セクション**:
- 概要（前提条件、プロジェクト構造）
- Phase 1: Database & Data Models（30分-1時間）
  - Prismaスキーマ更新
  - マイグレーション実行
  - Repository/Validation層作成
- Phase 2: Business Logic & API Layer（2-3時間）
  - Service層実装
  - Server Actions実装
  - エラーハンドリング
- Phase 3: Frontend Components（2-3時間）
  - Pages作成
  - Client Components実装
  - Forms & Validation
- Phase 4: Testing & Documentation（1-2時間）
  - Unit Tests
  - Integration Tests
  - E2E Tests
  - ドキュメント更新
- コーディング標準
- テスト戦略
- デプロイチェックリスト
- トラブルシューティング

**使用タイミング**: 技術仕様後、`/add-implementation [feature-name]` で生成

### ⭐ レビュー管理テンプレート（3個・新機能）

#### 9. review_result.template.md
スペックレビューの結果を記録

**主要セクション**:
- メタデータ（レビュー日、スコア、レビュアー、対応状況）
- 総合評価（スコア、評価ランク、サマリー）
- 詳細スコア（Requirements、Technical、Implementationの各スコア）
- 課題サマリー（Critical/Important/Minorの項目数）
- 改善項目詳細（各項目のタイトル、優先度、期限、影響範囲）
- 次のステップ（推奨アクション、関連コマンド）

**使用タイミング**: `/review-specs [feature-name]` で自動生成

#### 10. improvement_item.template.md
個別の改善項目の詳細と実装ガイド

**主要セクション**:
- メタデータ（優先度、期限、担当、ステータス、関連レビュー）
- 概要（問題の説明、重要性、影響範囲）
- 関連スペック（対象機能、関連ドキュメント）
- 実装ガイド（仕様書更新、コード実装、テスト追加の各ステップ）
- コード例（具体的な実装コード）
- 完了条件（チェックリスト形式）
- 参考資料（関連ドキュメント、外部リンク）

**使用タイミング**: `/review-specs` で Important/Critical項目として自動生成

#### 11. minor_improvements_index.template.md
複数のMinor改善項目を一覧管理

**主要セクション**:
- 概要
- 改善項目リスト（各項目の説明、影響、推奨対応時期、優先度）
- 対応状況テーブル（項目、ステータス、対応日、担当）

**使用タイミング**: `/review-specs` でMinor項目として自動生成

## ベストプラクティス

### 1. ドキュメントファースト

```bash
# ❌ Bad: いきなり実装
# コードを書き始める

# ✅ Good: 仕様から始める
/add-requirements user-login
/spec-check user-login
/add-technical user-login
/add-implementation user-login
/implement user-login
```

### 2. 小さく・頻繁に

大きな機能は分割して実装：

```bash
# Phase 1: 基本機能
/add-requirements basic-user-auth
/implement basic-user-auth
/commit-prep

# Phase 2: 拡張機能
/add-requirements social-login
/implement social-login
/commit-prep
```

### 3. テスト駆動開発（TDD）

```typescript
// 1. テストを先に書く
describe('UserService', () => {
  it('should create user with valid data', async () => {
    const result = await service.create(validData);
    expect(result).toBeDefined();
  });
});

// 2. 実装する
class UserService {
  async create(data: CreateUserInput) {
    // 実装
  }
}

// 3. テストを実行
// npm run test
```

### 4. 品質ゲートを守る

```bash
# コミット前に必ず実行
/commit-prep

# 品質ゲートチェック:
# ✅ テスト合格
# ✅ 型チェック合格
# ✅ Lint合格
# ✅ フォーマット済み
# ✅ スペック更新済み
# ✅ セキュリティチェック済み
```

### 5. ADRで決定を記録

重要なアーキテクチャ決定は必ずADRに記録：

```markdown
# ADR 001: データベースにPostgreSQLを採用

## Status
Accepted

## Context
スケーラビリティとデータ整合性が重要

## Decision
PostgreSQL 15を採用

## Consequences
### Positive
- ACIDトランザクション
- 豊富な拡張機能
- JSON型サポート

### Negative
- セットアップコストがMySQLより高い
```

## 推奨技術スタック

このテンプレートは以下の技術スタックに最適化されていますが、他の技術でも使用可能です：

### フロントエンド
- Next.js 15 (App Router)
- TypeScript 5.3+
- React 18+
- TailwindCSS 3.4
- Shadcn/ui
- React Hook Form + Zod

### バックエンド
- Node.js 20+
- TypeScript 5.3+
- Prisma ORM
- PostgreSQL 15+
- Redis 7+ (キャッシュ)

### テスト
- Jest (Unit Testing)
- Playwright (E2E Testing)
- Testing Library (Component Testing)

### インフラ
- Docker
- GitHub Actions (CI/CD)
- Vercel / AWS / GCP

## 学習リソース

### 公式ドキュメント

- [ワークフロー詳細ガイド](./docs/WORKFLOW_GUIDE.md) - 11ステップワークフローの詳細
- [ステップ別詳細説明](./docs/WORKFLOW_STEPS_DETAIL.md) - 各ステップの実践例
- [テンプレート使用ガイド](./docs/SPEC_TEMPLATES_GUIDE.md) - テンプレートの使い方
- [MCPセットアップ](./docs/MCP_SETUP.md) - Model Context Protocol セットアップ
- [メンテナンスガイド](./docs/MAINTENANCE.md) - テンプレートの保守と更新方法

### 実践例

1. **プロジェクト初期化**
   ```bash
   /init-project e-commerce-platform
   ```

2. **最初の機能実装**
   ```bash
   /add-requirements user-authentication
   /spec-check user-authentication
   /add-technical user-authentication
   /add-implementation user-authentication
   /implement user-authentication
   /check-implementation user-authentication
   /update-specs user-authentication
   /commit-prep
   ```

3. **スペックレビューと調整**
   ```bash
   /review-specs project
   /adjust-specs project
   ```

## トラブルシューティング

### Q: `/init-project` でエラーが出る

**A**: Claude Codeが正しくインストールされているか確認してください。

```bash
# Claude Codeのバージョン確認
claude --version

# スラッシュコマンドが認識されているか確認
ls -la .claude/commands/
```

### Q: テンプレートが見つからない

**A**: `specs/templates/` ディレクトリが存在するか確認してください。

```bash
# テンプレートディレクトリの確認
ls -la specs/templates/
```

### Q: `/spec-check` で多数のエラーが出る

**A**: 仕様が不完全または矛盾している可能性があります。エラーメッセージを1つずつ確認し、要件定義から見直してください。

### Q: 品質ゲートで失敗する

**A**: `/commit-prep` の出力を確認し、失敗した項目を修正してください。

```bash
# テストエラーの場合
npm run test

# 型エラーの場合
npm run type-check

# Lintエラーの場合
npm run lint
```

## テンプレートのメンテナンス

このテンプレート自体も継続的に進化しています。定期的な更新とメンテナンスが可能です。

### 健全性チェック

```bash
# テンプレートの健全性を確認（月1回推奨）
/check-template-health
```

このコマンドは以下をチェック:
- Claude Codeとの互換性
- 依存関係の更新状況
- セキュリティ脆弱性
- ドキュメントの最新性
- 総合的な健全性スコア（0-100）

### 更新スキャン

```bash
# 外部環境の変更を詳細にスキャン
/template-update-scan
```

以下を分析して更新計画を提案:
- Claude Codeの新機能
- Node.js/TypeScript/Next.jsのアップデート
- ベストプラクティスの進化
- セキュリティアップデート

### テンプレート更新のワークフロー

#### テンプレートリポジトリのメンテナンス（テンプレート開発者向け）

```bash
# 1. 更新ブランチを作成
git checkout main
git pull origin main
git checkout -b template-update/v1.x

# 2. 詳細スキャンを実行
/template-update-scan

# 3. 推奨される更新を実施
# [更新作業: 依存関係、ドキュメント、テンプレートファイルなど]

# 4. マージ準備（クリーンアップと検証）
/merge-template-update

# 5. CHANGELOGを更新
# CHANGELOG.mdに変更内容を記録

# 6. mainにマージ
git checkout main
git merge template-update/v1.x

# 7. バージョンタグを作成
git tag -a v1.x.0 -m "Release v1.x.0"

# 8. GitHubにプッシュ
git push origin main --tags

# 9. ローカルの更新ブランチを削除
git branch -d template-update/v1.x
```

#### プロジェクトでテンプレートの最新版を取得（プロジェクト利用者向け）

テンプレートから作成したプロジェクトで、テンプレートの最新版を取り込む方法:

```bash
# 1. テンプレートリポジトリをリモートに追加（初回のみ）
git remote add template https://github.com/ronkovic/spec-driven-template.git

# 2. テンプレートの最新版を取得
git fetch template

# 3. 変更内容を確認
git log HEAD..template/main --oneline

# 4. テンプレートの更新をマージ
git merge template/main

# 5. 競合があれば解決
# プロジェクト固有のファイルとテンプレートファイルの競合を解決

# 6. マージをコミット
git commit -m "chore: update from template v1.x.0"

# 7. リモートにプッシュ
git push origin main
```

**注意事項:**
- プロジェクト固有の変更（docs/PROJECT_OVERVIEW.md など）は上書きされないように注意
- 競合が発生した場合は、プロジェクトの変更を優先
- `.template-config.json` は削除または `repository` フィールドを変更すること

詳細は [メンテナンスガイド](./docs/MAINTENANCE.md) を参照してください。

## コントリビューション

このテンプレートへの貢献を歓迎します！

詳細は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。

## ライセンス

MIT License - 詳細は [LICENSE](./LICENSE) を参照してください。

## サポート

- **GitHub Issues**: [Issue Tracker](https://github.com/ronkovic/spec-driven-template/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ronkovic/spec-driven-template/discussions)
- **Documentation**: [メンテナンスガイド](./docs/MAINTENANCE.md)

## 変更履歴

変更履歴の詳細は [CHANGELOG.md](./CHANGELOG.md) を参照してください。

## 謝辞

- [Claude Code](https://claude.ai/claude-code) - AI駆動開発ツール
- [Anthropic](https://www.anthropic.com/) - Claude AI
- Spec-Driven Development コミュニティ

---

**作成日**: 2025-11-13
**最終更新**: 2025-11-14
**現在のバージョン**: 1.1.0
**メンテナンス**: Active

Made with ❤️ using Spec-Driven Development
