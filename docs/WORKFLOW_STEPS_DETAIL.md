# ワークフロー詳細ガイド - 11ステップ（⭐ レビュー管理を含む）

## 概要

スペック駆動開発ワークフローの11ステップを詳細に解説します。
新しく追加されたレビュー管理機能により、実装前の品質保証が強化されました。

---

## 完全ワークフロー図

```
┌─────────────────────────────────────────────────────────────────┐
│              スペック駆動開発ワークフロー（11ステップ）                │
└─────────────────────────────────────────────────────────────────┘

Step 0: プロジェクト初期化
   ↓  /init-project [project-name]
   ↓  → 4つのプロジェクトスペック作成
   ↓
Step 1: スペックレビュー・調整
   ↓  /review-specs project
   ↓  → 包括的レビュー実施
   ↓  /adjust-specs project
   ↓  → 対話的に調整・改善
   ↓
Step 2: 機能別要件追加
   ↓  /add-requirements [feature-name]
   ↓  → 要件定義ドキュメント作成
   ↓
Step 3: スペック確認（要件）
   ↓  /spec-check [feature-name]
   ↓  → 要件の一貫性検証
   ↓  NG → Step 1 へ
   ↓  OK ↓
   ↓  /add-technical [feature-name]
   ↓  → 技術仕様ドキュメント作成
   ↓
Step 4: スペック確認（技術）
   ↓  /spec-check [feature-name]
   ↓  → 技術仕様の一貫性検証
   ↓  NG → Step 1 へ
   ↓  OK ↓
   ↓  /add-implementation [feature-name]
   ↓  → 実装ガイド作成
   ↓
Step 4.5: ⭐ スペックレビュー実行（新機能）
   ↓  /review-specs [feature-name]
   ↓  → 3種のスペックを包括的にレビュー
   ↓  → 優先度別の改善項目検出
   ↓  → レビュー結果を保存
   ↓
Step 4.6: ⭐ レビュー結果確認（新機能）
   ↓  /review-actions [feature-name]
   ↓  → 改善項目を優先度順に確認
   ↓  → 期限と影響範囲を把握
   ↓  NG（Critical/Important） → Step 4.7 へ
   ↓  OK（Minor以下） ↓
   ↓
Step 4.7: ⭐ 改善項目実装（新機能・条件付き）
   ↓  /implement-improvements [improvement-name]
   ↓  → 個別改善項目を段階的実装
   ↓  → 仕様更新 → コード → テスト
   ↓  → 完了条件検証
   ↓
Step 5: Todo作成・実装開始
   ↓  /implement [feature-name]
   ↓  → レビュー結果の自動確認（Step 0）
   ↓  → Todoリスト作成
   ↓  → TDD方式で実装
   ↓  → フェーズ毎に改善項目チェック
   ↓
Step 6: 実装状況チェック
   ↓  /check-implementation [feature-name]
   ↓  → 品質ゲート実行
   ↓  NG → Step 5 へ（修正）
   ↓  OK ↓
   ↓
Step 7: スペック更新
   ↓  /update-specs [feature-name]
   ↓  → 実装結果を仕様書に反映
   ↓  → ADR作成（重要な決定）
   ↓
Step 8: コミット
   ↓  /commit-prep
   ↓  → 最終品質チェック
   ↓  → コミットメッセージ生成（レビュー参照含む）
   ↓  → コミット実行
   ↓
   └─→ 次の機能へ（Step 2に戻る）
```

---

## Step 0: プロジェクト初期化

### コマンド
```bash
/init-project [project-name]
```

### 目的
新規プロジェクトの基盤となるスペックドキュメントを作成し、プロジェクトの方向性を明確化する。

### プロセス

#### 0.1 対話形式での情報収集
Claude Code が以下の情報をヒアリング：

**基本情報**:
- プロジェクト名と概要
- ビジョンとミッション
- ターゲットユーザー
- 想定される使用シーン

**技術背景**:
- 技術スタック
- アーキテクチャ方針
- パフォーマンス要件
- セキュリティ要件

**プロジェクト範囲**:
- MVP機能の定義
- フェーズ分割
- 優先度の高い機能
- 将来の拡張計画

**制約条件**:
- 予算・時間の制約
- 技術的制約
- リソース制約
- 外部依存関係

**成功基準**:
- ビジネス指標
- 技術指標
- ユーザー満足度指標

