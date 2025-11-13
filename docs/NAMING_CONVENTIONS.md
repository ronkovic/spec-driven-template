# Naming Conventions（命名規則）

このドキュメントでは、プロジェクト全体で使用する命名規則を定義します。

## 基本原則

1. **一貫性**: 同じ種類のファイルには同じ命名パターンを使用
2. **可読性**: ファイル名から内容が推測できること
3. **検索性**: ファイル名でgrepやfind検索がしやすいこと
4. **階層性**: ディレクトリ構造で論理的な分類を表現

---

## ディレクトリ構造と命名規則

```
project-root/
├── .claude/
│   ├── commands/          # スラッシュコマンド（kebab-case）
│   └── skills/            # スキル（kebab-case）
├── docs/                  # プロジェクトドキュメント（SCREAMING_SNAKE_CASE）
├── specs/
│   ├── templates/         # テンプレート（詳細は下記）
│   ├── requirements/      # 要件定義（kebab-case）
│   ├── technical/         # 技術仕様（kebab-case）
│   ├── implementation/    # 実装ガイド（kebab-case）
│   └── decisions/         # ADR（詳細は下記）
├── src/                   # ソースコード（プロジェクト依存）
└── README.md              # プロジェクトREADME（SCREAMING_SNAKE_CASE）
```

---

## 詳細な命名規則

### 1. スラッシュコマンド（`.claude/commands/`）

**形式**: `kebab-case.md`

**規則**:
- 小文字のみ
- 単語区切りはハイフン（-）
- 動詞で始める
- `.md` 拡張子

**例**:
```
✅ add-requirements.md
✅ spec-check.md
✅ commit-prep.md
✅ update-specs.md
❌ AddRequirements.md
❌ spec_check.md
❌ commitPrep.md
```

---

### 2. スキル（`.claude/skills/`）

**形式**: `kebab-case.md`

**規則**:
- 小文字のみ
- 単語区切りはハイフン（-）
- 名詞または動詞+名詞
- `.md` 拡張子

**例**:
```
✅ prisma-migration.md
✅ api-endpoint.md
✅ test-generation.md
❌ PrismaMigration.md
❌ api_endpoint.md
```

---

### 3. プロジェクトドキュメント（`docs/`）

**形式**: `SCREAMING_SNAKE_CASE.md`

**規則**:
- 大文字のみ
- 単語区切りはアンダースコア（_）
- 内容を表す名詞または名詞句
- `.md` 拡張子

**例**:
```
✅ WORKFLOW_GUIDE.md
✅ NAMING_CONVENTIONS.md
✅ MCP_SETUP.md
✅ SPEC_TEMPLATES_GUIDE.md
❌ workflow-guide.md
❌ NamingConventions.md
❌ mcp-setup.md
```

**理由**:
- プロジェクト全体の重要なドキュメントであることを強調
- ルートの `README.md` や `LICENSE` と同じ命名パターン

---

### 4. テンプレートファイル（`specs/templates/`）

**形式**: `{scope}_{name}.template.md`

#### 4.1. プロジェクトレベルテンプレート

**形式**: `project_{name}.template.md`

**規則**:
- プレフィックス: `project_`
- 名前部分: `SCREAMING_SNAKE_CASE`
- サフィックス: `.template.md`

**例**:
```
✅ project_overview.template.md
✅ project_technical_architecture.template.md
✅ project_development_standards.template.md
✅ project_phase_plan.template.md
✅ project_readme.template.md
❌ PROJECT_OVERVIEW.template.md
❌ project-overview.template.md
❌ projectOverview.template.md
```

#### 4.2. 機能レベルテンプレート

**形式**: `feature_{name}.template.md`

**規則**:
- プレフィックス: `feature_`
- 名前部分: `snake_case`
- サフィックス: `.template.md`

**例**:
```
✅ feature_requirements.template.md
✅ feature_technical.template.md
✅ feature_implementation.template.md
❌ requirements.template.md
❌ feature-requirements.template.md
❌ featureRequirements.template.md
```

**理由**:
- プレフィックスでスコープを明示
- テンプレート一覧でソートされた時に分類がわかりやすい
- `ls` や `find` で簡単に検索できる

---

### 5. 機能スペック（`specs/requirements/`, `specs/technical/`, `specs/implementation/`）

**形式**: `kebab-case.md`

**規則**:
- 小文字のみ
- 単語区切りはハイフン（-）
- 機能名を表す名詞または名詞句
- `.md` 拡張子

**例**:
```
✅ user-authentication.md
✅ report-comments.md
✅ multi-tenant-auth.md
✅ daily-reflection-agent.md
❌ UserAuthentication.md
❌ user_authentication.md
❌ userAuth.md
```

**理由**:
- URL フレンドリー
- 機能名として自然
- コマンドラインで入力しやすい

---

### 6. ADR（Architecture Decision Records）（`specs/decisions/`）

**形式**: `adr-{number}-{title}.md`

