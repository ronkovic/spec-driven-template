---
name: dependency-updater
description: package.jsonと依存関係の自動更新スキル
tags: [maintenance, dependencies, automation]
---

# Dependency Updater Skill

Node.js/TypeScriptプロジェクトの依存関係を安全に更新するための再利用可能なスキルです。

## 目的

依存関係の更新プロセスを自動化し、互換性とセキュリティを維持します。

## 使用場面

- `/template-update-scan` で古い依存関係が検出された時
- セキュリティ脆弱性が報告された時
- 定期メンテナンス時
- Major/Minorアップデートの適用時

## 機能

### 1. 現状分析

```bash
# 現在の依存関係の状態を確認
npm outdated --json
npm audit --json

# 出力例
{
  "typescript": {
    "current": "5.3.0",
    "wanted": "5.3.9",
    "latest": "5.7.0",
    "location": "node_modules/typescript"
  }
}
```

### 2. 更新計画の作成

```typescript
interface UpdatePlan {
  safe: Dependency[];      // 自動更新可能（patch, minor）
  review: Dependency[];    // レビュー必要（major）
  security: Dependency[];  // セキュリティ修正
  breaking: Dependency[];  // Breaking changes
}

interface Dependency {
  name: string;
  current: string;
  target: string;
  type: 'patch' | 'minor' | 'major';
  security: boolean;
  breaking: boolean;
  testRequired: boolean;
}
```

### 3. 段階的更新

#### Phase 1: セキュリティ更新（優先）

```bash
# セキュリティ脆弱性の自動修正
npm audit fix

# 強制修正（Breaking changesを含む）
npm audit fix --force  # 注意: 慎重に使用
```

#### Phase 2: Patch更新（安全）

```bash
# Patchバージョンのみ更新
npm update --save

# 特定パッケージのpatch更新
npm update typescript
```

#### Phase 3: Minor更新（通常安全）

```bash
# Minorバージョンを含めて更新
npm update --save

# または個別に
npm install typescript@^5.7.0
```

#### Phase 4: Major更新（慎重に）

```bash
# Majorバージョンの更新（手動確認必要）
npm install typescript@6.0.0

# Breaking changesドキュメントを確認
# テストを実行
# 問題がなければコミット
```

## 実行手順

### Step 1: 更新前の準備

```bash
# 1. 現在の状態を保存
git add .
git commit -m "chore: save current state before dependency update"

# 2. 新しいブランチを作成
git checkout -b chore/dependency-update-$(date +%Y%m%d)

# 3. 現在のテストが通ることを確認
npm test
```

### Step 2: 依存関係の分析

```typescript
// Bash toolで実行
const outdated = await bash('npm outdated --json');
const audit = await bash('npm audit --json');

// 分析
const updates = analyzeUpdates(JSON.parse(outdated));
const vulnerabilities = analyzeVulnerabilities(JSON.parse(audit));
```

### Step 3: 更新の実行

```typescript
// TodoWriteで進捗管理
const todos = [
  {
    content: "セキュリティ更新の適用",
    status: "in_progress",
    activeForm: "セキュリティ更新を適用中"
  },
  {
    content: "Patch更新の適用",
    status: "pending",
    activeForm: "Patch更新を適用中"
  },
  {
    content: "テストの実行",
    status: "pending",
    activeForm: "テストを実行中"
  },
  {
    content: "package-lock.jsonの更新",
    status: "pending",
    activeForm: "ロックファイルを更新中"
  }
];

// 各更新を順次実行
for (const update of updates.safe) {
  await bash(`npm install ${update.name}@${update.target}`);
  await bash('npm test');  // 各更新後にテスト
}
```

### Step 4: 検証

```bash
# 1. テストの実行
npm test

# 2. ビルドの確認
npm run build

# 3. 型チェック
npm run type-check

# 4. Lint
npm run lint
```

### Step 5: 更新内容の記録

```typescript
// package.jsonの差分を確認
const diff = await bash('git diff package.json');

// CHANGELOGに記録
const changelogEntry = generateChangelogEntry({
  version: getNextPatchVersion(),
  type: 'dependencies',
  changes: updates.applied
});

await appendToChangelog(changelogEntry);
```

## 安全機能

### 1. ロックファイルの検証

```bash
# package-lock.jsonの整合性確認
npm ci  # クリーンインストール

# エラーがある場合
npm install  # ロックファイルを再生成
```

### 2. 自動ロールバック

```typescript
async function updateWithRollback(
  packageName: string,
  version: string
): Promise<boolean> {
  // 現在の状態を保存
  const backup = await backupPackageJson();

  try {
    // 更新実行
    await bash(`npm install ${packageName}@${version}`);

    // テスト実行
    await bash('npm test');

    return true;
  } catch (error) {
    // エラー時はロールバック
    await restorePackageJson(backup);
    await bash('npm install');  // ロックファイルを復元

    console.error(`Failed to update ${packageName}: ${error.message}`);
    return false;
  }
}
```

