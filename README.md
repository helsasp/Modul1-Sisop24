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
A. Yuan ingin membuat file bash login bernama yu_login.sh untuk memastikan bahwa peserta yang telah ada di dalam file .csv tersebut, dapat langsung melakukan login, tanpa perlu register. Apabila loginnya sukses, maka akan masuk ke log.txt erikut format untuk login:
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

Penjelasan : <br>
1.```waktuLogin=$(date +%y/%m/%d\ %H:%M:%S)
bisalogin=0``` : menginisialisasi waktu login dan variable bisalogin diset 0.<br>
2. ```read -p "Masukkan Username -> " uname<br>
read -p "Masukkan Password -> " pw``` : memasukkan username dan password user dan menyimpan inputannya.<br>
3. ```while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema; do ... done < data-pkm.csv``` : loop while yang membaca file data-pkm.csv baris per baris. Setiap baris dibagi berdasarkan koma (','), dan nilainya disimpan dalam variabel yang sesuai (seperti No, Nama_Pengusul, Departemen, dll.).<br>
4.```nama_pertama=$(echo "$Nama_Pengusul" | cut -d'_' -f1)``` : memisahkan bagian pertama dari Nama_Pengusul yang terpisah oleh underscore ('_') dan disimpan dalam variabel nama_pertama.<br>
5.```nipDosen=$(echo "$Pendamping" | grep -Eo '[0-9]{10}')``` : mencari nip dosen berupa angka yang ada di kolom pendamping.<br>
6.```if [[ "$pw" == "$Fakultas$nipDosen" ]]; then ... fi``` : memeriksa apakah password yang dimasukkan pengguna cocok dengan gabungan dari nilai Fakultas dan nipDosen.<br>
7.```if [[ $bisalogin == 1 ]]; then ... fi```:  memeriksa apakah proses login berhasil. Jika bisalogin sama dengan 1, itu berarti login berhasil.<br>
8.```echo "Login berhasil!" dan echo "Login salah."``` : mencetak pesan ke layar sesuai dengan hasil login.<br>
9.```echo "$waktuLogin LOGIN: SUCCESS $uname is logged in" >> log.txt dan echo "$waktuLogin LOGIN: ERROR Failed login attempt on $uname" >> log.txt```: mencatat hasil login ke dalam file log.txt beserta waktu dan status loginnya.<br>

#### Hasil :
#### Kendala : 
Pada nomor 2A terdapat beberapa kata yang masih tidak bisa login padahal username dan password sudah benar.<br>

### 3. Task 3 - Magang Bubu (Bubu's Internship)
A. Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-30 15:00:00, maka file log yang akan tergenerate adalah metrics_20240330150000.log.<br>
 #### Penyelesaian :

```
 #!/bin/bash

waktu=$(date +"%Y%m%d%H%M%S")
log_folder="/home/$USER/metrics"
mkdir -p "$log_folder"

metrics_file="$log_folder/metrics_${waktu}.log"

#RAM
ramInfo=$(free -m | grep Mem | awk '{print $2","$3","$4","$5","$6","$7}')

#SWAP
swapInfo=$(free -m | grep Swap | awk '{print $2","$3","$4}')

targetDir="/home/$USER/"
dirSize=$(du -sh "$targetDir" | cut -f1)

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$metrics_file"
echo "$ramInfo,$swapInfo,$targetDir,$dirSize" >> "$metrics_file"

#User Read Only 
chmod 400 "$metrics_file"
```
Penjelasan : <br>
1. ```waktu=$(date +"%Y%m%d%H%M%S")``` : Membuat variabel waktu yang berisi waktu saat ini dalam format yang ditentukan (tahun, bulan, tanggal, jam, menit, detik).<br>
2. ```log_folder="/home/$USER/metrics``` : Mendefinisikan variabel log_folder yang berisi path direktori tempat file log akan disimpan (di folder metrics).<br>
3. ```mkdir -p "$log_folder``` : Membuat direktori yang ditentukan oleh variabel log_folder jika belum ada.<br>
4. ```metrics_file="$log_folder/metrics_${waktu}.log ``` : Mendefinisikan variabel metrics_file yang berisi path lengkap ke file log yang akan dibuat. Nama file log akan mencakup waktu yang didapatkan sebelumnya.<br>
5. ```ramInfo=$(free -m | grep Mem | awk '{print $2","$3","$4","$5","$6","$7} ```: Menjalankan perintah free -m yang memberikan informasi tentang penggunaan RAM dalam megabyte. Outputnya difilter menggunakan grep untuk baris yang mengandung "Mem", dan kemudian diproses menggunakan awk untuk mencetak kolom kedua hingga ketujuh(mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available).<br>
6. ```swapInfo=$(free -m | grep Swap | awk '{print $2","$3","$4}')``` : Mengambil informasi tentang penggunaan SWAP. Ini juga menggunakan perintah free -m, tetapi dengan grep untuk baris yang mengandung "Swap" untuk mencetak output swap_total,swap_used,swap_fre.<br>
7. ```targetDir="/home/$USER/ ```: Mendefinisikan variabel targetDir yang berisi direktori yang ingin diperiksa ukurannya.<br>
8. ```dirSize=$(du -sh "$targetDir" | cut -f1) ```: Menggunakan perintah du untuk menghitung ukuran direktori yang ditentukan oleh targetDir. Hasilnya kemudian diproses menggunakan cut untuk hanya mendapatkan bagian pertama, yaitu ukuran direktori tanpa menampilkan path.<br>
9. ```echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$metrics_file ```: Menuliskan header untuk file log yang berisi nama kolom yang akan diisi oleh data nanti<br>
10. ```echo "$ramInfo,$swapInfo,$targetDir,$dirSize" >> "$metrics_file ```: Menambahkan data ke file log.<br>
11. ```chmod 400 "$metrics_file"```: Mengatur izin file log yang dibuat sehingga hanya pengguna yang memiliki izin baca saja.<br>

