# Template Setup Checklist

このドキュメントは、Spec-Driven Development Templateを新しいプロジェクトで使用する際のセットアップチェックリストです。

## ✅ 初期セットアップ

### 1. リポジトリのクローンと初期化

```bash
# このテンプレートをクローン
git clone https://github.com/your-org/spec-driven-template.git my-new-project
cd my-new-project

# 初期化スクリプトを実行（推奨）
./scripts/init.sh my-new-project

# または、Windowsの場合
# .\scripts\init.ps1 my-new-project
```

初期化スクリプトが以下を自動実行：
- ✅ Git履歴の削除
- ✅ 新しいリポジトリの初期化
- ✅ .gitignoreの作成
- ✅ 初回コミットの作成
- ✅ main branchの設定

### 2. ファイルの確認

#### 必須ファイル

- [ ] `README.md` - テンプレートの説明が記載されている
- [ ] `.claude/settings.local.json` - Claude Code設定ファイル
- [ ] `docs/WORKFLOW_GUIDE.md` - ワークフロー詳細ガイド
- [ ] `docs/WORKFLOW_STEPS_DETAIL.md` - ステップ別詳細説明
- [ ] `docs/SPEC_TEMPLATES_GUIDE.md` - テンプレート使用ガイド
- [ ] `docs/MCP_SETUP.md` - MCPセットアップガイド
- [ ] `docs/NAMING_CONVENTIONS.md` - 命名規則ガイド

#### スクリプト

- [ ] `scripts/init.sh` - Unix/Mac用初期化スクリプト
- [ ] `scripts/init.ps1` - Windows用初期化スクリプト

#### サンプルファイル（examples/）

- [ ] `sample-requirements.md` - 要件定義のサンプル
- [ ] `sample-technical.md` - 技術仕様のサンプル
- [ ] `sample-implementation.md` - 実装ガイドのサンプル
- [ ] `sample-workflow.md` - ワークフロー実行例

#### スラッシュコマンド（12個）

- [ ] `.claude/commands/init-project.md` - プロジェクト初期化
- [ ] `.claude/commands/review-specs.md` - スペックレビュー
- [ ] `.claude/commands/adjust-specs.md` - スペック調整
- [ ] `.claude/commands/add-requirements.md` - 要件定義追加
- [ ] `.claude/commands/add-technical.md` - 技術仕様追加
- [ ] `.claude/commands/add-implementation.md` - 実装ガイド追加
- [ ] `.claude/commands/spec-check.md` - スペックチェック
- [ ] `.claude/commands/implement.md` - 実装開始
- [ ] `.claude/commands/check-implementation.md` - 実装チェック
- [ ] `.claude/commands/update-specs.md` - スペック更新
- [ ] `.claude/commands/review.md` - コードレビュー
- [ ] `.claude/commands/commit-prep.md` - コミット準備

#### テンプレートファイル（8個）

プロジェクトレベル:
- [ ] `specs/templates/project_overview.template.md`
- [ ] `specs/templates/project_technical_architecture.template.md`
- [ ] `specs/templates/project_development_standards.template.md`
- [ ] `specs/templates/project_phase_plan.template.md`
- [ ] `specs/templates/project_readme.template.md`

機能レベル:
- [ ] `specs/templates/feature_requirements.template.md`
- [ ] `specs/templates/feature_technical.template.md`
- [ ] `specs/templates/feature_implementation.template.md`

#### ディレクトリ構造

- [ ] `specs/requirements/` - 要件定義を格納（空）
- [ ] `specs/technical/` - 技術仕様を格納（空）
- [ ] `specs/implementation/` - 実装ガイドを格納（空）
- [ ] `specs/decisions/` - ADRを格納（空）

### 3. Claude Codeのセットアップ

```bash
# Claude Codeがインストールされているか確認
claude --version

# スラッシュコマンドが認識されているか確認
ls -la .claude/commands/

# 12個のコマンドが存在することを確認
ls -la .claude/commands/ | grep -E "\.md$" | wc -l
# 出力: 12
```

### 4. プロジェクト固有の設定

以下のファイルをプロジェクトに合わせて編集:

- [ ] `README.md` - プロジェクト名、リポジトリURLを更新
- [ ] `.claude/settings.local.json` - 必要に応じて設定をカスタマイズ

### 5. 不要ファイルの削除

- [ ] `README.old.md` - テンプレートの古いREADME（削除推奨）
- [ ] `TEMPLATE_CHECKLIST.md` - このファイル（セットアップ完了後に削除）

```bash
# 不要ファイルを削除
rm README.old.md
rm TEMPLATE_CHECKLIST.md
```

## ✅ プロジェクト開始