### 3. Breaking Changes検出

```typescript
interface BreakingChange {
  package: string;
  version: string;
  changes: string[];
  migrationGuide: string;
}

async function detectBreakingChanges(
  packageName: string,
  fromVersion: string,
  toVersion: string
): Promise<BreakingChange[]> {
  // CHANGELOGやリリースノートを確認
  // WebSearchで最新情報を取得
  const releaseNotes = await fetchReleaseNotes(packageName, toVersion);

  // "BREAKING", "Breaking Change"などのキーワードを検索
  const breaking = parseBreakingChanges(releaseNotes);

  return breaking;
}
```

## エラーハンドリング

### 一般的なエラーと対処法

#### 1. Peer dependency conflict

```bash
# エラー例
ERESOLVE unable to resolve dependency tree

# 対処法1: --legacy-peer-deps を使用
npm install --legacy-peer-deps

# 対処法2: --force を使用（最終手段）
npm install --force

# 対処法3: 手動で依存関係を調整
# package.jsonを編集して互換性のあるバージョンを指定
```

#### 2. インストール失敗

```typescript
async function handleInstallFailure(
  error: Error,
  packageName: string
): Promise<void> {
  console.error(`Installation failed for ${packageName}`);

  // 1. キャッシュをクリア
  await bash('npm cache clean --force');

  // 2. node_modulesを削除
  await bash('rm -rf node_modules');

  // 3. 再インストール
  await bash('npm install');

  // それでも失敗する場合
  if (stillFailing) {
    // パッケージをスキップして続行
    skipPackage(packageName);
  }
}
```

#### 3. テスト失敗

```typescript
async function handleTestFailure(
  update: Dependency
): Promise<'rollback' | 'skip' | 'continue'> {
  // Breaking changeかチェック
  if (update.breaking) {
    // 期待されるエラー - 手動対応が必要
    return 'skip';
  }

  // 予期しないエラー - ロールバック
  return 'rollback';
}
```

## 更新レポート

```markdown
# Dependency Update Report

**Date**: 2025-11-14
**Branch**: chore/dependency-update-20251114

## ✅ Successfully Updated (5)

| Package | From | To | Type | Test |
|---------|------|----|----- |------|
| typescript | 5.3.0 | 5.7.0 | minor | ✅ |
| next | 15.0.0 | 15.1.0 | minor | ✅ |
| eslint | 8.50.0 | 8.57.0 | patch | ✅ |
| prettier | 3.0.0 | 3.1.0 | minor | ✅ |
| jest | 29.5.0 | 29.7.0 | patch | ✅ |

## ⚠️ Requires Manual Review (2)

| Package | From | To | Reason |
|---------|------|----|--------|
| react | 18.2.0 | 19.0.0 | Major version - breaking changes |
| prisma | 5.0.0 | 6.0.0 | Major version - migration required |

## ❌ Failed (1)

| Package | Error | Action |
|---------|-------|--------|
| some-package | Peer dependency conflict | Skipped |

## 🔒 Security Fixes (3)

- **axios**: 1.5.0 → 1.6.0 (Moderate severity)
- **semver**: 7.5.0 → 7.5.4 (High severity)
- **jsonwebtoken**: 9.0.0 → 9.0.2 (Low severity)

## 📊 Statistics

- **Total packages checked**: 50
- **Updates available**: 8
- **Successfully updated**: 5
- **Manual review required**: 2
- **Failed**: 1
- **Total time**: 3m 45s

## 📋 Next Actions

1. Review major version updates manually
2. Check migration guides for react and prisma
3. Update code if necessary
4. Run full test suite
5. Commit changes
```

## ベストプラクティス

### 1. 更新頻度

- **Patch**: 週次
- **Minor**: 月次
- **Major**: 四半期または必要時
- **Security**: 即時

### 2. テスト戦略

```bash
# 各更新後に実行
npm test                 # Unit tests
npm run test:integration # Integration tests
npm run build           # Build check
npm run type-check      # TypeScript check
npm run lint            # Linting
```

### 3. ドキュメント更新

```typescript
// 重要な更新はドキュメント化
const majorUpdates = updates.filter(u => u.type === 'major');

for (const update of majorUpdates) {
  // Migration guide を作成
  createMigrationGuide(update);

  // CHANGELOGに追加
  addToChangelog(update);

  // README更新（該当する場合）
  updateReadme(update);
}
```

## パフォーマンス最適化

### 並列更新

```typescript
// 独立したパッケージは並列更新
async function updateInParallel(
  updates: Dependency[]
): Promise<UpdateResult[]> {
  const independent = findIndependentUpdates(updates);

  return Promise.all(
    independent.map(update =>
      updatePackage(update.name, update.target)
    )
  );
}
```

### キャッシュ活用

```bash
# npmのキャッシュを活用
npm config set cache-min 3600

# Offlineモード（キャッシュのみ使用）
npm install --offline
```

---

**作成日**: 2025-11-14
**バージョン**: 1.0
**メンテナンス**: Active
