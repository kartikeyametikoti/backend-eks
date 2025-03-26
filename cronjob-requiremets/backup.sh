#!/bin/sh
echo "Starting MySQL Backup..."

# Ensure MySQL is running
sleep 10

# Check AWS credentials
aws sts get-caller-identity
if [ $? -ne 0 ]; then
    echo "AWS credentials are invalid!"
    exit 1
fi

# Dump MySQL database
mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" kartikdatabase > /tmp/mysql-backup.sql

# Move backup to a persistent volume location
cp /tmp/mysql-backup.sql /backup/mysql-backup.sql

# Upload to S3
aws s3 cp /tmp/mysql-backup.sql s3://kartikvuck2/mysql-backup-$(date +\%F-%H-%M).sql

echo "Backup completed and uploaded to S3!"


  
# echo "Starting MySQL Backup..."

# # Create a backup directory if not exists
# mkdir -p /backup

# # Dump MySQL database 
# # we are dumping data to /tmp/ instead directly to /backup why because /backup file permissions changing is not preferrable and complex to do that'why we are copying from dumped mysql-backup.sql file from /tmp to /backup 
# mysqldump -u root -p$MYSQL_ROOT_PASSWORD kartikdatabase > /tmp/mysql-backup.sql

# # Move backup to a persistent volume location
# cp /tmp/mysql-backup.sql /backup/mysql-backup.sql

# # Upload to S3 for this we need aws login actually those credentials we can get from cronjob environment variables from secrets.yml file
# aws s3 cp /tmp/mysql-backup.sql s3://kartikvuck2/mysql-backup-$(date +\%F-%H-%M).sql



# echo "Backup completed and uploaded to S3!"
# #!/bin/sh
# echo "Starting MySQL Backup..."

# # Ensure backup directory is writable
# mkdir -p /backup
# chmod -R 777 /backup

# # Ensure MySQL is running
# sleep 10

# # Check AWS credentials
# aws sts get-caller-identity
# if [ $? -ne 0 ]; then
#     echo "AWS credentials are invalid!"
#     exit 1
# fi

# # Dump MySQL database 
# mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" kartikdatabase > /tmp/mysql-backup.sql

# # Move backup to a persistent volume location
# cp /tmp/mysql-backup.sql /backup/mysql-backup.sql

# # Upload to S3
# aws s3 cp /tmp/mysql-backup.sql s3://kartikvuck2/mysql-backup-$(date +\%F-%H-%M).sql

# echo "Backup completed and uploaded to S3!"

