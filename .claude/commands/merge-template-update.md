---
description: 更新ブランチをmainにマージする前のクリーンアップと検証
tags: [maintenance, template, project]
---

# Merge Template Update

このコマンドは、テンプレート更新ブランチをmainブランチにマージする前に、プロジェクト固有ファイルの削除、テンプレート必須ファイルの確認、およびクリーンアップを実行します。

## IMPORTANT: Output Language
**All output must be in Japanese (日本語).**

## 実行内容

### Step 1: 現在のブランチ確認

```bash
# 現在のブランチが template-update/* であることを確認
git branch --show-current
```

以下以外のブランチでは実行を中止:
- `template-update/*`
- `feature/*`
- `fix/*`

mainブランチでは実行不可:
```
エラー: このコマンドはmainブランチでは実行できません。
更新用ブランチ（template-update/*）に切り替えてください。
```

### Step 2: .template-ignore の読み込み

`.template-ignore` ファイルを読み込み、削除対象のパターンを取得:

```gitignore
# プロジェクト固有ファイル（テンプレートに含めない）
.env
.env.local
.env.*.local
*.log
build/
dist/
coverage/
.next/
out/

# 開発時のみ使用
.vscode/
.idea/
*.swp
*.swo

# ローカル設定
.claude/settings.local.json
.mcp.json
.kiri/

# テスト・ビルド成果物
node_modules/
.turbo/
.vercel/

# データベース
*.db
*.db-journal
prisma/migrations/

# 一時ファイル
tmp/
temp/
*.tmp

# プロジェクト固有ドキュメント
docs/PROJECT_OVERVIEW.md
docs/TECHNICAL_ARCHITECTURE.md
docs/DEVELOPMENT_STANDARDS.md
docs/PHASE_PLAN.md

# 機能スペック
specs/requirements/*.md
specs/technical/*.md
specs/implementation/*.md
specs/decisions/*.md

# 除外: .gitkeepは保持
!**/.gitkeep

# 内部検証ドキュメント
*_READY.md
*_VERIFICATION.md
PLANNING_*.md
```

### Step 3: 削除対象ファイルのスキャン

Glob toolを使用して削除対象ファイルを検出:

```typescript
interface FileScanResult {
  toDelete: string[];        // 削除対象
  toKeep: string[];          // 保持すべきファイル
  suspicious: string[];      // 要確認ファイル
  gitkeep: string[];        // .gitkeep ファイル（保持）
}
```

#### 3.1 自動削除可能なファイル

以下のパターンに一致するファイルは自動削除:
- `.env*` (`.env.example`を除く)
- `*.log`
- `build/`, `dist/`, `coverage/`, `.next/`, `out/`
- `.vscode/`, `.idea/`, `*.swp`, `*.swo`
- `.claude/settings.local.json`
- `.mcp.json` (`.mcp.json.example`を除く)
- `.kiri/`
- `node_modules/`
- `*_READY.md`, `*_VERIFICATION.md`, `PLANNING_*.md`

#### 3.2 要確認ファイル

以下のファイルは手動確認が必要:
- プロジェクト固有のドキュメント（PROJECT_OVERVIEW.mdなど）
- 機能スペック（requirements/, technical/, implementation/ 内の.mdファイル）
- カスタムスクリプトやツール
- 設定ファイルの差分

### Step 4: テンプレート必須ファイルの確認

以下のファイルが存在することを確認:

#### 4.1 スラッシュコマンド（15個）

```
.claude/commands/
├── add-implementation.md
├── add-requirements.md
├── add-technical.md
├── adjust-specs.md
├── check-implementation.md
├── check-template-health.md      ← 新規
├── commit-prep.md
├── implement.md
├── init-project.md
├── merge-template-update.md      ← 新規
├── review-specs.md
├── review.md
├── spec-check.md
├── template-update-scan.md       ← 新規
└── update-specs.md
```

#### 4.2 テンプレートファイル（8個）

```
specs/templates/
├── feature_implementation.template.md
├── feature_requirements.template.md
├── feature_technical.template.md
├── project_development_standards.template.md
├── project_overview.template.md
├── project_phase_plan.template.md
├── project_readme.template.md
└── project_technical_architecture.template.md
```

