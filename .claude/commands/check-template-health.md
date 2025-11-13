---
description: テンプレートの健全性と更新必要性をチェック
tags: [maintenance, template, project]
---

# Template Health Check

このコマンドは、Spec-Driven Development Templateの健全性を包括的にチェックし、更新が必要な箇所を特定します。

## IMPORTANT: Output Language
**All output must be in Japanese (日本語).**

## 実行内容

### Step 1: 環境情報の収集

以下の情報を収集:

1. **Claude Code Version**
   - 現在のバージョンを確認
   - 最新版との比較

2. **Node.js Ecosystem**
   - Node.jsバージョン
   - TypeScriptバージョン
   - Next.jsバージョン（該当する場合）

3. **Dependencies Status**
   - package.jsonの依存関係チェック
   - セキュリティ脆弱性スキャン
   - 非推奨パッケージの検出

### Step 2: テンプレート構造の検証

Read toolを使用して以下を確認:

1. **必須ファイルの存在確認**
   ```
   必須ファイルリスト:
   - .claude/commands/*.md (12個)
   - specs/templates/*.template.md (8個)
   - scripts/init.sh, scripts/init.ps1
   - examples/*.md (4個)
   - docs/*.md (5個)
   - README.md, LICENSE, CONTRIBUTING.md
   ```

2. **ディレクトリ構造の検証**
   ```
   必須ディレクトリ:
   - .claude/commands/
   - specs/templates/
   - specs/requirements/ (.gitkeep)
   - specs/technical/ (.gitkeep)
   - specs/implementation/ (.gitkeep)
   - specs/decisions/ (.gitkeep)
   - scripts/
   - examples/
   - docs/
   ```

3. **テンプレート変数の検証**
   - 各テンプレートファイルのプレースホルダー構文チェック
   - 一貫性の確認

### Step 3: スラッシュコマンドの検証

各コマンドファイルをチェック:

1. **メタデータの存在確認**
   - description フィールド
   - args フィールド（該当する場合）

2. **出力言語指定の確認**
   - "IMPORTANT: Output Language" セクションの存在

3. **テンプレート参照の確認**
   - ドキュメント作成コマンドでのテンプレート参照
   - 正しいパス指定

### Step 4: ドキュメントの整合性チェック

1. **相互参照の確認**
   - README.mdからのリンク
   - ワークフローガイドの整合性
   - 内部リンクの有効性

2. **サンプルファイルの検証**
   - サンプルコードの構文チェック
   - テンプレートとの整合性

3. **バージョン情報の確認**
   - 各ドキュメントの最終更新日
   - バージョン番号の一貫性

### Step 5: 外部環境との互換性チェック

WebSearch toolを使用して最新情報を確認:

1. **Claude Code Updates**
   ```
   検索クエリ:
   - "Claude Code updates 2025"
   - "Claude Code API changes"
   - "Claude Code slash commands best practices"
   ```

2. **Ecosystem Updates**
   ```
   検索クエリ:
   - "Next.js 15 new features"
   - "TypeScript 5.x breaking changes"
   - "Node.js LTS recommendations 2025"
   ```

3. **Best Practices Evolution**
   ```
   検索クエリ:
   - "spec-driven development best practices"
   - "AI-assisted development workflow 2025"
   ```

### Step 6: 健全性スコアの計算

各カテゴリのスコアを計算:

```typescript
interface HealthScore {
  structure: number;      // 構造の完全性 (0-100)
  compatibility: number;  // 互換性 (0-100)
  documentation: number;  // ドキュメント品質 (0-100)
  security: number;       // セキュリティ (0-100)
  freshness: number;      // 最新性 (0-100)
  overall: number;        // 総合スコア (0-100)
}
```

**スコアリング基準:**
- **90-100**: 優秀 - 更新不要
- **70-89**: 良好 - 軽微な更新推奨
- **50-69**: 要改善 - 更新推奨
- **0-49**: 要対応 - 早急な更新が必要

### Step 7: レポート生成

以下の形式でレポートを出力:

```markdown
# Template Health Check Report

**実行日時**: YYYY-MM-DD HH:MM:SS
**テンプレートバージョン**: v1.0.0

## 📊 健全性スコア

| カテゴリ | スコア | 状態 |
|---------|--------|------|
| 構造の完全性 | 95/100 | ✅ 優秀 |
| 互換性 | 85/100 | ✅ 良好 |
| ドキュメント品質 | 90/100 | ✅ 優秀 |
| セキュリティ | 100/100 | ✅ 優秀 |
| 最新性 | 75/100 | ⚠️ 要改善 |
| **総合スコア** | **89/100** | **✅ 良好** |

## 🔍 詳細チェック結果

### ✅ 正常項目
- すべての必須ファイルが存在
- ディレクトリ構造が正しい
- セキュリティ脆弱性なし
- スラッシュコマンド: 12/12 正常

### ⚠️ 警告項目
- Node.js v20.1.0 → v20.11.0 への更新を推奨
- TypeScript 5.3.0 → 5.7.0 への更新を推奨
- 3つのnpmパッケージに更新あり

### ❌ 要対応項目
- なし

## 🔄 更新推奨事項

### 優先度: 高
なし

### 優先度: 中
1. **依存関係の更新**
   - `npm update` を実行して依存関係を最新化
   - 影響: セキュリティとパフォーマンスの向上

2. **ドキュメントの最終更新日を更新**
   - 該当ファイル: WORKFLOW_GUIDE.md, SPEC_TEMPLATES_GUIDE.md
   - 影響: ユーザーへの情報の正確性向上

### 優先度: 低
1. **新機能の検討**
   - Claude Code v1.x の新機能を活用
   - GitHub Actions統合の追加

## 📋 Next Actions

1. `/template-update-scan` を実行して詳細な更新計画を作成
2. 優先度の高い項目から対応
3. 更新後に再度このコマンドでヘルスチェック

## 🔗 関連コマンド
- `/template-update-scan` - 更新必要箇所の詳細スキャン
- `/merge-template-update` - 更新をmainブランチにマージ

---

**最終判定**: このテンプレートは良好な状態です。軽微な更新を推奨しますが、緊急性はありません。
```

## 使用例

```bash
# 基本的な使用
/check-template-health

# 詳細モード（全チェック項目を表示）
/check-template-health --verbose

# JSON形式で出力
/check-template-health --format json
```

## Notes

- このコマンドは読み取り専用で、ファイルを変更しません
- ネットワーク接続が必要（最新情報の取得のため）
- 実行時間: 約2-3分
- 定期的な実行（月1回）を推奨
