# スペックテンプレート利用ガイド

## 概要

このドキュメントでは、プロジェクト初期化とスペックドキュメント作成のためのテンプレートと、それらを活用したワークフローを説明します。

---

## 🚀 クイックスタート

### 1. 新規プロジェクトの初期化

```bash
/init-project [project-name]
```

このコマンドを実行すると、対話形式でプロジェクト情報を収集し、以下のドキュメントを自動生成します：

- **PROJECT_OVERVIEW.md** - プロジェクト概要
- **TECHNICAL_ARCHITECTURE.md** - 技術アーキテクチャ
- **DEVELOPMENT_STANDARDS.md** - 開発標準
- **PHASE_PLAN.md** - フェーズ別実装計画

### 2. 生成されるディレクトリ構造

```
specs/
├── PROJECT_OVERVIEW.md           # プロジェクト概要
├── TECHNICAL_ARCHITECTURE.md     # 技術アーキテクチャ
├── DEVELOPMENT_STANDARDS.md      # 開発標準
├── PHASE_PLAN.md                # フェーズ計画
├── requirements/                # 機能別要件定義
├── technical/                   # 機能別技術仕様
├── implementation/              # 機能別実装ガイド
└── decisions/                   # Architecture Decision Records
```

---

## 📋 スペックテンプレート詳細

### PROJECT_OVERVIEW.md テンプレート

**用途**: プロジェクトの全体像、ビジネス目標、ステークホルダー情報を記録

**主要セクション**:
1. **エグゼクティブサマリー**: ビジョン、ミッション、価値提案
2. **ビジネスコンテキスト**: 背景、目標、市場分析、ROI
3. **ステークホルダー**: チーム、関係者、エンドユーザー
4. **スコープ定義**: MVP機能、フェーズ計画、境界条件
5. **成功基準**: ビジネス指標、技術指標、満足度指標
6. **リスクと課題**: 技術・ビジネスリスク、既知の課題
7. **依存関係**: 技術・組織・外部依存
8. **予算とリソース**: 開発予算、必要リソース
9. **コミュニケーション計画**: 定例会議、レポーティング

**記入のポイント**:
- ビジネス価値を明確に
- 定量的な目標設定
- ステークホルダーの期待値管理

### TECHNICAL_ARCHITECTURE.md テンプレート

**用途**: システムの技術的な設計、アーキテクチャパターン、技術スタックを定義

**主要セクション**:
1. **システムアーキテクチャ**: アーキテクチャ図、パターン、設計原則
2. **技術スタック**: フロントエンド、バックエンド、DB、インフラ
3. **データアーキテクチャ**: ERD、エンティティ定義、データフロー
4. **セキュリティアーキテクチャ**: 認証/認可フロー、OWASP対策
5. **パフォーマンスアーキテクチャ**: 目標値、最適化戦略
6. **可用性とレジリエンス**: SLA、障害対策、DR計画
7. **API設計**: API規約、共通仕様、エラーコード
8. **インテグレーション**: 外部サービス連携、Webhook
9. **監視とロギング**: ログ戦略、監視項目
10. **デプロイメントアーキテクチャ**: 環境構成、CI/CD

**記入のポイント**:
- 図を多用して視覚的に
- 技術選定の理由を明記
- 非機能要件を具体的に

### DEVELOPMENT_STANDARDS.md テンプレート

**用途**: チーム全体で遵守すべき開発標準、コーディング規約を定義

**主要セクション**:
1. **コーディング規約**: 言語別規約、命名規則、コメント規約
2. **ディレクトリ構造**: 標準構造、ファイル配置規約
3. **テスト戦略**: テストピラミッド、各種テスト規約
4. **Git ワークフロー**: ブランチ戦略、コミットメッセージ、PR規約
5. **コード品質管理**: 静的解析、品質ゲート、カバレッジ目標
6. **セキュリティガイドライン**: OWASP対策、環境変数管理
7. **パフォーマンスガイドライン**: 最適化ベストプラクティス
8. **エラーハンドリング**: エラークラス定義、ハンドリングパターン
9. **ドキュメンテーション**: 必須ドキュメント、コードドキュメント
10. **CI/CD**: CI パイプライン、デプロイフロー