**規則**:
- プレフィックス: `adr-`
- 番号: 3桁のゼロ埋め（001, 002, ...）
- タイトル: `kebab-case`
- `.md` 拡張子

**例**:
```
✅ adr-001-use-postgresql.md
✅ adr-002-implement-rbac.md
✅ adr-003-add-comment-mentions.md
❌ ADR-001-use-postgresql.md
❌ adr_001_use_postgresql.md
❌ 001-use-postgresql.md
```

**理由**:
- ADRの標準的な命名パターン
- 番号で時系列が明確
- プレフィックスで種類が明確

---

### 7. ルートレベルファイル

**形式**: `SCREAMING_SNAKE_CASE.md` または `PascalCase.md`

**規則**:
- プロジェクト重要ファイル: `SCREAMING_SNAKE_CASE.md`
- 一般的な標準ファイル: `PascalCase.md`

**例**:
```
✅ README.md              # 標準
✅ LICENSE                # 標準
✅ CHANGELOG.md           # 標準
✅ CONTRIBUTING.md        # 標準
✅ TEMPLATE_CHECKLIST.md  # プロジェクト固有
❌ readme.md
❌ template-checklist.md
```

---

### 8. ソースコード（`src/`, `apps/`, `packages/`）

**TypeScript/JavaScript**:
- ファイル: `kebab-case.ts`, `kebab-case.tsx`
- クラス: `PascalCase`
- 関数/変数: `camelCase`
- 定数: `SCREAMING_SNAKE_CASE`
- 型: `PascalCase`

**例**:
```typescript
// ファイル: user-service.ts
export const API_ENDPOINT = 'https://api.example.com';

export class UserService {
  private readonly repositoryName: string;

  async getUser(userId: string): Promise<User> {
    // ...
  }
}

export type UserRole = 'ADMIN' | 'USER';
```

**ディレクトリ**:
- コンポーネント: `PascalCase/` または `kebab-case/`
- その他: `kebab-case/`

**例**:
```
src/
├── components/
│   ├── UserProfile/        # コンポーネント（PascalCase）
│   │   ├── index.tsx
│   │   └── UserProfile.test.tsx
│   └── button/             # または kebab-case
│       └── Button.tsx
├── services/
│   └── user-service.ts     # サービス（kebab-case）
└── utils/
    └── date-formatter.ts   # ユーティリティ（kebab-case）
```

---

## 命名規則の比較表

| 種類 | 形式 | 例 |
|------|------|-----|
| スラッシュコマンド | `kebab-case.md` | `add-requirements.md` |
| スキル | `kebab-case.md` | `api-endpoint.md` |
| プロジェクトドキュメント | `SCREAMING_SNAKE_CASE.md` | `WORKFLOW_GUIDE.md` |
| プロジェクトテンプレート | `project_{name}.template.md` | `project_overview.template.md` |
| 機能テンプレート | `feature_{name}.template.md` | `feature_requirements.template.md` |
| 機能スペック | `kebab-case.md` | `user-authentication.md` |
| ADR | `adr-{number}-{title}.md` | `adr-001-use-postgresql.md` |
| ルートファイル | `SCREAMING_SNAKE_CASE.md` | `README.md` |
| TypeScriptファイル | `kebab-case.ts` | `user-service.ts` |

---

## 命名規則チェックリスト

新しいファイルを作成する前に：

- [ ] ファイルの種類を確認（コマンド/ドキュメント/スペック/コード）
- [ ] 該当する命名規則を確認
- [ ] 既存の同種ファイルの命名を参考にする
- [ ] 命名規則に従っているか確認
- [ ] 意味が明確で検索しやすいか確認

---

## 既存ファイルのリネーム

既存のファイルが命名規則に従っていない場合は、以下の手順でリネーム：

```bash
# 1. Gitでファイルをリネーム
git mv old-name.md new-name.md

# 2. ファイル内の参照を更新
grep -r "old-name.md" . --exclude-dir=node_modules --exclude-dir=.git

# 3. 変更をコミット
git add .
git commit -m "Rename: Apply naming conventions to [file-type]"
```

---

## よくある質問

### Q: なぜテンプレートファイルだけ異なる規則なのか？

A: テンプレートはプレフィックス（`project_`, `feature_`）でスコープを明示することで：
- 一覧表示時に分類が明確
- 検索性が向上（`ls project_*` で全プロジェクトテンプレートを取得）
- 意図的な構造化

### Q: `SCREAMING_SNAKE_CASE` と `kebab-case` をどう使い分ける？

A:
- **SCREAMING_SNAKE_CASE**: プロジェクト全体の重要ドキュメント（docs/）
- **kebab-case**: 機能固有のスペック、コマンド、スキル

### Q: 既存プロジェクトの命名規則を変更すべき？

A: はい。以下の理由で早めに統一することを推奨：
- チーム全体の混乱を防ぐ
- 検索性・保守性の向上
- 新メンバーのオンボーディングが容易

---

**最終更新**: 2025-11-13
**バージョン**: 1.0
**ステータス**: 承認済み
