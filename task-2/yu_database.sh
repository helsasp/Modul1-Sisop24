#!/bin/bash

while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema
do
    usrnme="$Nama_Pengusul"

    temp=$(echo "$Pendamping" | grep -o '[0-9]*')
    pass="$Fakultas$temp"

    echo "$usrnme:$pass" >> users.txt
done < /home/liares/Documents/sisop/pratikum1/praktikum-modul-1-d21/resources/data-pkm.csv
