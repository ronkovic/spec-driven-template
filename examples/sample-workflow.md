# Sample Workflow: User Authentication Feature

このドキュメントは、Spec-Driven Development Templateを使用して「ユーザー認証機能」を実装する完全なワークフロー例を示します。

---

## Step 0: プロジェクト初期化

### コマンド
```bash
/init-project my-saas-platform
```

### 実行内容
Claude Codeが対話形式で情報を収集し、以下のドキュメントを自動生成：

**生成されるファイル**:
- `docs/PROJECT_OVERVIEW.md`
- `docs/TECHNICAL_ARCHITECTURE.md`
- `docs/DEVELOPMENT_STANDARDS.md`
- `docs/PHASE_PLAN.md`
- `README.md`

**所要時間**: 30-60分

---

## Step 1: スペックレビュー

### コマンド
```bash
/review-specs project
```

### 実行内容
生成されたプロジェクトスペックを包括的にレビュー：
- 完全性チェック
- 一貫性チェック
- 品質チェック

### 結果例
```markdown
=== Specification Review Report ===

## Overall Status
✅ Passed

## Scores
| Category | Score | Details |
|----------|-------|---------|
| Completeness | 95% | 優秀 |
| Quality | 90% | 良好 |
| Consistency | 98% | 優秀 |
```

**所要時間**: 10-15分

---

## Step 2: スペック調整（必要に応じて）

### コマンド
```bash
/adjust-specs project
```

### 実行内容
レビューで見つかった問題を対話的に修正

**所要時間**: 15-30分

---

## Step 3: 機能要件定義

### コマンド
```bash
/add-requirements user-authentication
```

### 実行内容
Claude Codeが以下を質問：
- この機能の対象ユーザーは？
- 何を実現したいか？
- どの操作が必要か？
- どのロールがアクセスできるか？

### ユーザーの回答例
```
対象ユーザー: すべてのシステム利用者
実現したいこと: 安全なログイン・ログアウト
必要な操作: ログイン、ログアウト、パスワードリセット
アクセス権限: ログイン/ログアウトは全ユーザー、管理機能はADMINのみ
```

### 生成されるファイル
- `specs/requirements/user-authentication.md`

**所要時間**: 30-60分

---

## Step 4: 要件スペックチェック

### コマンド
```bash
/spec-check user-authentication
```

### 実行内容
要件定義の完全性と品質をチェック：
- ユーザーストーリーの完全性
- 受入基準の明確さ
- セキュリティ要件の網羅性
- 成功指標の測定可能性

### 結果例
```markdown
=== Specification Validation Report ===

## Overall Status
✅ Passed

## Documents Checked
- Requirements: ✅ Complete

## Template Adherence
### Requirements Document
- All required sections: ✅
- User stories format: ✅
- Acceptance criteria: ✅
```

**所要時間**: 5分

---

## Step 5: 技術仕様作成

### コマンド
```bash
/add-technical user-authentication
```

### 実行内容
Claude Codeが技術的な質問：
- どのアーキテクチャパターンを使用？
- データモデルは？
- API設計は？
- セキュリティ対策は？

### ユーザーの回答例
```
アーキテクチャ: Next.js App Router + Server Actions
認証方式: AWS Cognito
セッション管理: Redis
データベース: PostgreSQL + Prisma
```

### 生成されるファイル
- `specs/technical/user-authentication.md`

**所要時間**: 1-2時間

---

## Step 6: 技術仕様チェック

### コマンド
```bash
/spec-check user-authentication
```

### 実行内容
要件と技術仕様の整合性をチェック：
- 要件 ↔ 技術設計の対応
- データモデルの完全性
- APIエンドポイントの網羅性
- セキュリティ設計の妥当性

**所要時間**: 5分

---

## Step 7: 実装ガイド作成

### コマンド
```bash
/add-implementation user-authentication
```

### 実行内容
要件と技術仕様を基に、実装可能なステップに分解：

### 生成されるファイル
- `specs/implementation/user-authentication.md`

**内容**:
- Phase 1: Database & Data Models
- Phase 2: Validation & Service Layer
- Phase 3: Server Actions & API
- Phase 4: Frontend Components
- Phase 5: Testing & Documentation

**所要時間**: 30-60分

