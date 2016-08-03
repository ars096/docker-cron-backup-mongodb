# docker-cron-backup-mongodb

cron を使って、定期的に mongodb のデータをバックアップするための docker イメージです。

## 設定
mongo-backup.sh の変数を編集します。
- DB_HOST : mongodb のホスト名
- BACKUP_DIR : バックアップ先ディレクトリのパス

## 使用例
例えば、docker-compose を使う場合は、次のような docker-compose.yml を準備します。

```docker-compose.yml
version: '2'

services:
  mongo:
    image: mongo
    volumes:
     - /home/core/db:/data/db
  
  mongo-backup:
    image: mongo-backup
    links:
     - mongo:db
    volumes:
     - /home/core/backup:/data/backup
```