#### 0.2 ドキュメント自動生成
収集した情報を基に、**テンプレートを使用して**5つのプロジェクトスペックを作成：

1. **PROJECT_OVERVIEW.md** (テンプレート: `/specs/templates/project_overview.template.md`)
   - プロジェクト概要
   - ステークホルダー
   - スコープ定義
   - 成功基準

2. **TECHNICAL_ARCHITECTURE.md** (テンプレート: `/specs/templates/project_technical_architecture.template.md`)
   - システムアーキテクチャ
   - 技術スタック
   - データモデル概要
   - セキュリティ設計

3. **DEVELOPMENT_STANDARDS.md** (テンプレート: `/specs/templates/project_development_standards.template.md`)
   - コーディング規約
   - テスト戦略
   - Git ワークフロー
   - 品質管理

4. **PHASE_PLAN.md** (テンプレート: `/specs/templates/project_phase_plan.template.md`)
   - フェーズ別計画
   - リソース計画
   - スケジュール
   - 成功指標

5. **README.md** (テンプレート: `/specs/templates/project_readme.template.md`)
   - プロジェクト概要
   - 主要機能
   - 実装状況
   - ロードマップ

#### 0.3 ディレクトリ構造作成
```
specs/
├── PROJECT_OVERVIEW.md
├── TECHNICAL_ARCHITECTURE.md
├── DEVELOPMENT_STANDARDS.md
├── PHASE_PLAN.md
├── requirements/         # 機能別要件
├── technical/           # 機能別技術仕様
├── implementation/      # 機能別実装ガイド
└── decisions/           # ADR
```

### 成果物
- ✅ 4つのプロジェクトスペック
- ✅ 標準ディレクトリ構造
- ✅ MVP機能のリスト

### 所要時間
30分 - 1時間（対話含む）

### 次のステップ
```bash
/review-specs project
```

---

## Step 1: スペックレビュー・調整

### 1-A: スペックレビュー

#### コマンド
```bash
/review-specs [scope]
```

**scope**:
- `project` - プロジェクト全体スペック
- `[feature-name]` - 特定機能のスペック

#### 目的
スペックドキュメントの完全性、品質、一貫性を包括的に検証する。

#### プロセス

**1. ドキュメント読み込み**
- 対象スペックをすべて読み込み

**2. チェックリスト検証**
各ドキュメントを3つの観点でチェック：

**完全性 (Completeness)**:
- 必須セクションが存在
- 詳細が十分
- 具体的な数値目標
- 例が含まれる

**品質 (Quality)**:
- 明確な表現
- 曖昧さがない
- 実現可能
- ベストプラクティス準拠

**一貫性 (Consistency)**:
- ドキュメント間の整合
- 用語の統一
- 数値の整合
- スコープの整合

**3. 課題の特定**
発見した課題を分類：

- 🔴 **Critical**: 実装開始前に修正必須
- 🟡 **Important**: 実装中に問題になる可能性
- 🟢 **Minor**: 品質向上のための改善

**4. レポート生成**
```markdown
# スペックレビューレポート

## 概要
- レビュー範囲: [Project / Feature]
- ステータス: ✅ Ready / ⚠️ Needs Improvement / ❌ Needs Major Revision

## スコア
| カテゴリ | スコア |
|---------|--------|
| 完全性   | 85%    |
| 品質     | 90%    |
| 一貫性   | 80%    |
| **総合** | **85%** |

## 課題サマリー
- 🔴 Critical: 2件
- 🟡 Important: 5件
- 🟢 Minor: 8件

## Critical Issues
1. [課題の詳細]
2. [課題の詳細]

## 推奨される次のステップ
1. Critical Issues を修正
2. /adjust-specs で対話的に調整
```

#### 成果物
- ✅ 包括的レビューレポート
- ✅ 優先度付き課題リスト
- ✅ 具体的な改善提案

#### 所要時間
10-20分（自動）

### 1-B: スペック調整

#### コマンド
```bash
/adjust-specs [scope]
```

#### 目的
レビューで発見された課題を対話形式で調整・改善する。

#### プロセス

**1. 現状分析**
```markdown
## 調整が推奨される領域
1. **MVP スコープ**: 大きすぎる
   - 現状: 15機能が含まれる
   - 懸念: 3ヶ月で完成困難

2. **技術スタック**: 選定理由が不明確
   - 現状: Next.js 選定理由なし
   - 懸念: チームのスキルセット不明

優先度:
- 🔴 高: 2件
- 🟡 中: 3件
- 🟢 低: 5件
```

