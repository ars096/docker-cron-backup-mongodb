# docker-cron-backup-mongodb

cron を使って、定期的に mongodb のデータをバックアップするための docker イメージです。
mongo-backup.sh の DB_HOST に mongodb のホスト名を、BACKUP_DIR にバックアップ先ディレクトリのパスを指定します。

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

