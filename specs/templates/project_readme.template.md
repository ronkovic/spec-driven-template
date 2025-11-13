# [プロジェクト名]

> [プロジェクトの1行説明]

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue.svg)](https://www.typescriptlang.org/)
[![Next.js](https://img.shields.io/badge/Next.js-15-black.svg)](https://nextjs.org/)

## 🎯 プロジェクト概要

[プロジェクトの概要を2-3段落で説明]

### 主要機能

- 📝 **[機能1]** - [説明]
- 📊 **[機能2]** - [説明]
- 🎓 **[機能3]** - [説明]
- 👥 **[機能4]** - [説明]
- 💬 **[機能5]** - [説明]

## 📚 ドキュメント

| ドキュメント | 説明 |
|------------|------|
| [Project Overview](./docs/PROJECT_OVERVIEW.md) | プロジェクト概要・ビジネスモデル |
| [Technical Architecture](./docs/TECHNICAL_ARCHITECTURE.md) | 技術アーキテクチャ詳細 |
| [Development Standards](./docs/DEVELOPMENT_STANDARDS.md) | 開発標準・コーディング規約 |
| [Phase Plan](./docs/PHASE_PLAN.md) | フェーズ別実装計画 |
| [Workflow Guide](./docs/WORKFLOW_GUIDE.md) | 開発ワークフローガイド |

## 🏗️ システムアーキテクチャ

```
┌─────────────────────────────────────────────────────┐
│               フロントエンド層                        │
│  [フレームワーク] + [ライブラリ] + [スタイリング]      │
└────────────────────┬────────────────────────────────┘
                     │ API通信
┌────────────────────┴────────────────────────────────┐
│               バックエンド層                          │
│  [ランタイム] + [フレームワーク] + [ORM]              │
└────────────────────┬────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
┌──────────────┐ ┌──────────┐ ┌──────────────┐
│   [サービス1] │ │ [サービス2]│ │  [サービス3]  │
└──────┬───────┘ └────┬─────┘ └──────┬───────┘
       │              │              │
       ▼              ▼              ▼
┌──────────────────────────────────────────────┐
│           [データ層・外部サービス]              │
└──────────────────────────────────────────────┘
```

## 🚀 クイックスタート

### 前提条件

- Node.js 20.x 以上
- [データベース] 15.x 以上（例: PostgreSQL）
- [その他必要なツール]
- pnpm 8.x 以上（または npm/yarn）

### インストール

```bash
# リポジトリクローン
git clone https://github.com/[org]/[project-name].git
cd [project-name]

# 依存関係インストール
pnpm install

# 環境変数設定
cp .env.example .env.local
# .env.localを編集して必要な環境変数を設定

# データベースセットアップ
pnpm db:migrate
pnpm db:seed

# 開発サーバー起動
pnpm dev
```

アプリケーションは http://localhost:3000 で起動します。

### 環境変数

```bash
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/[db_name]"

# Authentication
NEXT_PUBLIC_[AUTH_PROVIDER]_PUBLISHABLE_KEY="pk_test_..."
[AUTH_PROVIDER]_SECRET_KEY="sk_test_..."

# API Keys
[API_PROVIDER]_API_KEY="..."

# その他の環境変数
[VARIABLE_NAME]="..."
```

詳細は `.env.example` を参照してください。

## 📦 プロジェクト構成

```
.
├── apps/
│   └── web/                    # Webアプリケーション
│       ├── app/               # App Router
│       ├── components/        # Reactコンポーネント
│       └── lib/               # ユーティリティ
├── packages/
│   ├── database/              # データベーススキーマ
│   ├── ui/                    # 共通UIコンポーネント
│   └── [その他のパッケージ]/
├── docs/                       # ドキュメント
├── specs/                      # 仕様書
│   ├── requirements/          # 要件定義
│   ├── technical/             # 技術仕様
│   ├── implementation/        # 実装ガイド
│   └── decisions/             # ADR
├── prisma/                     # データベーススキーマ
└── scripts/                    # ユーティリティスクリプト
```

## 🛠️ 技術スタック

### フロントエンド

- **Framework**: [フレームワーク名とバージョン]
- **Language**: TypeScript 5.3
- **Styling**: [スタイリング手法]
- **State Management**: [状態管理ライブラリ]
- **Form**: [フォームライブラリ]
- **UI Components**: [UIコンポーネントライブラリ]

### バックエンド

- **Runtime**: Node.js 20
- **Framework**: [フレームワーク名]
- **ORM**: [ORM名]
- **Validation**: [バリデーションライブラリ]
- **Auth**: [認証プロバイダー]

### データベース

- **Primary**: [データベース名とバージョン]
- **Cache**: [キャッシュシステム]（オプション）
- **Search**: [検索エンジン]（オプション）

### インフラ

- **Hosting**: [ホスティングプロバイダー]
- **Container**: Docker + [オーケストレーションツール]
- **CI/CD**: GitHub Actions
- **Monitoring**: [モニタリングツール]

## 🧪 開発

### コマンド

```bash
# 開発サーバー起動
pnpm dev

# ビルド
pnpm build

# 本番起動
pnpm start

# テスト
pnpm test              # 全テスト実行
pnpm test:watch        # Watch モード
pnpm test:coverage     # カバレッジ付き

# 型チェック
pnpm type-check

# Lint
pnpm lint              # Lintチェック
pnpm lint:fix          # 自動修正

# Format
pnpm format            # フォーマット実行
pnpm format:check      # フォーマットチェック

# データベース
pnpm db:migrate        # マイグレーション実行
pnpm db:studio         # データベースGUI起動
pnpm db:seed           # シードデータ投入
pnpm db:reset          # データベースリセット
```

### 開発ワークフロー

このプロジェクトは **Spec-Driven Development** を採用しています。

```bash
# 1. 新機能の要件定義
/add-requirements [feature-name]

# 2. 技術仕様作成
/add-technical [feature-name]

# 3. 実装ガイド作成
/add-implementation [feature-name]

# 4. 実装開始
/implement [feature-name]

# 5. 実装チェック
/check-implementation [feature-name]

# 6. スペック更新
/update-specs [feature-name]

# 7. コミット準備
/commit-prep
```

詳細は [WORKFLOW_GUIDE.md](./docs/WORKFLOW_GUIDE.md) を参照してください。

## 📊 主要機能の実装状況

| 機能 | ステータス | Phase | 備考 |
|-----|----------|-------|------|
| [機能1] | ✅ 完了 | Phase 1 | [備考] |
| [機能2] | 🚧 開発中 | Phase 1 | [備考] |
| [機能3] | 📋 計画中 | Phase 2 | [備考] |
| [機能4] | 📋 計画中 | Phase 2 | [備考] |
| [機能5] | 📋 計画中 | Phase 3 | [備考] |

凡例: ✅ 完了 | 🚧 開発中 | 📋 計画中

## 🔐 セキュリティ

- **認証**: [認証方式]
- **認可**: ロールベースアクセス制御 (RBAC)
- **暗号化**: [暗号化方式]
- **通信**: TLS 1.3
- **監査**: 全操作のログ記録

セキュリティに関する問題を発見した場合は、公開せずに [security@example.com] まで報告してください。

## 📈 ロードマップ

### Phase 1: MVP（完了予定: [YYYY-MM]）
- [ ] [マイルストーン1]
- [ ] [マイルストーン2]
- [ ] [マイルストーン3]

### Phase 2: [フェーズ名]（完了予定: [YYYY-MM]）
- [ ] [マイルストーン1]
- [ ] [マイルストーン2]
- [ ] [マイルストーン3]

### Phase 3: [フェーズ名]（完了予定: [YYYY-MM]）
- [ ] [マイルストーン1]
- [ ] [マイルストーン2]
- [ ] [マイルストーン3]

## 🤝 コントリビューション

コントリビューションを歓迎します！以下の手順でお願いします:

1. このリポジトリをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

### コントリビューションガイドライン

- コードは [Development Standards](./docs/DEVELOPMENT_STANDARDS.md) に従ってください
- プルリクエストには適切なテストを含めてください
- コミットメッセージは明確で説明的にしてください
- 新機能には必ずドキュメントを追加してください

詳細は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。

## 🧪 テスト

```bash
# 全テスト実行
pnpm test

# 特定のテストファイル実行
pnpm test src/services/user.service.test.ts

# カバレッジレポート生成
pnpm test:coverage
```

### テストカバレッジ目標

- **Statements**: 80%以上
- **Branches**: 75%以上
- **Functions**: 80%以上
- **Lines**: 80%以上

## 📝 ライセンス

このプロジェクトは [MIT License](./LICENSE) の下でライセンスされています。

## 👥 チーム

- **プロジェクトマネージャー**: [名前] - [@github](https://github.com/username)
- **リードエンジニア**: [名前] - [@github](https://github.com/username)
- **バックエンドエンジニア**: [名前] - [@github](https://github.com/username)
- **フロントエンドエンジニア**: [名前] - [@github](https://github.com/username)

## 📧 お問い合わせ

- **Email**: [email@example.com]
- **Website**: [https://example.com]
- **Slack**: [Slackワークスペースへのリンク]
- **GitHub Issues**: [Issue Tracker](https://github.com/[org]/[project-name]/issues)
- **GitHub Discussions**: [Discussions](https://github.com/[org]/[project-name]/discussions)

## 🙏 謝辞

- [使用している主要なライブラリ・フレームワーク]
- [参考にしたプロジェクト・リソース]
- [貢献者・スポンサー]

## 📚 その他のリソース

- [公式ドキュメント](https://docs.example.com)
- [APIドキュメント](https://api.example.com/docs)
- [ブログ記事](https://blog.example.com)
- [チュートリアル](https://tutorial.example.com)

---

**作成日**: [YYYY-MM-DD]
**最終更新**: [YYYY-MM-DD]
**バージョン**: 1.0.0
**ステータス**: [開発中 / ベータ / 本番稼働中]

Made with ❤️ by the [Team Name]
