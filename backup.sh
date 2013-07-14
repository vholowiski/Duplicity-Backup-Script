#!/bin/bash
/root/scripts/backup_all_dbs.sh

export AWS_ACCESS_KEY_ID=your_aws_access_key
export AWS_SECRET_ACCESS_KEY=your_aws_ssecret_key
AWS_BUCKET=your_aws_bucket

export PASSPHRASE=password_to_encrypt_database
EMAIL=your@address.com

STAGING_LOCATION=/root/staging
WWW_LOCATION=/var/www

nice -10 /usr/bin/duplicity remove-older-than 1Y s3+http://$AWS_BUCKET
nice -10 /usr/bin/duplicity --include="$WWW_LOCATION" --include="$STAGING_LOCATION" --exclude="**" / s3+http://$AWS_BUCKET --full-if-older-than 1M | mail -s "Nightly Backup Results" $EMAIL