#### 4.3 スクリプト（2個）

```
scripts/
├── init.sh
└── init.ps1
```

#### 4.4 サンプルファイル（4個）

```
examples/
├── sample-implementation.md
├── sample-requirements.md
├── sample-technical.md
└── sample-workflow.md
```

#### 4.5 ドキュメント（7個）

```
docs/
├── MAINTENANCE.md               ← 新規
├── MCP_SETUP.md
├── NAMING_CONVENTIONS.md
├── SPEC_TEMPLATES_GUIDE.md
├── WORKFLOW_GUIDE.md
└── WORKFLOW_STEPS_DETAIL.md

Root:
├── README.md
├── CHANGELOG.md                 ← 新規
├── CONTRIBUTING.md
├── LICENSE
└── TEMPLATE_CHECKLIST.md
```

#### 4.6 設定ファイル

```
Root:
├── .gitignore
├── .template-config.json        ← 新規
├── .template-ignore             ← 新規
├── .env.example
└── .mcp.json.example
```

#### 4.7 空ディレクトリ（.gitkeep）

```
specs/
├── decisions/.gitkeep
├── implementation/.gitkeep
├── requirements/.gitkeep
└── technical/.gitkeep
```

### Step 5: .gitignore の検証

`.gitignore` に以下のパターンが含まれていることを確認:

```gitignore
# 必須パターン
node_modules/
.env
.env.local
*.log
build/
dist/
.next/
.claude/settings.local.json
.mcp.json
.kiri/
*_READY.md
*_VERIFICATION.md
```

不足しているパターンがあれば追加を提案。

### Step 6: バージョン情報の更新

#### 6.1 .template-config.json の更新

```json
{
  "version": "1.1.0",
  "lastUpdated": "2025-11-14",
  "claudeCodeVersion": "1.0.0",
  // ... 他のフィールド
  "updateHistory": [
    {
      "version": "1.1.0",
      "date": "2025-11-14",
      "changes": [
        "Add template maintenance commands",
        "Add health check system",
        "Update documentation"
      ]
    }
  ]
}
```

#### 6.2 CHANGELOG.md の更新

バージョン番号と変更内容を追記:

```markdown
## [1.1.0] - 2025-11-14

### Added
- テンプレートヘルスチェック機能 (`/check-template-health`)
- 更新スキャン機能 (`/template-update-scan`)
- マージ準備コマンド (`/merge-template-update`)
- メンテナンスガイド (`MAINTENANCE.md`)

### Changed
- README.mdにメンテナンス情報を追加
```

#### 6.3 各ドキュメントの日付更新

