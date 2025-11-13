# MCP (Model Context Protocol) セットアップガイド

このプロジェクトでは、以下のMCPサーバーを使用しています。

## 使用中のMCPサーバー

### 1. Kiri (Code Intelligence)
**バージョン**: v0.10.0
**用途**: コードベースのセマンティック検索とコンテキスト理解

**機能**:
- `context_bundle`: コードベース全体からコンテキストを取得
- `semantic_rerank`: セマンティック検索による再ランク付け
- `files_search`: ファイル検索
- `snippets_get`: コードスニペット取得
- `deps_closure`: 依存関係グラフの探索

**設定**: `.mcp.json`
```json
{
  "kiri": {
    "type": "stdio",
    "command": "npx",
    "args": [
      "-y",
      "kiri-mcp-server@latest",
      "--repo",
      ".",
      "--db",
      ".kiri/index.duckdb",
      "--watch"
    ]
  }
}
```

**インデックス**: `.kiri/index.duckdb` (5.5MB)

### 2. Serena (Code Agent)
**用途**: シンボリックなコード操作と編集

**機能**:
- `list_dir`: ディレクトリ一覧
- `find_file`: ファイル検索
- `search_for_pattern`: パターン検索
- `get_symbols_overview`: シンボル概要取得
- `find_symbol`: シンボル検索
- `find_referencing_symbols`: 参照検索
- `replace_symbol_body`: シンボル本体の置換
- `insert_after_symbol` / `insert_before_symbol`: シンボル挿入
- `rename_symbol`: シンボルのリネーム
- メモリ機能 (`write_memory`, `read_memory`, `list_memories`)

**設定**: `.mcp.json`
```json
{
  "serena": {
    "type": "stdio",
    "command": "uvx",
    "args": [
      "--from",
      "git+https://github.com/oraios/serena",
      "serena-mcp-server",
      "--context",
      "ide-assistant",
      "--project",
      "/Users/kazuki/workspace/sandbox/a2a-demo"
    ],
    "env": {}
  }
}
```

### 3. Context7 (Documentation)
**用途**: ライブラリの最新ドキュメント取得

**機能**:
- `resolve-library-id`: ライブラリIDの解決
- `get-library-docs`: ライブラリドキュメントの取得

**設定**: `.mcp.json`
```json
{
  "context7": {
    "type": "stdio",
    "command": "npx",
    "args": [
      "-y",
      "@upstash/context7-mcp@latest"
    ],
    "env": {}
  }
}
```

### 4. Next.js DevTools
**用途**: Next.jsアプリケーションの開発ツール

**機能**:
- `init`: Next.js DevToolsの初期化
- `nextjs_docs`: Next.jsドキュメント検索
- `nextjs_runtime`: ランタイム情報取得
- `browser_eval`: ブラウザ自動化
- `upgrade_nextjs_16`: Next.js 16へのアップグレード
- `enable_cache_components`: Cache Componentsの有効化

**設定**: `.mcp.json`
```json
{
  "next-devtools": {
    "type": "stdio",
    "command": "npx",
    "args": [
      "-y",
      "next-devtools-mcp@latest"
    ]
  }
}
```

### 5. Chrome DevTools
**用途**: Chromeブラウザの自動化とデバッグ

**機能**:
- ページ操作 (`click`, `fill`, `navigate_page`, `new_page`)
- スクリーンショット (`take_screenshot`, `take_snapshot`)
- ネットワーク監視 (`list_network_requests`, `get_network_request`)
- コンソール監視 (`list_console_messages`, `get_console_message`)
- パフォーマンス分析 (`performance_start_trace`, `performance_stop_trace`)

**設定**: `.mcp.json`
```json
{
  "chrome-devtools": {
    "type": "stdio",
    "command": "npx",
    "args": [
      "-y",
      "chrome-devtools-mcp@latest"
    ],
    "env": {}
  }
}
```

### 6. Filesystem
**用途**: ファイルシステムへのアクセス

**機能**:
- ファイル読み書き (`read_text_file`, `write_file`, `edit_file`)
- ディレクトリ操作 (`list_directory`, `create_directory`, `directory_tree`)
- ファイル検索 (`search_files`)
- ファイル情報取得 (`get_file_info`)

**設定**: `.mcp.json`
```json
{
  "filesystem": {
    "type": "stdio",
    "command": "npx",
    "args": [
      "-y",
      "@modelcontextprotocol/server-filesystem",
      "/Users/kazuki/Desktop",
      "/Users/kazuki/Downloads",
      "/Users/kazuki/workspace"
    ]
  }
}
```

## セットアップ手順

### 初回セットアップ

1. **`.mcp.json`ファイルを作成**

