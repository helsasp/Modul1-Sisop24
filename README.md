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
1. ```awk -F'\t' 'NR > 1 && NF``` : untuk mengatur delimiter (pemisah) menjadi karakter tab (\t) menjalankan kode yang ada di dalam tanda kurung kurawal {} hanya untuk baris-baris yang nomor barisnya (NR) lebih besar dari 1 (artinya baris kedua ke atas) dan memiliki jumlah field (NF, yang merupakan jumlah kolom) lebih dari 0 (tidak kosong).
2. ```gsub("_", " ", $2)``` : mengganti semua underscore (_) dalam kolom kedua (nama pengusul atau $2) dengan spasi.
3. ```jumlah_kata_judul = split($5, words, " ")``` : menghitung jumlah kata dalam kolom kelima ($5) yang dipisahkan oleh spasi
4. ```if (jumlah_kata_judul > 20) { printf "Nama : %s | Departemen : %s\n", $2, $3}``` : mencetak nama (kolom kedua) dan departemen (kolom ketiga) jika jumlah kata dalam judul lebih dari 20.
5. ```DataPKM.tsv``` :  nama file tsv yang diproses oleh skrip

#### Hasil :
#### Kendala :

### 2. Task 2 - Gabut Yuan (Yuan's Boredom)
A.  a. Yuan ingin membuat file bash login bernama yu_login.sh untuk memastikan bahwa peserta yang telah ada di dalam file .csv tersebut, dapat langsung melakukan login, tanpa perlu register. Apabila loginnya sukses, maka akan masuk ke log.txt erikut format untuk login:
    Memasukkan username. Username didapatkan dari kata pertama pada kolom nama_pengusul<br>
    Memasukkan password. Password didapatkan dari fakultas+nipd_dosen_pendamping<br>
    Misal: FTEIC0030016403<br>
    Setiap percobaan login akan tercatat pada log.txt dengan format YY/MM/DD hh:mm:ss MESSAGE<br>
    Dengan MESSAGE berupa:<br>
    LOGIN: SUCCESS USER_NAME is logged in<br>
    Atau<br>
    Or<br>
    LOGIN: ERROR Failed login attempt on USER_NAME<br>

#### Penyelesaian :
Membuat dan menjalankan file yu_login.sh dengan cara :<br>
```
nano yu_login.sh
```
```
chmod +x yu_login.sh
```
```
./yu_login.sh
```

Input :
```
#!/bin/bash

waktuLogin=$(date +%y/%m/%d\ %H:%M:%S)
bisalogin=0

read -p "Masukkan Username -> " uname
read -p "Masukkan Password -> " pw

while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema; do

 nama_pertama=$(echo "$Nama_Pengusul" | cut -d'_' -f1) #Pisahkan dari underscore
  if [[ "$nama_pertama" == "$uname" ]]; then
  nipDosen=$(echo "$Pendamping" | grep -Eo '[0-9]{10}')

    if [[ "$pw" == "$Fakultas$nipDosen" ]]; then
    bisalogin=1 #Sukses
      break
    fi
  fi
done < data-pkm.csv

if [[ $bisalogin == 1 ]]; then
 echo "Login berhasil!"
 echo "$waktuLogin LOGIN: SUCCESS $uname is logged in" >> log.txt
else

 echo "Login salah."
 echo "$waktuLogin LOGIN: ERROR Failed login attempt on $uname" >> log.txt
fi
```

Penjelasan : 
1.```waktuLogin=$(date +%y/%m/%d\ %H:%M:%S)<br>
bisalogin=0``` : menginisialisasi waktu login dan variable bisalogin diset 0.
2. ```read -p "Masukkan Username -> " uname<br>
read -p "Masukkan Password -> " pw``` : memasukkan username dan password user dan menyimpan inputannya.
3. ```while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema; do ... done < data-pkm.csv``` : loop while yang membaca file data-pkm.csv baris per baris. Setiap baris dibagi berdasarkan koma (','), dan nilainya disimpan dalam variabel yang sesuai (seperti No, Nama_Pengusul, Departemen, dll.).
4.```nama_pertama=$(echo "$Nama_Pengusul" | cut -d'_' -f1)``` : memisahkan bagian pertama dari Nama_Pengusul yang terpisah oleh underscore ('_') dan disimpan dalam variabel nama_pertama.
5.```nipDosen=$(echo "$Pendamping" | grep -Eo '[0-9]{10}')``` : mencari nip dosen berupa angka yang ada di kolom pendamping.
6.```if [[ "$pw" == "$Fakultas$nipDosen" ]]; then ... fi``` : memeriksa apakah password yang dimasukkan pengguna cocok dengan gabungan dari nilai Fakultas dan nipDosen.
7.```if [[ $bisalogin == 1 ]]; then ... fi```:  memeriksa apakah proses login berhasil. Jika bisalogin sama dengan 1, itu berarti login berhasil.
8.```echo "Login berhasil!" dan echo "Login salah."``` : mencetak pesan ke layar sesuai dengan hasil login.
9.```echo "$waktuLogin LOGIN: SUCCESS $uname is logged in" >> log.txt dan echo "$waktuLogin LOGIN: ERROR Failed login attempt on $uname" >> log.txt```: mencatat hasil login ke dalam file log.txt beserta waktu dan status loginnya.


#### Hasil :
#### Kendala : 
Pada nomor 2A terdapat beberapa kata yang masih tidak bisa login padahal username dan password sudah benar.




   
   
