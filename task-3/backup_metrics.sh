#!/bin/bash

logFolder="/home/$USER/metrics"
backupFile="/home/$USER"
day=$(date +"%Y%m%d")
hour=$(date +"%H")

cd "$logFolder" || exit

tar -cf "$backupFile/backup_metrics_${day}${hour}.tar" metrics_agg_"${day}"*.log
gzip -f "$backupFile/backup_metrics_${day}${hour}.tar"

mv "$backupFile/backup_metrics_${day}${hour}.tar.gz" "$backupFile/backup_metrics_${day}${hour}.gz"