**記入のポイント**:
- 具体的なコード例を提示
- Good/Bad例を明示
- 実施可能な内容に

### PHASE_PLAN.md テンプレート

**用途**: プロジェクトをフェーズに分割し、具体的な実装計画を策定

**主要セクション**:
1. **全体計画**: タイムライン、フェーズ概要、マイルストーン
2. **Phase 1 (MVP)**:
   - 機能リスト（優先度付き）
   - 技術実装計画（DB、API、UI）
   - 週次実装スケジュール
   - 成果物と受入基準
3. **Phase 2-4**: 同様の構造
4. **フェーズ間の依存関係**: 依存関係図
5. **リソース計画**: チーム構成、外部リソース
6. **予算配分**: Phase別予算
7. **品質保証計画**: テスト戦略、品質ゲート
8. **リスク管理**: 全体リスク、Phase別リスク
9. **成功指標**: Phase別KPI、累積KPI

**記入のポイント**:
- 優先度を明確に（P0/P1/P2）
- 依存関係を可視化
- 現実的な工数見積もり

---

## ⭐ レビュー管理テンプレート（新機能）

### REVIEW_RESULT.md テンプレート

**用途**: スペックレビューの結果と改善項目を記録

**配置場所**: `/specs/reviews/pending/[feature-name].md`

**主要セクション**:
1. **メタデータ**:
   - レビュー日時
   - 総合スコア
   - レビュアー
   - 対応状況

2. **総合評価**:
   - スコア（0-100%）
   - 評価ランク（Excellent/Good/Needs Improvement）
   - サマリーコメント

3. **詳細スコア**:
   - Requirements: X% (評価)
   - Technical: X% (評価)
   - Implementation: X% (評価)

4. **課題サマリー**:
   - 🔴 Critical: X項目
   - 🟡 Important: X項目
   - 🟢 Minor: X項目

5. **改善項目詳細**:
   各項目について：
   - タイトル
   - 優先度
   - 期限
   - 影響範囲
   - 詳細ファイルへのリンク

6. **次のステップ**:
   - 推奨アクション
   - 関連コマンド

**テンプレート例**:
```markdown
# [Feature Name] - Review Result

## メタデータ
- **レビュー日**: 2025-11-15
- **総合スコア**: 92%
- **レビュアー**: Claude Code
- **対応状況**: ⏳ Pending / ✅ Completed

---

## 総合評価

📊 **スコア**: 92% (Approved with conditions)

### 評価ランク
Good - 実装可能だが、いくつかの改善推奨

### サマリーコメント
全体的に高品質な仕様書。セキュリティとパフォーマンスの一部に改善余地あり。

---

## 詳細スコア

| ドキュメント | スコア | 評価 | コメント |
|------------|-------|------|---------|
| Requirements | 95% | Excellent | ユーザーストーリーが明確 |
| Technical | 90% | Good | API設計は優秀、セキュリティ要補強 |
| Implementation | 90% | Good | 実装手順は具体的、一部詳細化必要 |

---

## 課題サマリー

- 🔴 **Critical**: 0項目
- 🟡 **Important**: 2項目
- 🟢 **Minor**: 5項目

---

## 改善項目詳細

### 🟡 Important

#### 1. 環境依存の暗号化キー管理強化
- **期限**: 実装開始前
- **影響範囲**: セキュリティ、運用
- **詳細**: `/specs/improvements/important/encryption-key-management.md`

#### 2. レート制限の実装詳細化
- **期限**: Phase 3前
- **影響範囲**: パフォーマンス、セキュリティ
- **詳細**: `/specs/improvements/important/rate-limiting-details.md`

### 🟢 Minor
詳細は `/specs/improvements/minor/index.md` を参照

---

## 次のステップ

1. `/review-actions [feature-name]` で改善項目を確認
2. Critical/Important項目を優先的に対処
3. `/implement-improvements [improvement-name]` で個別実装
4. または `/implement [feature-name]` でそのまま実装開始
```