**2. 対話的調整**
各課題について：

```markdown
## 調整項目 #1: MVPスコープの洗練

**優先度**: 🔴 High
**カテゴリ**: 実現可能性

### 現状
MVP に 15機能が含まれている

### 問題点
3ヶ月で15機能の実装は非現実的

### 推奨される調整
ビジネス価値マトリクスで優先度を再評価し、
真のMVPを5-7機能に絞る

### 調整オプション
A. 優先度マトリクスで自動分類
B. 各機能を個別に評価
C. カスタム基準で分類
D. スキップ（後で対応）

選択してください:
```

ユーザーの選択に基づいて調整を実施。

**3. 一貫性検証**
調整後にドキュメント間の整合性を再チェック。

**4. サマリー生成**
```markdown
## 🎉 調整完了サマリー

### 調整統計
- 調整項目: 10件
- 更新ドキュメント: 4件
- 作成ADR: 2件

### 主要な変更
1. MVPを15機能→7機能に絞り込み
2. 技術スタック選定理由を明記
3. スケジュールを3ヶ月→4ヶ月に調整

### 品質向上
| 指標 | 調整前 | 調整後 | 改善 |
|------|--------|--------|------|
| 完全性 | 75% | 95% | +20% |
| 品質 | 80% | 92% | +12% |
| 一貫性 | 70% | 90% | +20% |

### 次のステップ
```bash
/review-specs project  # 最終確認
/add-requirements [first-feature]  # 機能追加開始
```
```

#### 成果物
- ✅ 調整済みスペックドキュメント
- ✅ ADR（重要な決定）
- ✅ 品質向上レポート

#### 所要時間
30分 - 2時間（調整の規模による）

### 次のステップ
```bash
# 最終確認
/review-specs project

# 機能追加開始
/add-requirements [first-feature]
```

---

## Step 2: 機能別要件追加

### コマンド
```bash
/add-requirements [feature-name]
```

### 目的
新機能の要件を体系的に定義し、明確なスコープを設定する。

### プロセス

**1. ヒアリング**
- 対象ユーザー
- 機能の目的
- ユーザーストーリー
- 受入基準
- 役割と権限
- セキュリティ要件

**2. ドキュメント作成**
`/specs/requirements/[feature-name].md`

**内容**:
- Overview
- User Stories with Acceptance Criteria
- Role Definitions
- Business Context
- Security Requirements
- Non-Functional Requirements
- Dependencies
- Success Metrics

### 成果物
- ✅ 要件定義ドキュメント

### 所要時間
30分 - 1時間

### 次のステップ
```bash
/spec-check [feature-name]
```

---

## Step 3: スペック確認（要件）

### コマンド
```bash
/spec-check [feature-name]
```

### 目的
要件定義の完全性と一貫性を検証。

### プロセス

**1. 要件チェック**
- User Stories が明確
- Acceptance Criteria が測定可能
- Role Permissions が網羅的

**2. アーキテクチャ影響分析**
- データベース変更の必要性
- API エンドポイントの必要性
- セキュリティへの影響

**3. 推奨事項**
```markdown
⚠️ Technical Spec 未作成
📝 /add-technical [feature-name] を実行
```

### 成果物
- ✅ 検証レポート
- ✅ 次のステップ推奨

### 所要時間
5分（自動）

### 次のステップ
```bash
# 技術仕様作成
/add-technical [feature-name]

# 再度チェック
/spec-check [feature-name]
```

---

## Step 4: スペック確認（技術）

（Step 3と同様のプロセス）

技術仕様の完全性、品質、一貫性を検証。

### 次のステップ
```bash
/add-implementation [feature-name]
```

---

## Step 4.5: ⭐ スペックレビュー実行（新機能）

### コマンド
```bash
/review-specs [feature-name]
```

### 目的
実装開始前に3種類のスペック（Requirements、Technical、Implementation）を包括的にレビューし、問題を早期発見する。

### プロセス

#### 4.5.1 スペックドキュメントの読み込み
Claude Codeが以下を確認：
- `/specs/requirements/[feature-name].md`
- `/specs/technical/[feature-name].md`
- `/specs/implementation/[feature-name].md`