B. Script untuk mencatat metrics diatas diharapkan dapat berjalan otomatis setiap menit.<br>
#### Penyelesaian :
Untuk menjalankan otomatis setiap menit, digunakan Crontabs. <br>

```* * * * * /home/helsasp/minute_log.sh```
Penjelasan : <br>
Jadwal eksekusi tugas diatur untuk menjalankan skrip setiap menit tanpa pembatasan pada jam, hari dalam bulan, bulan, atau hari dalam minggu.<br>
Path lengkap ke skrip atau program yang akan dijalankan adalah /home/helsasp/minute_log.sh.<br>

Dengan demikian, skrip minute_log.sh akan dijalankan setiap menit tanpa ada batasan pada waktu, tanggal, atau hari dalam seminggu di dalam direktori /home/helsasp/<br>

C.Kemudian, buat satu script untuk membuat aggregasi file log ke satuan jam. Script aggregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file aggregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File aggregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil aggregasi metrics_agg_2023033015.log dengan format metrics_agg_{YmdH}.log. <br>
#### Penyelesaian :


#### Hasil :
#### Kendala : 


### 4. Task 4 - LDR Isabel (Isabel Sad Relationship)
D. Untuk mengisi laptopnya kembali, Isabel ingin mendownload gambar Levi dan Eren secara bergantian setiap harinya dengan ketentuan nama file:<br>
    Jika Levi, maka nama file nya menjadi levi_YYYYMMDD (Dengan YYYYMMDD adalah tahun, bulan, dan tanggal gambar tersebut di download)<br>
    Jika Eren, maka nama file nya menjadi eren_YYYYMMDD (Dengan YYYYMMDD adalah tahun, bulan, dan tanggal gambar tersebut di download)<br>
    
 #### Penyelesaian :

```
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
```
Penjelasan : <br>
1.```download_fotonya_levi() {local tgl=$(date +"%Y%m%d") wget -O "levi_${tgl}.jpg" "https://kincir.com/movie/anime/attack-on-titan-alasan-eren-jadi-villain-v3owrltqlaip/"}``` : Fungsi untuk mendownload gambar levi dengan "wget" dan menamai file menjadi levi_YYYYMMDD <br>
2.```download_fotonya_eren() {local tgl=$(date +"%Y%m%d") wget -O "eren_${tgl}.jpg" "https://kincir.com/movie/anime/attack-on-titan-alasan-eren-jadi-villain-v3owrltqlaip/"}``` : Fungsi untuk mendownload gambar eren dengan "wget" dan menamai file menjadi eren_YYYYMMDD <br>
3. ```tanggal_skg=$(date +"%j" | sed 's/^0*//')``` : mengambil hari dalam tahun. Ini mengembalikan nilai yang berkisar dari 001 hingga 366, yang mewakili hari saat ini dalam tahun. <br>
4.```if [ $tanggal_skg -ge 1 ] && [ $tanggal_skg -le 365 ]; then if [ $((10#$tanggal_skg % 2)) -eq 0 ]; then download_fotonya_levi else download_fotonya_eren fi``` : Fungsi ini mengecek apakah tanggal valid (1-365). Jika valid, maka akan menghitung tanggalnya genap / ganjil. Jika tanggal adalah genap, maka akan masuk ke fungsi download_fotonya_levi untuk mendownload foto levi. Jika tanggal adalah ganjil, maka akan masuk ke fungsi download_fotonya_eren untuk mendownload foto eren. <br>
5. ```else echo "Tanggalnya salah!" >&2 exit 1 fi``` : Jika tanggal tidak valid, maka akan mengoutputkan "Tanggalnya salah". <br>
   




   
   
