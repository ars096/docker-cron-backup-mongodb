
DB_HOST="db"
BACKUP_DIR="/data/backup"

# --

TS_DATE=$(date --utc '+%Y-%m-%d')
TS_YEAR=$(date --utc '+%Y')
TS_MONTH=$(date --utc '+%m')
TS_DAY=$(date --utc '+%d')
TS_HOUR=$(date --utc '+%H')

echo "$(date): mongodump --host $DB_HOST --out $BACKUP_DIR/$TS_DATE/$TS_HOUR" >> /var/log/cron.log 2>&1
mongodump --host $DB_HOST --out $BACKUP_DIR/$TS_DATE/$TS_HOUR


# reorder old backup data

## remove hourly backup at the begining of new day
if [ $TS_HOUR -eq "00" ]; then
    for i in {1..23}; do
        RM_DATE=$(date --utc '+%Y-%m-%d' --date '2 days ago')
        RM_PATH=$BACKUP_DIR/$RM_DATE/$(printf "%02d" i)
        if [ -e $RM_PATH ]; then
            rm -rf --preserve-root $RM_PATH
        fi
    done
fi

## remove last month daily backup at the begining of new month
if [ $TS_DAY -eq "01" ]; then
    RM_YEAR=$(date --utc '+%Y' --date '2 months ago')
    RM_MONTH=$(date --utc '+%m' --date '2 months ago')
    
    for i in {2..31}; do
        RM_PATH=$BACKUP_DIR/$RM_YEAR-$RM_MONTH-$(printf "%02d" i)
        if [ -e $RM_PATH ]; then
            rm -rf --preserve-root $RM_PATH
        fi
    done
fi


