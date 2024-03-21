#!/bin/bash

awk -F'\t' 'NR > 1 && NF {

# Hilangkan underscore
 gsub("_", " ", $2)

 # Hitung kata
 jumlah_kata_judul = split($5, words, " ")

 if (jumlah_kata_judul > 20) {
 printf "Nama : %s | Departemen : %s\n", $2, $3
    }

}' DataPKM.tsv

