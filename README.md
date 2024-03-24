[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/nyzv0V02)
<div align=center>

|    NRP     |      Name      |
| :--------: | :------------: |
| 5025221270 | Yosua Hares    |
| 5025221154 | Helsa Sriprameswari Putri |
| 5025221000 | M Fadhil Abhista Daniswara |

# Praktikum Modul 1 _(Module 1 Lab Work)_

</div>

### Daftar Soal _(Task List)_

- [Task 1 - Tim Kawal Bubu _(Bubu's Monitoring Team)_](/task-1/)

- [Task 2 - Gabut Yuan _(Yuan's Boredom)_](/task-2/)

- [Task 3 - Magang Bubu _(Bubu's Internship)_](/task-3/)

- [Task 4 - LDR Isabel _(Isabel Sad Relationship)_](/task-4/)

### Laporan Resmi Praktikum Modul 1 _(Module 1 Lab Work Report)_

### 1. Task 1 - Tim Kawal Bubu (Bubu's Monitoring Team)
   A. Karena Belmawa menetapkan judul maksimum proposal 20 kata, maka komandan ingin mencari data siapa saja tim yang tidak memenuhi ketentuan ini. Tampilkan nama pengusul, beserta departemennya yang judulnya lebih dari 20 kata. Pisahkan spasi dan hapus underscore "_" pada nama pengusul.
   #### Penyelesaian :
   
   Membuat dan menjalankan file pkm-a.sh dengan cara :<br>
   ```
   nano pkm-a.sh
```
```
chmod +x pkm-a.sh
```
```
./pkm-a.sh
```
   
   Input :<br>
   ```
   #!/bin/bash

awk -F'\t' 'NR > 1 && NF {

 gsub("_", " ", $2)

 jumlah_kata_judul = split($5, words, " ")

 if (jumlah_kata_judul > 20) {
 printf "Nama : %s | Departemen : %s\n", $2, $3
    }

}' DataPKM.tsv
```
   Penjelasan :<br>
   1.
```
awk -F'\t' 'NR > 1 && NF
```
berfungsi untuk mengatur delimiter (pemisah) menjadi karakter tab (\t) menjalankan kode yang ada di dalam tanda kurung kurawal {} hanya untuk baris-baris yang nomor barisnya (NR) lebih besar dari 1 (artinya baris kedua ke atas) dan memiliki jumlah field (NF, yang merupakan jumlah kolom) lebih dari 0 (tidak kosong).

   
   