#### 4.5.2 品質評価
各スペックを以下の観点で評価：
- **完全性**: 必須セクションがすべて埋められているか
- **一貫性**: スペック間で矛盾がないか
- **実装可能性**: 実装ガイドが具体的で実行可能か
- **セキュリティ**: セキュリティ要件が適切に定義されているか
- **テスト可能性**: テストシナリオが明確か

#### 4.5.3 問題の分類
検出された問題を優先度別に分類：
- 🔴 **Critical**: 実装前に必ず解決すべき重大な問題
- 🟡 **Important**: 実装中に対処推奨の重要な問題
- 🟢 **Minor**: 品質向上のための推奨事項

#### 4.5.4 レビュー結果の保存
以下のファイルを自動生成：
- `/specs/reviews/pending/[feature-name].md` - レビュー結果サマリー
- `/specs/improvements/critical/[issue-name].md` - Critical改善項目（該当時）
- `/specs/improvements/important/[issue-name].md` - Important改善項目
- `/specs/improvements/minor/index.md` - Minor改善項目リスト

### 出力例
```markdown
=== Spec Review: user-api-key-management ===

## 総合評価
📊 スコア: 92% (Approved with conditions)

## 詳細スコア
- Requirements: 95% (Excellent)
- Technical: 90% (Good)
- Implementation: 90% (Good)

## 検出された課題
🔴 Critical: 0項目
🟡 Important: 2項目
🟢 Minor: 5項目

## 次のステップ
/review-actions user-api-key-management で詳細確認
```

### 成果物
- レビュー結果ドキュメント
- 優先度別改善項目リスト
- レビューメトリクス（スコア、問題数）

---

## Step 4.6: ⭐ レビュー結果確認（新機能）

### コマンド
```bash
/review-actions [feature-name]
```

### 目的
レビューで検出された改善項目を確認し、対処方法を決定する。

### プロセス

#### 4.6.1 レビュー結果の読み込み
Claude Codeが以下を表示：
- レビュー日時とスコア
- 優先度別の改善項目リスト
- 各項目の期限と影響範囲

#### 4.6.2 改善項目の詳細表示
各項目について以下を提示：
- **概要**: 問題の内容
- **期限**: いつまでに対処すべきか
- **影響範囲**: どの領域に影響するか
- **推奨アクション**: 具体的な対処方法

#### 4.6.3 対処方法の選択
ユーザーに選択肢を提示：
1. **今すぐ対処**: `/implement-improvements` で個別実装
2. **実装と並行**: `/implement` でそのまま進める（リスク管理必要）
3. **詳細確認**: 改善項目ファイルを直接確認

### 出力例
```markdown
=== Review Actions: user-api-key-management ===

## 🟡 Important Issues (2項目)

### 1. 環境依存の暗号化キー管理強化
期限: 実装開始前（❗ 今すぐ対処推奨）
影響: セキュリティ、運用

推奨アクション:
/implement-improvements encryption-key-management

### 2. レート制限の実装詳細化
期限: Phase 3前
影響: パフォーマンス、セキュリティ

推奨アクション: Phase 2完了後に対処

## 対処オプション
1. 今すぐ対処
2. 実装と並行（リスク管理必要）
3. 詳細確認
```

### 判断基準
- **Critical**: 必ずStep 4.7で対処
- **Important（期限=実装開始前）**: Step 4.7で対処推奨
- **Important（期限=Phase X）**: 該当フェーズ前に対処
- **Minor**: 実装と並行可能

---

## Step 4.7: ⭐ 改善項目実装（新機能・条件付き）

### コマンド
```bash
/implement-improvements [improvement-name]
```

### 目的
レビューで指摘された個別の改善項目を段階的に実装する。

### 実行条件
- Critical改善項目が存在する場合（必須）
- Important改善項目で期限が「実装開始前」の場合（推奨）

### プロセス

#### 4.7.1 改善項目ファイルの読み込み
Claude Codeが以下を確認：
- `/specs/improvements/{priority}/{improvement-name}.md`
- メタデータ（優先度、担当、期限）
- 実装ガイド

#### 4.7.2 実装前チェック
以下を確認：
- 前提条件の充足
- 関連スペックの参照
- 既存コードの確認

#### 4.7.3 段階的実装
**Phase 1: 仕様書の更新**
- Technical仕様書に詳細追加
- Implementation仕様書に手順追加

**Phase 2: コード実装**
```typescript
// 改善項目ファイルから実装ガイドを読み込み
// 各ステップを実行
for (const step of implementationGuide.steps) {
  await executeStep(step);
  await verifyStep(step);
}
```

