#!/bin/bash

waktu=$(date +"%Y%m%d%H")
log_folder="/home/$USER/metrics"

aggregation_hourly="${log_folder}/metrics_agg_${waktu}.log"
minute_logfile=$(find "$log_folder" -name "metrics_${waktu}*.log")

#Array
declare -a sumMemTotal=()
declare -a sumMemUsed=()
declare -a sumMemFree=()
declare -a sumMemShared=()
declare -a sumMemBuff=()
declare -a sumMemAvailable=()
declare -a sumSwapTotal=()
declare -a sumSwapUsed=()
declare -a sumSwapFree=()
declare -a sumPathSize=()

# Function Max, Min, AVG
findMax() {
  max=$(printf '%d\n' "${@}" | sort -rn | head -n 1)
  echo "$max"
}

findMin() {
  min=$(printf '%d\n' "${@}" | sort -n | head -n 1)
  echo "$min"
}

findAVG() {
  jumlahData=0
  banyakData=0
  
  for value in "$@"; do
    jumlahData=$(echo "$jumlahData + $value" | bc)
    ((banyakData++))
  done
  
  average=$(echo "scale=1; $jumlahData / $banyakData" | bc)
  if [[ "${average#*.}" == "0" ]]; then
      echo "${average%.*}" 
  else
      echo "$average" # remove .0
  fi
}

#Read metrics
for log in $minute_logfile; do   

    IFS=, read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size < <(tail -n 1 "$log")
path_size="${path_size//M/}"
path_size="${path_size//K/}"
path_size="${path_size//B/}"

sumMemTotal+=("$mem_total")
sumMemUsed+=("$mem_used")
sumMemFree+=("$mem_free")
sumMemShared+=("$mem_shared")
sumMemBuff+=("$mem_buff")
sumMemAvailable+=("$mem_available")
sumSwapTotal+=("$swap_total")
sumSwapUsed+=("$swap_used")
sumSwapFree+=("$swap_free")
sumPathSize+=("$path_size")

done

#MIN VALUE
min_mem_total=$(findMin "${sumMemTotal[@]}")
min_mem_used=$(findMin "${sumMemUsed[@]}")
min_mem_free=$(findMin "${sumMemFree[@]}")
min_mem_shared=$(findMin "${sumMemShared[@]}")
min_mem_buff=$(findMin "${sumMemBuff[@]}")
min_mem_available=$(findMin "${sumMemAvailable[@]}")
min_swap_total=$(findMin "${sumSwapTotal[@]}")
min_swap_used=$(findMin "${sumSwapUsed[@]}")
min_swap_free=$(findMin "${sumSwapFree[@]}")
min_path_size=$(findMin "${sumPathSize[@]}")

#MAX VALUE
max_mem_total=$(findMax "${sumMemTotal[@]}")
max_mem_used=$(findMax "${sumMemUsed[@]}")
max_mem_free=$(findMax "${sumMemFree[@]}")
max_mem_shared=$(findMax "${sumMemShared[@]}")
max_mem_buff=$(findMax "${sumMemBuff[@]}")
max_mem_available=$(findMax "${sumMemAvailable[@]}")
max_swap_total=$(findMax "${sumSwapTotal[@]}")
max_swap_used=$(findMax "${sumSwapUsed[@]}")
max_swap_free=$(findMax "${sumSwapFree[@]}")
max_path_size=$(findMax "${sumPathSize[@]}")

#AVG VALUE
avg_mem_total=$(findAVG "${sumMemTotal[@]}")
avg_mem_used=$(findAVG "${sumMemUsed[@]}")
avg_mem_free=$(findAVG "${sumMemFree[@]}")
avg_mem_shared=$(findAVG "${sumMemShared[@]}")
avg_mem_buff=$(findAVG "${sumMemBuff[@]}")
avg_mem_available=$(findAVG "${sumMemAvailable[@]}")
avg_swap_total=$(findAVG "${sumSwapTotal[@]}")
avg_swap_used=$(findAVG "${sumSwapUsed[@]}")
avg_swap_free=$(findAVG "${sumSwapFree[@]}")
avg_path_size=$(findAVG "${sumPathSize[@]}")

#Result
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$aggregation_hourly"
echo "minimum,$min_mem_total,$min_mem_used,$min_mem_free,$min_mem_shared,$min_mem_buff,$min_mem_available,$min_swap_total,$min_swap_used,$min_swap_free,/home/$USER,${min_path_size}M" >> "$aggregation_hourly"
echo "maximum,$max_mem_total,$max_mem_used,$max_mem_free,$max_mem_shared,$max_mem_buff,$max_mem_available,$max_swap_total,$max_swap_used,$max_swap_free,/home/$USER,${max_path_size}M" >> "$aggregation_hourly"
echo "average,$avg_mem_total,$avg_mem_used,$avg_mem_free,$avg_mem_shared,$avg_mem_buff,$avg_mem_available,$avg_swap_total,$avg_swap_used,$avg_swap_free,/home/$USER,${avg_path_size}M" >> "$aggregation_hourly"

#User Permission
chmod 400 "$aggregation_hourly"
