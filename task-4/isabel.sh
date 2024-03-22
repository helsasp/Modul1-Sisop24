#!/bin/bash
idx=index
#4a
current_hour=$(date +"%H")

get_num_photos() {
    if [ "$1" == "00" ]; then
        echo 10
    elif [ $((current_hour % 2)) -eq 0 ]; then
        echo 5
    else
        echo 3
    fi
}

num_photos=$(get_num_photos "$current_hour")

folder_name="folder_$(date +"%s")"

download_photos() {
    local folder=$1
    local num=$2

    for ((i=1; i<=num; i++)); do
        filename="foto_${i}.jpg"
        wget -O "${folder}/${filename}" "https://hobihepi.com/wp-content/uploads/2024/01/Profil-Mingyu-SEVENTEEN-Terbaru.png"
    done
}

mkdir "$folder_name"

download_photos "$folder_name" "$num_photos"

echo "Photos downloaded successfully :)"

#4b
curr_jam=$(date "+%H")
if [ "$current_hour" == "00" ]; then
    zip -r ayang_$idx.zip folder_$idx
fi

#4c
if [ "$current_hour" = "02" ]; then
 rm -rf folder_* ayang_*.zip
fi

#4D
download_fotonya_levi() {
local tgl=$(date +"%Y%m%d")
wget -O "levi_${tgl}.jpg" "https://kincir.com/movie/anime/attack-on-titan-alasan-eren-jadi-villain-v3owrltqlaip/"
}

download_fotonya_eren() {
local tgl=$(date +"%Y%m%d")
wget -O "eren_${tgl}.jpg" "https://kincir.com/movie/anime/attack-on-titan-alasan-eren-jadi-villain-v3owrltqlaip/"
}

 tanggal_skg=$(date +"%j" | sed 's/^0*//')
 if [ $tanggal_skg -ge 1 ] && [ $tanggal_skg -le 365 ]; then
  if [ $((10#$tanggal_skg % 2)) -eq 0 ]; then
     download_fotonya_levi
  else
     download_fotonya_eren
   fi
 else
     echo "Tanggalnya salah!" >&2
       exit 1
 fi
