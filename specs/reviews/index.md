# レビュー管理システム

## 概要

このディレクトリは、仕様書レビューの結果とアクションアイテムを管理するためのシステムです。

## ディレクトリ構造

```
specs/reviews/
├── index.md                 # このファイル
├── pending/                 # 対応待ちのレビュー
│   └── [feature-name].md   # 各機能のレビュー結果
└── completed/              # 対応完了のレビュー
    └── [feature-name].md   # アーカイブ

specs/improvements/
├── critical/               # 🔴 実装前に必須の改善項目
├── important/              # 🟡 実装中に対処推奨の改善項目
│   ├── encryption-key-management.md
│   └── rate-limiting-details.md
└── minor/                  # 🟢 品質向上のための改善項目
    └── index.md           # Minor項目の一覧
```

## ワークフロー

```mermaid
graph LR
    A[仕様書作成] --> B[/review-specs]
    B --> C{レビュー結果}
    C -->|Issues found| D[pending/にレビュー保存]
    D --> E[improvements/に個別項目作成]
    E --> F[/review-actions で確認]
    F --> G{対処方法選択}
    G -->|個別対処| H[/implement-improvements]
    G -->|実装と並行| I[/implement]
    H --> J[改善完了]
    I --> J
    J --> K[completed/に移動]
```

## 利用可能なコマンド

### レビュー関連コマンド

#### `/review-specs [feature-name]`
仕様書のレビューを実行し、結果を `pending/` に保存

#### `/review-actions [feature-name]`
レビューで指摘されたアクションアイテムの確認と管理

#### `/implement-improvements [improvement-name]`
個別の改善項目を段階的に実装

### 既存コマンドの拡張

#### `/implement [feature-name]`
- **Step 0 (NEW)**: レビュー結果の自動確認
- 各フェーズで関連する改善項目をチェック
- コミットメッセージにレビュー参照を含める

## 現在のレビューステータス

### Pending Reviews

| 機能名 | レビュー日 | スコア | Critical | Important | Minor | ステータス |
|--------|-----------|--------|----------|-----------|-------|-----------|
| user-api-key-management | 2025-11-15 | 92% | 0 | 2 | 5 | ⏳ Pending |

### Active Improvements

#### 🟡 Important (2)
1. **encryption-key-management** - 環境依存の暗号化キー管理強化
   - 期限: 実装開始前
   - 担当: Security Lead

2. **rate-limiting-details** - レート制限の実装詳細化
   - 期限: Phase 3前
   - 担当: Tech Lead

#### 🟢 Minor (5)
- Success Metrics測定環境の確定
- ADMINロールスコープの明確化
- エラーメッセージ多言語対応の詳細化
- APIキーマスキングルールの統一
- Approvalセクションの完成

## 使用例

### 新機能のレビューから実装まで

```bash
# 1. 仕様書レビューを実行
/review-specs user-authentication

# 2. レビュー結果を確認
/review-actions user-authentication

# 3. 重要な改善項目を先に対処
/implement-improvements security-headers

# 4. 実装開始（レビュー結果を自動参照）
/implement user-authentication
```

### レビューステータスの更新

```bash
# すべてのpendingレビューを確認
/review-actions --all

# 特定の優先度の項目のみ確認
/review-actions --priority=important

# 改善項目の完了マーク
# (自動的に /implement-improvements 完了時に更新)
```

## ベストプラクティス

1. **レビューファースト**: 実装前に必ず `/review-specs` を実行
2. **優先度順に対処**: Critical → Important → Minor の順で対処
3. **フェーズと同期**: 改善項目の期限と実装フェーズを合わせる
4. **コミットで参照**: 改善項目を対処したコミットで Issue 番号を参照
5. **定期的な棚卸し**: 完了した項目は `completed/` に移動

## メトリクス

- **平均レビュースコア**: 92%
- **改善項目対処率**: 0% (0/7)
- **Critical Issue 発生率**: 0%
- **レビュー→実装の平均時間**: TBD