#!/bin/bash
    
    
awk -F '\t' 'NR>1 {
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
    print "Bidang paling banyak diminati oleh mahasiswa: " popular;
}' DataPKM.tsv
