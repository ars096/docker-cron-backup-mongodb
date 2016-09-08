
DB_HOST="db"
BACKUP_DIR="/data/backup"

echo "$(date): mongodump --host $DB_HOST --out $BACKUP_DIR" >> /var/log/backup.log 2>&1
mongodump --host $DB_HOST --out $BACKUP_DIR