以下のファイルの「最終更新」フィールドを更新:
- README.md
- TEMPLATE_CHECKLIST.md
- docs/*.md

### Step 7: クリーンアップの実行

TodoWrite toolを使用してタスクを管理:

```javascript
[
  {
    content: "削除対象ファイルのバックアップ確認",
    status: "in_progress",
    activeForm: "バックアップを確認中"
  },
  {
    content: "プロジェクト固有ファイルの削除",
    status: "pending",
    activeForm: "ファイルを削除中"
  },
  {
    content: "テンプレート必須ファイルの検証",
    status: "pending",
    activeForm: "必須ファイルを検証中"
  },
  {
    content: ".gitignoreの更新",
    status: "pending",
    activeForm: ".gitignoreを更新中"
  },
  {
    content: "バージョン情報の更新",
    status: "pending",
    activeForm: "バージョン情報を更新中"
  }
]
```

#### 7.1 ファイル削除の実行

Bash toolを使用して削除:

```bash
# 例: プロジェクト固有ドキュメントの削除
rm -f docs/PROJECT_OVERVIEW.md
rm -f docs/TECHNICAL_ARCHITECTURE.md
rm -f docs/DEVELOPMENT_STANDARDS.md
rm -f docs/PHASE_PLAN.md

# 例: 機能スペックの削除（.gitkeepは保持）
find specs/requirements -name "*.md" -type f -delete
find specs/technical -name "*.md" -type f -delete
find specs/implementation -name "*.md" -type f -delete
find specs/decisions -name "*.md" -type f -delete

# 例: ローカル設定ファイルの削除
rm -f .claude/settings.local.json
rm -f .mcp.json
rm -rf .kiri/
```

### Step 8: 最終検証

#### 8.1 Git statusの確認

```bash
git status
```

予期しない変更がないか確認。

#### 8.2 健全性チェックの実行

```bash
/check-template-health
```

スコアが90以上であることを確認。

### Step 9: レポート生成

```markdown
# Merge Template Update Report

**実行日時**: YYYY-MM-DD HH:MM:SS
**ブランチ**: template-update/v1.1
**次期バージョン**: v1.1.0

## ✅ 削除されたファイル

### プロジェクト固有ドキュメント
- docs/PROJECT_OVERVIEW.md
- docs/TECHNICAL_ARCHITECTURE.md
- docs/DEVELOPMENT_STANDARDS.md
- docs/PHASE_PLAN.md

### 機能スペック
- specs/requirements/*.md (4ファイル)
- specs/technical/*.md (3ファイル)
- specs/implementation/*.md (2ファイル)

### ローカル設定
- .claude/settings.local.json
- .mcp.json
- .kiri/ (ディレクトリ)

### 一時ファイル
- *_READY.md (1ファイル)
- *_VERIFICATION.md (1ファイル)

**合計**: 15ファイル削除

## ✅ 保持されたファイル

### テンプレートコア（必須）
- スラッシュコマンド: 15/15 ✅
- テンプレートファイル: 8/8 ✅
- スクリプト: 2/2 ✅
- サンプル: 4/4 ✅
- ドキュメント: 7/7 ✅
- 設定ファイル: 5/5 ✅
- .gitkeep: 4/4 ✅

**合計**: 45ファイル保持

## 🔄 更新されたファイル

- .template-config.json (v1.0.0 → v1.1.0)
- CHANGELOG.md (v1.1.0エントリ追加)
- README.md (メンテナンス情報追加)
- .gitignore (パターン追加)

## 📊 最終健全性チェック

| カテゴリ | スコア | 状態 |
|---------|--------|------|
| 構造の完全性 | 100/100 | ✅ 優秀 |
| 互換性 | 95/100 | ✅ 優秀 |
| ドキュメント品質 | 95/100 | ✅ 優秀 |
| セキュリティ | 100/100 | ✅ 優秀 |
| 最新性 | 100/100 | ✅ 優秀 |
| **総合スコア** | **98/100** | **✅ 優秀** |

## ✅ マージ準備完了

このブランチはmainにマージする準備ができています。

## 📋 Next Actions

1. **変更のレビュー**
   ```bash
   git diff main
   ```

2. **コミット**
   ```bash
   git add .
   git commit -m "chore: prepare template v1.1.0 for merge

   - Add template maintenance commands
   - Remove project-specific files
   - Update version to 1.1.0"
   ```

3. **mainブランチにマージ**
   ```bash
   git checkout main
   git merge template-update/v1.1
   ```

4. **リモートにプッシュ**
   ```bash
   git push origin main
   ```

5. **タグ付け**
   ```bash
   git tag v1.1.0
   git push origin v1.1.0
   ```

6. **更新ブランチの削除**
   ```bash
   git branch -d template-update/v1.1
   ```

---

**マージ準備完了**: すべてのチェックが正常に完了しました。上記の手順でmainブランチにマージしてください。
```

## 使用例

```bash
# 基本的な使用
/merge-template-update

# ドライラン（削除せずにレポートのみ）
/merge-template-update --dry-run

# 対話モード（各削除を確認）
/merge-template-update --interactive
```

## Notes

- このコマンドはファイルを削除します（慎重に実行）
- 実行前にGitコミットでバックアップを作成することを推奨
- mainブランチでは実行できません
- 実行時間: 約2-3分
- 削除されたファイルはGit履歴から復元可能

## 安全機能

1. **ブランチチェック**: mainブランチでは実行不可
2. **必須ファイル保護**: テンプレートに必須のファイルは削除されない
3. **.gitkeep保護**: 空ディレクトリの.gitkeepは保持
4. **確認プロンプト**: 重要な削除前に確認を求める
5. **ドライランモード**: 実際に削除せずに確認可能