**Phase 3: テスト追加**
- 単体テストの追加
- 統合テストの更新

#### 4.7.4 完了条件の検証
```markdown
## 完了条件チェック
- [x] シークレット管理サービスが選定されている
- [x] キーローテーション手順が文書化されている
- [x] 環境別のキー管理方法が明確化されている
- [x] 単体テスト追加完了
```

#### 4.7.5 ステータス更新とコミット
```bash
git add .
git commit -m "feat: [improvement-title]

Addresses review improvement:
- Issue: [improvement-name] (Priority)
- [改善内容の説明]

Refs: /specs/reviews/pending/[feature-name].md
Refs: /specs/improvements/{priority}/[improvement-name].md"
```

### 成果物
- 更新されたスペックドキュメント
- 実装コード
- テストコード
- 完了レポート

---

## Step 5: Todo作成・実装開始（⭐ レビュー統合版）

### コマンド
```bash
/implement [feature-name]
```

### 目的
実装ガイドをTodoリストに分解し、レビュー結果を統合しながらTDD方式で実装。

### ⭐ Step 0: レビュー結果の自動確認（新機能）

実装開始時に自動的に実行されます：

#### 1. レビュー結果の存在確認
```bash
if exists /specs/reviews/pending/[feature-name].md:
  - レビュースコアを表示
  - Critical/Important未対処項目を警告
  - 対処確認をユーザーに問い合わせ
```

#### 2. 未対処項目の表示
```markdown
## ⚠️ レビュー結果が存在します

### スコア: 92% (Approved with conditions)

### 未対処項目:
- 🟡 レート制限の実装詳細化 (期限: Phase 3前)

### 対処方法:
1. そのまま進める（Phase 3前に対処）
2. 今すぐ対処 → /implement-improvements
3. 詳細確認 → /review-actions

続行しますか？
```

#### 3. ユーザー判断
- **はい**: 実装を継続（リスクを理解）
- **いいえ**: `/implement-improvements` で先に改善項目を対処

### プロセス

**1. Todoリスト作成**
実装ガイドから13-20個のタスクを生成。

**2. ユーザー確認**
```markdown
📋 Todo List (13 tasks):

Database & Schema (3 tasks)
1. [pending] Add Comment model to Prisma schema (15 min)
2. [pending] Update Report model (5 min)
3. [pending] Run migration (10 min)

...

合計: 6-7時間

実装を開始しますか？ (yes/no)
```

**3. ⭐ フェーズごとの改善項目チェック（新機能）**
各フェーズ開始時に自動チェック：
```bash
if current_phase matches improvement_deadline:
  - 該当する改善項目を警告
  - 推奨アクション: /implement-improvements [improvement-name]
```

**例**: Phase 3開始時
```markdown
⚠️ Phase 3に関連する改善項目があります

🟡 レート制限の実装詳細化 (期限: Phase 3前)

今すぐ対処しますか？
1. はい → /implement-improvements rate-limiting-details
2. いいえ → リスクを理解して続行
```

**4. TDD方式で実装**
各タスクに対して：
1. Todoを `in_progress` にマーク
2. ⭐ 改善項目のガイドラインを適用（該当時）
3. テストを先に書く
4. 実装
5. テスト実行
6. Todoを `completed` にマーク
7. 次のタスクへ

**5. ⭐ コミットメッセージにレビュー参照（新機能）**
```bash
git commit -m "feat: [feature] - implements [todo]

Addresses review items:
- Issue #1: [if applicable]

Refs: /specs/reviews/pending/[feature-name].md"
```

### 成果物
- ✅ 完全な実装
- ✅ すべてのテスト合格
- ✅ 高カバレッジ（>80%）

### 所要時間
実装ガイドの推定通り（通常6-8時間）

### 次のステップ
```bash
/check-implementation [feature-name]
```

---

## Step 7: 実装状況チェック

### コマンド
```bash
/check-implementation [feature-name]
```

### 目的
実装完了と品質ゲート通過を確認。

### プロセス

**1. Todo状態確認**
- すべて completed か

**2. 品質ゲート実行**
```bash
npm run test           # ✅ 24 passed
npm run type-check     # ✅ No errors
npm run lint           # ✅ No errors
npm run format         # ✅ All formatted
```

**3. カバレッジ確認**
- 目標: 80%以上