プロジェクトルートに`.mcp.json`ファイルを作成します（既に存在する場合はスキップ）。

```bash
cp .mcp.json.example .mcp.json
```

2. **ユーザー名を設定**

`.mcp.json`内の`<YOUR_USERNAME>`を実際のユーザー名に置き換えます。

```json
"/Users/<YOUR_USERNAME>/workspace"
→
"/Users/kazuki/workspace"
```

3. **Kiriのインデックスを初期化**

Kiriは`--watch`モードで動作しているため、Claude Codeを起動すると自動的にインデックスが作成されます。

手動でインデックスを作成する場合:

```bash
npx kiri-mcp-server@latest --repo . --db .kiri/index.duckdb
```

4. **Serenaの依存関係をインストール**

Serenaは`uvx`を使用しているため、初回実行時に自動的にインストールされます。

事前にインストールする場合:

```bash
uvx --from git+https://github.com/oraios/serena serena-mcp-server --help
```

## 更新手順

### 全MCPサーバーを最新版に更新

各MCPサーバーは`@latest`を指定しているため、Claude Codeを再起動すると自動的に最新版が使用されます。

### Kiriのインデックスを更新

コードベースに大きな変更があった場合、Kiriのインデックスを手動で再構築できます:

```bash
# インデックスを削除
rm -rf .kiri/index.duckdb*

# Claude Codeを再起動してインデックスを再作成
# または手動で作成:
npx kiri-mcp-server@latest --repo . --db .kiri/index.duckdb
```

### Serenaを最新版に更新

Serenaは常にGitHubリポジトリから最新版を取得します:

```bash
uvx --from git+https://github.com/oraios/serena serena-mcp-server --help
```

## トラブルシューティング

### Kiriのインデックスが古い

**症状**: コード検索の結果が最新のコードを反映していない

**解決策**:
```bash
# インデックスを削除して再作成
rm -rf .kiri/index.duckdb*
# Claude Codeを再起動
```

### Serenaが起動しない

**症状**: Serenaのツールが使用できない

**解決策**:
```bash
# uvが正しくインストールされているか確認
which uvx

# uvをインストール（macOS）
curl -LsSf https://astral.sh/uv/install.sh | sh

# Serenaを手動で実行してエラーを確認
uvx --from git+https://github.com/oraios/serena serena-mcp-server \
  --context ide-assistant \
  --project /Users/kazuki/workspace/sandbox/a2a-demo
```

### MCPサーバーが起動しない

**症状**: Claude Code起動時にMCPサーバーのエラーが表示される

**解決策**:
1. `.mcp.json`の構文エラーを確認
2. パスが正しいか確認
3. 必要なツール（`npx`, `uvx`）がインストールされているか確認
4. Claude Codeのログを確認

### パフォーマンスが遅い

**症状**: コード検索やツールの実行が遅い

**解決策**:
1. Kiriのインデックスサイズを確認（`.kiri/index.duckdb`）
2. 不要なファイルを`.gitignore`に追加
3. `.kiri/.gitignore`で除外パターンを設定

## ベストプラクティス

### Kiri

- **定期的なインデックス更新**: 大きなリファクタリング後はインデックスを再作成
- **適切な除外設定**: `node_modules`, `dist`, `.next`などはインデックスから除外
- **効率的なクエリ**: 具体的なキーワードを使用して検索

### Serena

- **シンボル単位の操作**: 細かいコード変更にはSerenaのシンボル操作を活用
- **メモリ機能の活用**: プロジェクト固有の情報をメモリに保存
- **段階的なリファクタリング**: 大きな変更は小さなステップに分割

### 全般

- **`.mcp.json`のバージョン管理**: プロジェクト固有の設定は`.mcp.json`で管理
- **ローカル設定の分離**: ユーザー固有の設定は`.mcp.json.local`（gitignore）
- **定期的な更新**: MCPサーバーは活発に開発されているため、定期的に更新

## リソース

- [Kiri Documentation](https://github.com/kiri-ai/kiri)
- [Serena Documentation](https://github.com/oraios/serena)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Claude Code Documentation](https://docs.claude.com/claude-code)

## 現在のステータス

**最終更新**: 2025-11-13

| MCPサーバー | バージョン | ステータス | インデックスサイズ |
|------------|----------|----------|----------------|
| Kiri | v0.10.0 | ✅ 稼働中 | 5.5MB |
| Serena | latest (2d7527b) | ✅ 稼働中 | - |
| Context7 | latest | ✅ 稼働中 | - |
| Next DevTools | latest | ✅ 稼働中 | - |
| Chrome DevTools | latest | ✅ 稼働中 | - |
| Filesystem | latest | ✅ 稼働中 | - |

すべてのMCPサーバーが正常に稼働しています。