---

### IMPROVEMENT_ITEM.md テンプレート

**用途**: 個別の改善項目の詳細と実装ガイド

**配置場所**: `/specs/improvements/{critical|important|minor}/[improvement-name].md`

**主要セクション**:
1. **メタデータ**:
   - 優先度（Critical/Important/Minor）
   - 期限
   - 担当
   - ステータス

2. **概要**:
   - 問題の説明
   - なぜ重要か
   - 影響範囲

3. **関連スペック**:
   - 対象機能名
   - 関連ドキュメントへのリンク

4. **実装ガイド**:
   - Step 1: 仕様書更新
   - Step 2: コード実装
   - Step 3: テスト追加

5. **コード例**:
   具体的な実装コード

6. **完了条件**:
   チェックリスト形式

7. **参考資料**:
   関連ドキュメント、外部リンク

**テンプレート例**:
```markdown
# 環境依存の暗号化キー管理強化

## メタデータ
- **優先度**: 🟡 Important
- **期限**: 実装開始前
- **担当**: Security Lead
- **ステータス**: ⏳ Pending
- **関連レビュー**: `/specs/reviews/pending/user-api-key-management.md`

---

## 概要

### 問題の説明
現在の仕様では暗号化キーが環境変数に直接格納されることを想定しているが、本番環境での運用を考慮すると、より堅牢なシークレット管理が必要。

### なぜ重要か
- APIキーは高度に機密性の高いデータ
- 環境変数の誤った取り扱いによる漏洩リスク
- 運用時のキーローテーションが困難

### 影響範囲
- セキュリティ: 高
- 運用: 中
- 開発: 低

---

## 関連スペック

- **対象機能**: user-api-key-management
- **Technical仕様**: `/specs/technical/user-api-key-management.md`
- **Implementation仕様**: `/specs/implementation/user-api-key-management.md`

---

## 実装ガイド

### Step 1: 仕様書の更新

**Technical仕様書に追加** (`/specs/technical/user-api-key-management.md`):

\`\`\`markdown
## シークレット管理

### AWS Secrets Manager統合
- **環境変数**:
  - AWS_REGION
  - SECRETS_MANAGER_PREFIX
- **シークレット名**: {環境}/api-key-encryption
- **キーローテーション**: 90日ごと自動ローテーション
- **アクセス制御**: IAMロールベース

### 環境別設定
- **Development**: ローカル環境変数（.env.local）
- **Staging**: AWS Secrets Manager
- **Production**: AWS Secrets Manager + 自動ローテーション
\`\`\`

### Step 2: コード実装

\`\`\`typescript
// src/lib/secrets-manager.ts
import { SecretsManagerClient, GetSecretValueCommand } from '@aws-sdk/client-secrets-manager';

export class SecretsManager {
  private client: SecretsManagerClient;

  constructor() {
    this.client = new SecretsManagerClient({
      region: process.env.AWS_REGION
    });
  }

  async getEncryptionKey(): Promise<string> {
    const secretId = \`\${process.env.ENVIRONMENT}/api-key-encryption\`;

    const command = new GetSecretValueCommand({
      SecretId: secretId
    });

    const response = await this.client.send(command);
    return response.SecretString!;
  }
}

// src/lib/encryption.ts に統合
import { SecretsManager } from './secrets-manager';

export class Encryption {
  private secretsManager: SecretsManager;

  constructor() {
    this.secretsManager = new SecretsManager();
  }

  async encrypt(plaintext: string): Promise<string> {
    const key = await this.secretsManager.getEncryptionKey();
    // 暗号化ロジック
  }
}
\`\`\`

### Step 3: テスト追加

\`\`\`typescript
// src/lib/__tests__/secrets-manager.test.ts
describe('SecretsManager', () => {
  it('should retrieve encryption key from AWS Secrets Manager', async () => {
    const sm = new SecretsManager();
    const key = await sm.getEncryptionKey();
    expect(key).toBeDefined();
    expect(key.length).toBeGreaterThan(0);
  });

  it('should handle secret not found error', async () => {
    // エラーハンドリングのテスト
  });
});
\`\`\`

---

## 完了条件

- [ ] AWS Secrets Manager統合コード実装
- [ ] 環境別設定ドキュメント化
- [ ] キーローテーション手順文書化
- [ ] 開発環境でのフォールバック実装
- [ ] 単体テスト追加（カバレッジ >80%）
- [ ] 統合テスト追加
- [ ] セキュリティチームレビュー承認

---

## 参考資料

- [AWS Secrets Manager Documentation](https://docs.aws.amazon.com/secretsmanager/)
- [Best Practices for Managing Secrets](https://...)
- 社内セキュリティガイドライン v2.3
```

