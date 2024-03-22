#!/bin/bash

awk -F '\t' '
NR>1 && NF==7 {
    gsub("_", " ", $2);
    proposal_count[$2]++;
    if (proposal_count[$2] == 2) {
        pengusul[$2] = $2;
        pembimbing[$2] = $6;
    } else if (proposal_count[$2] > 2) {
        delete pengusul[$2];
    }
}
END {
    for (pengusul_name in proposal_count) {
        if (proposal_count[pengusul_name] > 1) {
            print "Nama Pengusul:", pengusul_name, "Pembimbing:", pembimbing[pengusul_name];
        }
    }
}' DataPKM.tsv
