---
description: 外部環境の変更を検知して更新必要箇所を特定
tags: [maintenance, template, project]
---

# Template Update Scan

このコマンドは、外部環境（Claude Code、フレームワーク、ベストプラクティス）の変更を検知し、テンプレートの更新が必要な箇所を詳細に特定します。

## IMPORTANT: Output Language
**All output must be in Japanese (日本語).**

## 実行内容

### Step 1: 現在の状態を記録

`.template-config.json` から現在の設定を読み込み:

```typescript
interface CurrentState {
  version: string;
  lastUpdated: string;
  claudeCodeVersion: string;
  dependencies: Record<string, string>;
  updateHistory: UpdateRecord[];
}
```

### Step 2: Claude Code エコシステムのスキャン

#### 2.1 Claude Code公式ドキュメントの変更確認

WebFetch toolを使用して最新情報を取得:

```
チェック対象:
1. https://docs.claude.com/en/docs/claude-code
   - 新機能の追加
   - APIの変更
   - 非推奨機能の告知

2. https://github.com/anthropics/claude-code
   - リリースノート
   - Breaking changes
   - 新しいベストプラクティス
```

#### 2.2 スラッシュコマンドのベストプラクティス

WebSearch toolで最新情報を検索:

```
検索クエリ:
- "Claude Code slash commands 2025"
- "Claude Code custom commands best practices"
- "Claude Code MCP integration"
```

### Step 3: 開発エコシステムのスキャン

#### 3.1 Node.js環境

```bash
# 現在のバージョン確認
node --version
npm --version

# LTS推奨バージョンとの比較
```

WebSearchで最新情報を確認:
- "Node.js LTS 2025 recommendations"
- "Node.js 20 vs 22 migration guide"

#### 3.2 TypeScript

```
検索クエリ:
- "TypeScript 5.x new features 2025"
- "TypeScript breaking changes"
- "TypeScript best practices"
```

チェック項目:
- 新しい型システム機能
- tsconfig.json推奨設定の変更
- 非推奨機能

#### 3.3 Next.js（該当する場合）

```
検索クエリ:
- "Next.js 15 new features"
- "Next.js App Router best practices"
- "Next.js Server Actions patterns"
```

チェック項目:
- 新しいレンダリング戦略
- データフェッチパターンの変更
- 推奨されるディレクトリ構造

### Step 4: Spec-Driven Developmentのトレンド

WebSearchで最新のトレンドを調査:

```
検索クエリ:
- "specification-driven development 2025"
- "AI-assisted development workflow"
- "LLM-powered coding best practices"
- "documentation-first development"
```

### Step 5: テンプレートファイルの分析

Grep toolを使用して、更新が必要な可能性のあるパターンを検出:

#### 5.1 非推奨パターンの検出

```regex
検索パターン:
- "deprecated"
- "legacy"
- "TODO.*update"
- "FIXME"
- "v[0-9]+.*outdated"
```

#### 5.2 バージョン指定の確認

```regex
検索パターン:
- "node.*v?[0-9]+"
- "typescript.*[0-9]+\.[0-9]+"
- "next.*[0-9]+\.[0-9]+"
```

#### 5.3 ハードコードされた日付

```regex
検索パターン:
- "202[0-9]-[0-9]{2}-[0-9]{2}"
- "最終更新.*202[0-9]"
```

### Step 6: コミュニティフィードバックの分析

GitHub Issues/Discussionsをチェック（該当する場合）:

```
確認項目:
- ユーザーからの改善提案
- バグレポート
- Feature requests
- よくある質問
```

### Step 7: 更新計画の生成

収集した情報を基に、詳細な更新計画を作成:

```markdown
# Template Update Scan Report

**スキャン日時**: YYYY-MM-DD HH:MM:SS
**現在のテンプレートバージョン**: v1.0.0

## 🔍 検出された変更

### 1. Claude Code エコシステム

#### 1.1 新機能
- ✨ **Claude Code v1.5の新機能**
  - 説明: 新しいスラッシュコマンド構文
  - 影響範囲: すべてのコマンドファイル
  - 優先度: 中
  - 推定工数: 2時間

#### 1.2 非推奨機能
- ⚠️ **旧API構文の非推奨化**
  - 該当箇所: なし
  - 対応期限: なし

### 2. 開発エコシステム

#### 2.1 Node.js
- 📦 **Node.js 22 LTS リリース**
  - 現在: v20.11.0
  - 推奨: v22.0.0
  - 影響: package.json の engines フィールド
  - 優先度: 低
  - 推定工数: 30分

#### 2.2 TypeScript
- 📦 **TypeScript 5.7 リリース**
  - 現在: 5.3.0
  - 最新: 5.7.0
  - 新機能: 改善された型推論
  - 影響: tsconfig.json の推奨設定
  - 優先度: 中
  - 推定工数: 1時間

#### 2.3 Next.js
- 📦 **Next.js 15.1 リリース**
  - 現在: 15.0.0
  - 最新: 15.1.0
  - 新機能: パフォーマンス改善
  - 影響: サンプルコードとドキュメント
  - 優先度: 低
  - 推定工数: 1時間

### 3. ベストプラクティスの変化

#### 3.1 Spec-Driven Development
- 💡 **新しいドキュメンテーションパターン**
  - 説明: Mermaid図の積極的な活用
  - 影響: テンプレートファイルにMermaidセクション追加
  - 優先度: 低
  - 推定工数: 3時間

#### 3.2 AI-Assisted Development
- 💡 **プロンプトエンジニアリングのベストプラクティス**
  - 説明: より効果的なコマンドプロンプト構造
  - 影響: スラッシュコマンドの説明文改善
  - 優先度: 中
  - 推定工数: 4時間

### 4. セキュリティ

#### 4.1 依存関係の脆弱性
- 🔒 **検出された脆弱性**
  - なし ✅

#### 4.2 推奨されるセキュリティ設定
- 🔒 **.gitignoreの強化**
  - 説明: 新しい秘密情報パターンの追加
  - 影響: .gitignore, .template-ignore
  - 優先度: 高
  - 推定工数: 30分

### 5. ドキュメント

#### 5.1 古い情報
- 📝 **更新が必要なドキュメント**
  - WORKFLOW_GUIDE.md: 最終更新 2025-11-13
  - 内容: Claude Code v1.5の新機能を反映
  - 優先度: 中
  - 推定工数: 2時間

#### 5.2 リンク切れ
- 🔗 **無効なリンク**
  - なし ✅

## 📊 更新優先度マトリクス

| 項目 | 優先度 | 工数 | 影響範囲 | 期限 |
|------|--------|------|----------|------|
| セキュリティ設定強化 | 高 | 30分 | .gitignore | 1週間以内 |
| TypeScript 5.7対応 | 中 | 1時間 | 設定ファイル | 1ヶ月以内 |
| ドキュメント更新 | 中 | 2時間 | docs/ | 1ヶ月以内 |
| Claude Code新機能 | 中 | 2時間 | commands/ | 2ヶ月以内 |
| Node.js 22対応 | 低 | 30分 | package.json | 3ヶ月以内 |
| Mermaid図追加 | 低 | 3時間 | templates/ | 任意 |

## 🎯 推奨アクションプラン

### Phase 1: 緊急対応（1週間）
1. セキュリティ設定の強化
   - .gitignoreに新しいパターン追加
   - .template-ignoreの更新

### Phase 2: 重要な更新（1ヶ月）
1. TypeScript 5.7への対応
   - package.jsonの更新
   - tsconfig.jsonの推奨設定適用

2. ドキュメントの更新
   - WORKFLOW_GUIDE.mdの改訂
   - 新しいベストプラクティスの追加

3. Claude Code新機能の統合
   - コマンドファイルの改善
   - 新しい構文の採用

### Phase 3: 将来的な改善（3ヶ月）
1. Node.js 22対応
2. Mermaid図の追加
3. パフォーマンス最適化

## 🔧 自動更新可能な項目

以下は自動的に更新できる項目です:

- ✅ package.jsonの依存関係バージョン
- ✅ .gitignoreのパターン追加
- ✅ ドキュメントの日付フィールド
- ✅ バージョン番号の更新

## 📋 Next Actions

1. **優先度の高い項目から着手**
   ```bash
   # セキュリティ設定の更新を開始
   ```

2. **更新ブランチで作業**
   ```bash
   # 既に template-update/v1.1 ブランチで作業中
   ```

3. **各更新後にテスト**
   ```bash
   /check-template-health
   ```

4. **完了後にマージ準備**
   ```bash
   /merge-template-update
   ```

## 🔗 関連コマンド
- `/check-template-health` - テンプレートの健全性チェック
- `/merge-template-update` - 更新をmainブランチにマージ

---

**スキャン完了**: 合計7件の更新項目を検出しました。推奨されるアクションプランに従って更新を進めてください。
```

## 使用例

```bash
# 基本的な使用
/template-update-scan

# 特定カテゴリのみスキャン
/template-update-scan --category ecosystem

# JSON形式で出力
/template-update-scan --format json
```

## Notes

- このコマンドは読み取り専用で、ファイルを変更しません
- ネットワーク接続が必要（外部情報の取得のため）
- 実行時間: 約3-5分
- `/check-template-health` の実行後に使用することを推奨