---

### MINOR_IMPROVEMENTS_INDEX.md テンプレート

**用途**: 複数のMinor改善項目を一覧管理

**配置場所**: `/specs/improvements/minor/index.md`

**テンプレート例**:
```markdown
# Minor Improvements - [Feature Name]

## 概要
品質向上のための推奨改善項目リスト

---

## 改善項目リスト

### 1. Success Metrics測定環境の確定
**説明**: Technical仕様のSuccess Metricsセクションで、どの環境で測定するかを明記
**影響**: ドキュメント品質
**推奨対応時期**: Phase 1実装時
**優先度**: Low

### 2. ADMINロールスコープの明確化
**説明**: Phase 1でのADMINロールの実装範囲を明確化
**影響**: 実装スコープ
**推奨対応時期**: Phase 1開始前
**優先度**: Low

### 3. エラーメッセージ多言語対応の詳細化
**説明**: エラーメッセージの多言語対応方法（i18nライブラリ、メッセージキーなど）を詳細化
**影響**: 実装詳細
**推奨対応時期**: Phase 4実装時
**優先度**: Low

### 4. APIキーマスキングルールの統一
**説明**: マスキング表示のルール（何文字表示するか）を統一
**影響**: UI一貫性
**推奨対応時期**: Phase 4実装時
**優先度**: Low

### 5. Approvalセクションの完成
**説明**: Implementation仕様のApprovalセクションを完全に埋める
**影響**: ドキュメント完全性
**推奨対応時期**: 実装開始前
**優先度**: Low

---

## 対応状況

| 項目 | ステータス | 対応日 | 担当 |
|-----|----------|--------|------|
| 1. Success Metrics測定環境 | ⏳ Pending | - | - |
| 2. ADMINロールスコープ | ⏳ Pending | - | - |
| 3. エラーメッセージ多言語対応 | ⏳ Pending | - | - |
| 4. APIキーマスキングルール | ⏳ Pending | - | - |
| 5. Approvalセクション | ⏳ Pending | - | - |
```

---

## 🔄 ワークフロー統合

### プロジェクト開始からMVPリリースまで

```
1. プロジェクト初期化
   ↓
   /init-project my-project
   ↓
   [対話形式で情報収集]
   ↓
   [4つのスペックドキュメント自動生成]

2. スペックレビューと調整
   ↓
   各ドキュメントを確認・編集
   ↓
   ステークホルダーレビュー

3. 機能別要件定義
   ↓
   /add-requirements [feature-1]
   ↓
   /add-requirements [feature-2]

4. 技術仕様作成
   ↓
   /add-technical [feature-1]
   ↓
   /spec-check [feature-1]

5. 実装ガイド作成
   ↓
   /add-implementation [feature-1]
   ↓
   /spec-check [feature-1]

6. 実装
   ↓
   /implement [feature-1]
   ↓
   [TDD方式で実装]

7. 実装確認
   ↓
   /check-implementation [feature-1]
   ↓
   [品質ゲート通過確認]

8. スペック更新
   ↓
   /update-specs [feature-1]
   ↓
   [実装結果を仕様書に反映]

9. コミット
   ↓
   /commit-prep
   ↓
   [最終品質チェック→コミット]

10. 次の機能へ（ステップ3に戻る）
```

---

## 📝 テンプレート使用例

### 例1: SaaSアプリケーション

```bash
/init-project enterprise-ai-platform
```