### 1. プロジェクト初期化

```bash
# Claude Codeでプロジェクトを初期化
/init-project my-awesome-project
```

これにより以下が作成されます:
- `docs/PROJECT_OVERVIEW.md`
- `docs/TECHNICAL_ARCHITECTURE.md`
- `docs/DEVELOPMENT_STANDARDS.md`
- `docs/PHASE_PLAN.md`

### 2. スペックのレビューと調整

```bash
# スペックをレビュー
/review-specs project

# 必要に応じて調整
/adjust-specs project
```

### 3. 最初の機能を追加

```bash
# 要件定義から開始
/add-requirements user-authentication

# スペックチェック
/spec-check user-authentication

# 技術仕様作成
/add-technical user-authentication

# 実装ガイド作成
/add-implementation user-authentication

# 実装開始
/implement user-authentication
```

## ✅ 開発環境のセットアップ

### Node.js / TypeScriptプロジェクトの場合

```bash
# package.jsonを作成
npm init -y

# TypeScriptをインストール
npm install -D typescript @types/node

# TypeScript設定ファイルを作成
npx tsc --init

# ESLintをインストール
npm install -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin

# Prettierをインストール
npm install -D prettier eslint-config-prettier

# Jestをインストール（テスト）
npm install -D jest @types/jest ts-jest
```

### Next.jsプロジェクトの場合

```bash
# Next.jsプロジェクトを作成
npx create-next-app@latest . --typescript --tailwind --app --src-dir

# Prismaをインストール
npm install prisma @prisma/client
npx prisma init

# 追加の依存関係
npm install zod react-hook-form @hookform/resolvers
npm install -D @testing-library/react @testing-library/jest-dom
```

### Git設定

```bash
# .gitignoreを作成
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/
.nyc_output

# Next.js
.next/
out/
build/
dist/

# Environment
.env
.env*.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*

# Database
*.db
*.db-journal
EOF
```

## ✅ 品質ゲートの設定

### package.jsonにスクリプトを追加

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "type-check": "tsc --noEmit",
    "lint": "eslint . --ext .ts,.tsx",
    "lint:fix": "eslint . --ext .ts,.tsx --fix",
    "format": "prettier --write \"**/*.{ts,tsx,js,jsx,json,md}\"",
    "format:check": "prettier --check \"**/*.{ts,tsx,js,jsx,json,md}\"",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "db:seed": "ts-node prisma/seed.ts",
    "db:reset": "prisma migrate reset"
  }
}
```

### GitHub Actionsを設定（CI/CD）

`.github/workflows/ci.yml`:

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Type check
        run: npm run type-check

      - name: Lint
        run: npm run lint

      - name: Format check
        run: npm run format:check

      - name: Test
        run: npm run test:coverage

      - name: Build
        run: npm run build
```

## ✅ プロジェクト完了後の確認

開発を始める前に、以下を確認:

- [ ] すべてのテンプレートファイルが存在する（7個）
- [ ] すべてのスラッシュコマンドが動作する（12個）
- [ ] ドキュメントが読める（4個）
- [ ] Claude Codeが正しく設定されている
- [ ] Git履歴が新しくなっている
- [ ] README.mdが更新されている
- [ ] 開発環境がセットアップされている
- [ ] 品質ゲートスクリプトが設定されている

## 🎯 次のステップ

セットアップが完了したら:

1. **プロジェクトを初期化**
   ```bash
   /init-project your-project-name
   ```

2. **ワークフローガイドを読む**
   - [WORKFLOW_GUIDE.md](./docs/WORKFLOW_GUIDE.md)
   - [WORKFLOW_STEPS_DETAIL.md](./docs/WORKFLOW_STEPS_DETAIL.md)

3. **最初の機能を実装**
   - 要件定義 → 技術仕様 → 実装ガイド → 実装 → コミット

4. **チームメンバーに共有**
   - ワークフローの説明
   - スラッシュコマンドの使い方
   - 品質基準の共有

## 📚 リファレンス

- [README.md](./README.md) - テンプレート概要
- [WORKFLOW_GUIDE.md](./docs/WORKFLOW_GUIDE.md) - ワークフロー詳細
- [WORKFLOW_STEPS_DETAIL.md](./docs/WORKFLOW_STEPS_DETAIL.md) - ステップ別実践例
- [SPEC_TEMPLATES_GUIDE.md](./docs/SPEC_TEMPLATES_GUIDE.md) - テンプレート使用ガイド
- [MCP_SETUP.md](./docs/MCP_SETUP.md) - MCPセットアップ

---

**最終更新**: 2025-11-13
**バージョン**: 1.0
**ステータス**: 完成
