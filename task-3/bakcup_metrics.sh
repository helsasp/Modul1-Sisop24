#!/bin/bash

logFolder="/home/$USER/metrics"
backupFile="/home/$USER"

time=$(date +"%Y%m%d%H")
gzip -c "$logFolder/metrics_agg_${time}.log" > "$backupFile/backup_metrics_${time}.gz"
