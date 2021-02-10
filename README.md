# LAMP
Laravel 用の LAMP(Apache+MySQL+PHP) 環境を Docker + docker-sync で構築します。docker-syncを導入することでファイルの同期が速くなり、サーバーアクセスの遅延を減らすことができます。

## ディレクトリ構成
```
├─ .env # コンテナのビルドに使用する環境変数を設定
├─ .env.example
├─ docker-compose.yml
├─ docker-sync.yml
├─ install.sh # 自動インストール用のシェルスクリプト
├─ README.md
│
├── conf
│    ├─ httpd.conf # Apache 設定ファイル
│    ├─ mysql.cnf # MySQL 設定ファイル
│    └─ php.ini # PHP 設定ファイル
│
├── docker
│    │
│    ├── web
│    │    └─ Dockerfile
│    │
│    └── db
│         └─ Dockerfile
│
└── laravel # Laravel プロジェクト作成先（.env で変更可）
```

## 動作環境
- `git` インストール済みで `git` コマンドが使用可能
- `docker` がインストール済みで `docker-compose` が使用可能
- `docker-sync` がインストール済み
`docker-sync` を使うとコンテナへのファイルの同期が速くなるため、ウェブサーバーへの通信も速くなります。

## シェルスクリプトを使用した環境再現
1. GitHub からリポジトリをクローン
```
$ git clone https://github.com/frozensox/LAMP.git
```
2. `.git` ディレクトリを削除（Git はダウンロードのみの使用です）
```
$ cd LAMP
$ rm -rf .git
```
3. シェルスクリプトの実行
```
$ sh install.sh
```
4. コンテナを再起動（`.htaccess` の mod_rewrite 有効化のため）
```
$ docker-compose restart
```
5. docker-syncの起動
```
$ docker-sync start
```

## 手動での環境再現
1. GitHub からリポジトリをクローン
```
$ git clone https://github.com/frozensox/LAMP.git
```
2. `.git` ディレクトリを削除（Git はダウンロードのみの使用です）
```
$ cd LAMP
$ rm -rf .git
```
3. `.env` ファイルの作成
```
cp .env.example .env &&
```
4. コンテナをビルド
```
$ docker-compose up -d --build
```
5. Laravel をインストール
```
$ docker-compose exec web composer create-project --prefer-dist laravel/laravel .
```
6. マイグレーションの実行を確認
```
$ docker-compose exec web php artisan migrate
```
ブラウザから `http://localhost/` にアクセスし Laravel の Welcome 画面が表示されることを確認してください。
7. コンテナを再起動（`.htaccess` の mod_rewrite 有効化のため）
```
$ docker-compose restart
```
8. docker-syncの起動
```
$ docker-sync start
```


## MySQL への接続
コマンドラインからルート権限で接続するには以下のコマンドを実行してください。
```
$ docker-compose exec db bash -c 'mysql -p${MYSQL_ROOT_PASSWORD} -D ${MYSQL_DATABASE}'
```
MySQL クライアントツールでデータベースに接続する場合、 `.env` ファイルに `DB_PORT=33060` と記述し、コンテナを再作成してください。
```
$ docker-compose down
$ docker-compose up -d
```

## 設定ファイルの変更
`conf` ディレクトリ内の設定ファイルは、 docker コンテナの各設定ファイルにマウントされています。設定の変更を反映するにはトップディレクトリ内で`docker-compose restart` としてコンテナを再起動してください。
- conf/httpd.conf  => /etc/apache2/sites-available/000-default.conf
- conf/mysql.cnf   => /etc/mysql/conf.d/my.cnf
- conf/php.ini     => /usr/local/etc/php/conf.d/php.ini

## 参考記事
- [【超入門】20分でLaravel開発環境を爆速構築するDockerハンズオン](https://qiita.com/ucan-lab/items/56c9dc3cf2e6762672f4)
- [Dockerを使ってLaravelのローカル開発環境を作る(Apache版)](https://qiita.com/ucan-lab/items/38cd04cee1f3f9e024b9)
