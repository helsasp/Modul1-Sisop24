#!/bin/bash

waktu=$(date +"%Y%m%d%H%M%S")
log_folder="/home/$USER/metrics"
mkdir -p "$log_folder"

metrics_file="$log_folder/metrics_${waktu}.log"

#RAM
ramInfo=$(free -m | grep Mem | awk '{print $2","$3","$4","$5","$6","$7}')

#SWAP
swapInfo=$(free -m | grep Swap | awk '{print $2","$3","$4}')

targetDir="/home/$USER/"
dirSize=$(du -sh "$targetDir" | cut -f1)

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$metrics_file"
echo "$ramInfo,$swapInfo,$targetDir,$dirSize" >> "$metrics_file"

#User Read Only 
chmod 400 "$metrics_file"
