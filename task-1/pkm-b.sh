#!/bin/bash

input_file="DataPKM.tsv"

if [ ! -f "$input_file" ]; then
    echo "File $input_file tidak ditemukan."
    exit 1
fi

most_popular_scheme=$(awk -F '\t' 'NR>1 {
    if (NF == 7) {
        count[$7]++;
    }
}
END {
    max = 0;
    popular = "";
    for (item in count) {
        if (count[item] > max) {
            max = count[item];
            popular = item;
        }
    }
    print popular;
}' "$input_file")

echo "Bidang skema paling banyak diminati oleh mahasiswa adalah: $most_popular_scheme"