**4. レポート生成**
```markdown
✅ All Todos Completed (13/13)
✅ Tests: 24 passed, 0 failed
✅ Coverage: 87% (target: 80%)
✅ TypeScript: No errors
✅ ESLint: No errors

Ready for spec update and commit
```

### 成果物
- ✅ 品質確認レポート
- ✅ 実装完了証明

### 所要時間
2-5分（自動）

### 次のステップ
```bash
/update-specs [feature-name]
```

---

## Step 8: スペック更新

### コマンド
```bash
/update-specs [feature-name]
```

### 目的
実装結果と決定事項を仕様書に反映。

### プロセス

**1. 実装分析**
- 変更ファイル
- 実装時の決定
- 追加機能
- 既知の問題

**2. 実装ガイド更新**
```markdown
## 実装完了情報
- 実装日: 2025-11-13
- 実装時間: 6.5時間
- テストカバレッジ: 87%

## ファイル一覧
**作成**: 9ファイル
**変更**: 2ファイル

## 実装時の変更点
### メンション機能追加
- 理由: ユーザー要望
- 影響: Phase 3で通知実装必要
```

**3. 技術仕様更新**
実際のAPI仕様、データモデル変更を反映。

**4. ADR作成**
重要な決定をADRとして記録。

### 成果物
- ✅ 更新された実装ガイド
- ✅ 更新された技術仕様
- ✅ ADR（必要に応じて）

### 所要時間
15-30分

### 次のステップ
```bash
/commit-prep
```

---

## Step 9: コミット

### コマンド
```bash
/commit-prep
```

### 目的
最終品質チェックとコミット実行。

### プロセス

**1. 品質ゲート再実行**
```bash
[1/7] Running tests...        ✅
[2/7] Type checking...         ✅
[3/7] Linting...              ✅
[4/7] Code formatting...      ✅
[5/7] Checking spec updates...✅
[6/7] Verifying todos...      ✅
[7/7] Reviewing changes...    ✅
```

**2. 変更ファイル確認**
```bash
Modified: 3 files
New: 11 files
Total: 14 files
```

**3. コミットメッセージ生成**
```bash
[Feature] Add comment functionality to reports

- Add Comment model with threaded replies
- Implement CommentService with RBAC
- Create API endpoints with pagination
- Add UI components
- Include mention feature (@username)
- 24 tests, 87% coverage

Database Changes:
- New Comment model
- Relations to Report and User

API Endpoints:
- POST /api/reports/:id/comments
- GET /api/reports/:id/comments

Refs: #feature-report-comments
Tests: 24 new tests (87% coverage)
Time: 6.5 hours
```

**4. コミット実行**
```bash
git add .
git commit -m "..."
✅ Committed successfully
```

### 成果物
- ✅ コミット完了
- ✅ 1機能完成

### 所要時間
5分（自動）

### 次のステップ
次の機能の要件定義：
```bash
/add-requirements [next-feature]
```

---

## ワークフロー完了

1機能の完全な実装サイクルが完了しました。

### 達成されたこと
- ✅ 要件定義から実装まで完了
- ✅ 品質ゲートすべて通過
- ✅ スペックが最新状態
- ✅ ADRで決定を記録
- ✅ コミット完了

### 次のサイクル
Step 2 に戻り、次の機能の要件定義を開始。

---

## まとめ

### ワークフローの特徴

**10ステップ**:
0. プロジェクト初期化
1. スペックレビュー・調整
2. 機能別要件追加
3. スペック確認（要件）
4. スペック確認（技術）
5. 実装内容ドキュメント化
6. Todo作成・実装
7. 実装状況チェック
8. スペック更新
9. コミット

**3つの柱**:
1. **ドキュメント駆動**: 実装前に仕様完成
2. **テスト駆動**: テストファースト
3. **品質重視**: 各ステップで検証

**自動化レベル**:
- Step 0: 半自動（対話形式）
- Step 1: 半自動（対話形式）
- Step 3-4: 完全自動
- Step 6: 半自動
- Step 7: 完全自動
- Step 9: 完全自動

### 成功の鍵
1. 各ステップを飛ばさない
2. レビューを丁寧に
3. スペックを最新に保つ
4. 決定を記録（ADR）
5. 品質ゲートを厳守

---

**最終更新**: 2025-11-15
**バージョン**: 3.0（11ステップ版 - レビュー管理機能追加）