**生成される PROJECT_OVERVIEW.md の例**:
- **ビジョン**: AIを活用した業務効率化プラットフォーム
- **MVP機能**:
  - マルチテナント認証
  - 日次振り返りエージェント
  - レポート機能
- **Phase 1期間**: 3ヶ月
- **成功指標**: MAU 1,000人、NPS > 50

### 例2: eコマースプラットフォーム

```bash
/init-project ecommerce-platform
```

**生成される TECHNICAL_ARCHITECTURE.md の例**:
- **アーキテクチャ**: マイクロサービス
- **技術スタック**: Next.js, PostgreSQL, Redis, Stripe
- **主要機能**: 商品管理、カート、決済、在庫管理
- **SLA**: 99.9% uptime

---

## 🎯 ベストプラクティス

### 1. プロジェクト初期化時

✅ **Do**:
- すべての質問に丁寧に回答
- 不明確な点は後で更新可能
- ステークホルダーを巻き込む
- 定量的な目標を設定

❌ **Don't**:
- 曖昧な回答で進めない
- スコープを大きくしすぎない
- 実現不可能な目標を設定しない

### 2. スペックドキュメント記入時

✅ **Do**:
- 具体的な数値を記載
- 図やテーブルを活用
- 技術選定の理由を明記
- リスクを正直に記載

❌ **Don't**:
- 抽象的な表現で済ませない
- 重要な情報を省略しない
- 楽観的すぎる計画を立てない

### 3. スペック更新時

✅ **Do**:
- 実装結果を正確に反映
- 変更理由を記録（ADR）
- 学びを次に活かす
- 定期的にレビュー

❌ **Don't**:
- 更新を怠らない
- 形骸化させない
- 決定事項を記録し忘れない

---

## 🔧 カスタマイズ

### テンプレートのカスタマイズ方法

1. **テンプレートファイルを編集**:
   ```bash
   # テンプレート編集
   specs/templates/PROJECT_OVERVIEW.template.md
   specs/templates/TECHNICAL_ARCHITECTURE.template.md
   specs/templates/DEVELOPMENT_STANDARDS.template.md
   specs/templates/PHASE_PLAN.template.md
   ```

2. **セクションの追加/削除**:
   - プロジェクトに必要なセクションを追加
   - 不要なセクションを削除
   - 順序の変更

3. **スラッシュコマンドのカスタマイズ**:
   ```bash
   # コマンドファイル編集
   .claude/commands/init-project.md
   ```

### 組織固有の規約追加

```markdown
## [組織名] 固有の規約

### コーディング規約
- [組織固有の規約1]
- [組織固有の規約2]

### デプロイメントルール
- [組織固有のルール1]
- [組織固有のルール2]
```

---

## 📚 関連ドキュメント

- [WORKFLOW_GUIDE.md](./WORKFLOW_GUIDE.md) - 8ステップワークフロー詳細
- [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md) - 実装計画
- [A2A_PROTOCOL_GUIDE.md](./A2A_PROTOCOL_GUIDE.md) - A2Aプロトコルガイド

---

## ❓ よくある質問

### Q1: プロジェクト途中からテンプレートを使える？

**A**: はい、可能です。既存のドキュメントをテンプレートに合わせて再構成することをお勧めします。

### Q2: テンプレートをすべて埋める必要がある？

**A**: いいえ。プロジェクトの規模に応じて、必要なセクションのみ記入してください。

### Q3: スペック更新の頻度は？

**A**:
- 実装完了時: 必須
- フェーズ完了時: 必須
- 定期レビュー: 月1回推奨

### Q4: ADRはいつ作成する？

**A**: 以下の場合に作成：
- アーキテクチャの重要な決定
- 技術スタックの選定/変更
- 実装方針の変更
- トレードオフを伴う決定

---

## 📞 サポート

### フィードバック
テンプレートの改善提案は Issue で受け付けています。

### 質問
プロジェクト固有の質問は、各プロジェクトのチャネルで。

---

**最終更新**: 2025-11-13
**バージョン**: 1.0
**ステータス**: 完成