---

## Step 8: 実装開始

### コマンド
```bash
/implement user-authentication
```

### 実行内容
1. 実装ガイドを読み込み
2. 詳細なTodoリストを作成（TodoWrite使用）
3. ユーザーに実装プランを提示
4. 確認後、TDD方式で実装

### Todo例
```javascript
[
  // Phase 1: Database & Schema
  { content: "Create Prisma schema for User model", status: "pending" },
  { content: "Generate and run database migration", status: "pending" },

  // Phase 2: Validation & Service
  { content: "Create Zod validation schemas", status: "pending" },
  { content: "Implement AuthService class", status: "pending" },

  // Phase 3: API
  { content: "Create loginAction Server Action", status: "pending" },
  { content: "Create logoutAction Server Action", status: "pending" },

  // Phase 4: Frontend
  { content: "Create LoginForm component", status: "pending" },
  { content: "Create login page", status: "pending" },
  { content: "Create authentication middleware", status: "pending" },

  // Phase 5: Testing
  { content: "Write unit tests for AuthService", status: "pending" },
  { content: "Write integration tests for Server Actions", status: "pending" },
  { content: "Write E2E tests for login flow", status: "pending" },
]
```

### 実装フロー
各Todoに対して：
1. Todoをin_progressに変更
2. テストを先に書く（TDD）
3. 実装する
4. テストを実行して確認
5. Todoをcompletedに変更
6. 次のTodoへ

**所要時間**: 2-3日（実装規模による）

---

## Step 9: 実装状況チェック

### コマンド
```bash
/check-implementation user-authentication
```

### 実行内容
品質ゲートを実行：
- すべてのテストが通過しているか
- TypeScript型エラーがないか
- ESLintエラーがないか
- コードフォーマットが正しいか
- テストカバレッジが80%以上か

### 結果例
```markdown
=== Implementation Status Check ===

## Todo Status
✅ All todos complete (13/13)

## Quality Gates
✅ Tests: 45 passed, 0 failed
✅ Coverage: 87% (target: 80%)
✅ TypeScript: No errors
✅ ESLint: No errors
✅ Prettier: All formatted

## Status
✅ Implementation complete
✅ All quality gates passed
✅ Ready to update specs
```

**所要時間**: 5-10分

---

## Step 10: スペック更新

### コマンド
```bash
/update-specs user-authentication
```

### 実行内容
実装結果をスペックに反映：
- 実装完了情報の追加
- 作成・変更されたファイルのリスト
- 実装中に行った決定事項の記録
- テスト結果とカバレッジ
- パフォーマンスメトリクス
- README.mdの更新（機能ステータス）

### 更新されるファイル
- `specs/implementation/user-authentication.md` - 実装完了情報追加
- `README.md` - 実装ステータス更新

**所要時間**: 15-30分

---

## Step 11: コミット準備

### コマンド
```bash
/commit-prep
```

### 実行内容
最終品質チェックとコミット準備：
1. git statusとgit diffを確認
2. すべての品質ゲートを再実行
3. 変更ファイルをカテゴリ分類
4. コミットメッセージ生成
5. gitコミット実行

### コミットメッセージ例
```
feat: implement user authentication feature

- Add User, Session, AuditLog models with Prisma
- Implement AWS Cognito integration
- Create login/logout Server Actions
- Add LoginForm and authentication middleware
- Add comprehensive test suite (87% coverage)

Related specs:
- Requirements: specs/requirements/user-authentication.md
- Technical: specs/technical/user-authentication.md
- Implementation: specs/implementation/user-authentication.md

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

**所要時間**: 10分

---

## 完了！

### 成果物
- ✅ 包括的な要件定義
- ✅ 詳細な技術仕様
- ✅ 実装可能なガイド
- ✅ 高品質な実装コード
- ✅ 充実したテストスイート
- ✅ 最新のドキュメント

### 総所要時間
- スペック作成: 3-5時間
- 実装: 2-3日
- テストと品質チェック: 4-8時間
- **合計**: 3-4日

---

## 次の機能へ

次の機能を追加する場合は、Step 3から再開：

```bash
/add-requirements [next-feature-name]
```

このサイクルを繰り返すことで、一貫性のある高品質なプロダクトを効率的に開発できます。
