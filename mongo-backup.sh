
DB_HOST="db"
BACKUP_DIR="/data/backup"

# --

TS_DATE=$(date --utc '+%Y-%m-%d')
TS_YEAR=$(date --utc '+%Y')
TS_MONTH=$(date --utc '+%m')
TS_DAY=$(date --utc '+%d')
TS_HOUR=$(date --utc '+%H')

mongodump --host $DB_HOST --out $BACKUP_DIR/$TS_DATE/$TS_HOUR


# reorder old backup data

## remove hourly backup when the end of the day
if [ $TS_HOUR -eq "23" ]; then
    for i in {0..22}; do
        REMOVE_PATH=$BACKUP_DIR/$TS_DATE/$(printf "%02d" i)
        if [ -e $REMOVE_PATH ]; then
            rm -rf --preserve-root $REMOVE_PATH
        fi
    done
fi

## remove last month daily backup when the start of month
if [ $TS_DAY -eq "01" ]; then
    REMOVE_YEAR=$TS_YEAR
    REMOVE_MONTH=$(($TS_MONTH - 1))
    if [ $REMOVE_MONTH -eq 0 ]; then
        REMOVE_MONTH=12
        REMOVE_YEAR=$(($TS_YEAR - 1))
    fi
    
    for i in {1..31}; do
        REMOVE_PATH=$BACKUP_DIR/$REMOVE_YEAR-$REMOVE_MONTH-$(printf "%02d" i)
        if [ -e $REMOVE_PATH ]; then
            rm -rf --preserve-root $REMOVE_PATH
        fi
    done
fi


