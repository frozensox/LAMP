# LAMP
Laravel用のLAMP(Apache+MySQL+PHP)環境をDockerで構築します。

## ディレクトリ構造
```
.
├─ README.md
│
├── conf
│    ├─ httpd.conf # Apache設定ファイル
│    └─ php.ini # PHP設定ファイル
│
├── docker
│    ├─ docker-compose.yml
│    ├─ .env # コンテナのビルドに使用する環境変数を設定
│    │
│    └── web
│         └─ Dockerfile
│
└── laravel # Laravelプロジェクトを作成
```

## Apacheのdeny設定
Apache の設定ファイル`httpd.conf`でコンテナへのアクセスを制限できます。しかし、`Require local`としてもなぜか効かず、ホスト側からのアクセスが`Forbidden`になってしまいます。`Require ip 192.168`として回避しています。
```
Require all denied
Require local
Require ip 192.168
```