# 釣り管理システム (Familiar Fishing Management)

釣り具と釣行記録を管理するための Rails アプリケーションです。釣り具の詳細な管理と釣行日誌の記録・検索機能を提供します。

## 概要

このアプリケーションは釣り愛好家向けの管理システムで、以下の機能を提供します：

- ユーザー登録・認証システム
- 釣り具の詳細管理（ロッド、リール、ライン、リーダー、タックル）
- 釣行記録の作成・管理・検索
- カレンダー表示による釣行履歴の可視化
- 管理者機能

## 技術スタック

- **フレームワーク**: Ruby on Rails 8.0.2
- **データベース**: PostgreSQL
- **フロントエンド**:
  - Tailwind CSS（スタイリング）
  - Hotwire（Turbo + Stimulus）
  - Importmap（JavaScript 管理）
- **認証**: bcrypt（パスワードハッシュ化）
- **キャッシュ・キュー**: Solid Cache, Solid Queue, Solid Cable
- **その他**:
  - Simple Calendar（カレンダー表示）
  - Kaminari（ページネーション）
  - Ransack（検索機能）
  - Feedjira（RSS 解析）

## 構成要素

### データベースモデル

- **User（ユーザー）**

  - メールアドレス、パスワード
  - アカウント有効化機能
  - ソフトデリート機能
  - 管理者権限

- **Profile（プロフィール）**

  - ユーザーの個人情報
  - 居住地、釣り場、興味のある釣り種

- **Rod（ロッド）**

  - ロッド名、ブランド、長さ
  - 釣り種、パワー、リールタイプ
  - 重量範囲、購入日、価格

- **Reel（リール）**

  - リール名、ブランド、タイプ
  - ギアタイプ、価格、購入日
  - ラインとの関連付け

- **Line（ライン）**

  - ライン名、ブランド、PE 番号
  - 長さ、ストランド数、マーカー有無
  - 価格、購入日

- **Leader（リーダー）**

  - リーダー名、ブランド、番手
  - 長さ、素材、価格、購入日

- **Tackle（タックル）**

  - タックル名
  - ロッド、リール、リーダーの組み合わせ
  - 結び方の記録

- **Log（釣行記録）**

  - 釣行日、エリア、ガイド船
  - メニュー、詳細な記録
  - 使用したタックルの記録

- **TackleSelection（タックル選択）**

  - 釣行記録とタックルの関連付け

- **Session（セッション）**
  - ユーザーセッション管理

### コントローラー

- **HomesController**: トップページ、ヘルプページ
- **UsersController**: ユーザー登録、プロフィール管理
- **SessionsController**: ログイン・ログアウト
- **PasswordsController**: パスワードリセット
- **RodsController**: ロッド管理
- **ReelsController**: リール管理
- **LinesController**: ライン管理
- **LeadersController**: リーダー管理
- **TacklesController**: タックル管理
- **LogsController**: 釣行記録管理
- **AdminsController**: 管理者機能

### 主要機能

- **ユーザー認証システム**

  - メール認証によるアカウント有効化
  - セキュアなパスワード管理
  - セッション管理

- **釣り具管理**

  - 階層的な釣り具の管理（ロッド → リール → ライン、リーダー → タックル）
  - 詳細な仕様記録
  - 購入履歴の管理

- **釣行記録**

  - 詳細な釣行日誌の作成
  - 使用タックルの記録
  - カレンダー表示
  - 高度な検索機能（Ransack 使用）

- **管理者機能**
  - ユーザー管理
  - メール送信機能

## セットアップ

### 必要な環境

- Ruby 3.0 以上
- PostgreSQL
- Node.js（Tailwind CSS 用）

### インストール手順

1. リポジトリのクローン

```bash
git clone <repository-url>
cd familiar-fishing-management
```

2. 依存関係のインストール

```bash
bundle install
yarn install
```

3. データベースのセットアップ

```bash
rails db:create
rails db:migrate
rails db:seed
```

4. アプリケーションの起動

```bash
bin/dev
```

### 開発環境

- 開発サーバー: `http://localhost:3000`
- Letter Opener Web: `http://localhost:3000/letter_opener`（メール確認用）

## テスト

```bash
# RSpecテストの実行
bundle exec rspec

# セキュリティチェック
bundle exec brakeman

# コードスタイルチェック
bundle exec rubocop
```

## デプロイ

Kamal を使用した Docker コンテナでのデプロイに対応しています。

```bash
# デプロイ設定
bundle exec kamal config

# デプロイ実行
bundle exec kamal deploy
```

## ライセンス

このプロジェクトのライセンスについては、プロジェクトのライセンスファイルを参照してください。
