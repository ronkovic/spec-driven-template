# /review-actions

レビューで指摘されたアクションアイテムを確認し、対処状況を管理するコマンド。

## 使用方法

```bash
# 特定機能のレビューアクションを確認
/review-actions [feature-name]

# すべての pending レビューアクションを確認
/review-actions --all

# 優先度でフィルタ
/review-actions --priority=important
```

## タスク

1. **レビュー結果の読み込み**
   - `/specs/reviews/pending/` ディレクトリから対象ファイルを読み込み
   - ステータスと優先度を確認

2. **改善項目の表示**
   - 優先度別（🔴 Critical → 🟡 Important → 🟢 Minor）に表示
   - 各項目の詳細ファイルパスを表示
   - 期限と担当者を明示

3. **実装状況の確認**
   ```markdown
   ## レビューアクション状況

   ### 🟡 Important Issues (2件)
   1. ⏳ **環境依存の暗号化キー管理強化**
      - ファイル: `/specs/improvements/important/encryption-key-management.md`
      - 担当: Security Lead
      - 期限: 実装開始前

   2. ⏳ **レート制限の実装詳細化**
      - ファイル: `/specs/improvements/important/rate-limiting-details.md`
      - 担当: Tech Lead
      - 期限: Phase 3前

   ### 🟢 Minor Issues (5件)
   [詳細は `/specs/improvements/minor/index.md` 参照]
   ```

4. **次のアクション提案**
   ```bash
   # 個別の改善項目を実装
   /implement-improvements encryption-key-management

   # 実装開始（レビュー結果を自動参照）
   /implement [feature-name]
   ```

5. **ステータス更新**
   - 完了した項目を `pending` から `completed` に移動
   - 進捗レポートの生成

## 実装詳細

```typescript
// レビューアクションの処理フロー
async function handleReviewActions(featureName?: string, options?: { priority?: string, all?: boolean }) {
  // 1. レビューファイルを検索
  const reviewFiles = await findReviewFiles(featureName, options);

  // 2. 改善項目を読み込み
  const improvements = await loadImprovements(reviewFiles);

  // 3. 優先度別にソート
  const sorted = sortByPriority(improvements);

  // 4. ステータスレポート生成
  const report = generateStatusReport(sorted);

  // 5. 次のアクション提案
  const nextActions = suggestNextActions(sorted);

  return { report, nextActions };
}
```

## 関連コマンド

- `/implement-improvements` - 個別の改善項目を実装
- `/implement` - 機能実装（レビュー結果を自動参照）
- `/review-specs` - 仕様書のレビュー実行