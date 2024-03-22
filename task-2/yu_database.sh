#!/bin/bash

while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema
do
    username="$Nama_Pengusul"

    password=$(echo "$Pendamping" | grep -o '[0-9]*')
    password="$Fakultas$password"

    echo "$username:$password" >> users.txt
done < /home/liares/Documents/sisop/pratikum1/praktikum-modul-1-d21/resources/data-pkm.csv
