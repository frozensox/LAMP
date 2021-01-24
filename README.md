# LAMP
Laravel 用の LAMP(Apache+MySQL+PHP) 環境を Docker で構築します。

## ディレクトリ構造
```
.
├─ README.md
│
├── conf
│    ├─ httpd.conf # Apache 設定ファイル
│    ├─ mysql.cnf # MySQL 設定ファイル
│    └─ php.ini # PHP 設定ファイル
│
├── docker
│    ├─ docker-compose.yml
│    ├─ .env # コンテナのビルドに使用する環境変数を設定
│    │
│    ├── web
│    │    └─ Dockerfile
│    │
│    └── db
│         └─ Dockerfile
│
└── laravel # Laravel プロジェクト作成先（.env で変更可）
```

## MySQLへの接続
コマンドラインからルート権限で接続するには以下のコマンドを実行してください。
```
$ docker-compose exec db bash -c 'mysql -p${MYSQL_ROOT_PASSWORD} -D ${MYSQL_DATABASE}'
mysql> SHOW TABLES;
```
MySQL クライアントツールでデータベースに接続する場合、 `docker/.env`ファイルに`DB_PORT=33060`と記述してください。


## 設定ファイル
`conf`ディレクトリ内の設定ファイルは、docker コンテナの各設定ファイルにマウントされています。設定の変更を反映するには`docker`ディレクトリへ移動後`docker-compose restart`としてコンテナを再起動してください。
- conf/httpd.conf  => /etc/apache2/sites-available/000-default.conf
- conf/mysql.cnf   => /etc/mysql/conf.d/my.cnf
- conf/php.ini     => /usr/local/etc/php/conf.d/php.ini

## Apacheのdeny設定
Apache の設定ファイル`httpd.conf`でウェブサーバコンテナへのアクセスを制限できます。しかし、`Require local`としてもなぜか効かず、ホスト側からのアクセスが`Forbidden`になってしまいます。`Require ip 192.168`としてローカルIPのアクセスを許可することで接続を許可しています。必要に応じて変更してください。
```
Require all denied
Require local
Require ip 192.168
```