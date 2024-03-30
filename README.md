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
A. <br>
![Screenshot 2024-03-28 163049](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/7b7f4296-68b9-4682-9195-f63f3d399f30) <br>
#### Kendala :

B. Komandan PKM juga tertarik ingin tahu antusiasme dan partisipasi mahasiswa sehingga meminta Bubu menampilkan bidang paling banyak diminati oleh mahasiswa. Tampilkan nama skema saja.
#### Penyelesaian :

 Membuat dan menjalankan file pkm-b.sh dengan cara :<br>
 ```
   nano pkm-b.sh
```
```
chmod +x pkm-b.sh
```
```
./pkm-b.sh
```
Input :<br>
 ```
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
```
Penjelasan :<br>
1.```input_file="DataPKM.tsv"```: Mendefinisikan variabel input_file yang berisi nama file TSV yang akan diolah.

2.``` if [ ! -f "$input_file" ]; then ... fi```: Kondisional bash yang memeriksa apakah file yang disebut dalam variabel input_file ada atau tidak. Jika tidak ditemukan, maka skrip akan mencetak pesan kesalahan dan keluar dengan status keluar 1 (exit 1).

3.``` most_popular_scheme=$(awk -F '\t' 'NR>1 ' "$input_file")```: Ini adalah perintah untuk menjalankan AWK pada file DataPKM.tsv. AWK akan menghitung skema paling populer yang diminati oleh mahasiswa.

4.``` 'NR>1 { ... }'```: Ini adalah pola AWK yang mengeksekusi kode di dalam kurung kurawal pada setiap baris, kecuali baris pertama.

5.``` if (NF == 7) { count[$7]++; }```: Ini adalah kondisi AWK yang memeriksa apakah jumlah field dalam baris tersebut sama dengan 7. Jika ya, maka nilai dalam field ke-7 dihitung sebagai skema yang diminati.

6.```END  max = 0; popular = "";```: Bagian ini dari AWK dieksekusi setelah selesai membaca seluruh baris dalam file. Di sini, dilakukan perhitungan skema yang paling banyak diminati.

7.```for (item in count)```: Loop untuk setiap skema yang terhitung.

8.```if (count[item] > max) ```: Kondisi untuk memeriksa apakah jumlah pemakaian skema saat ini lebih besar dari skema sebelumnya. Jika ya, skema saat ini dianggap sebagai skema paling populer.

9.```echo "Bidang skema paling banyak diminati oleh mahasiswa adalah: $most_popular_scheme"```: Ini adalah perintah untuk mencetak hasil skema paling populer yang telah dihitung oleh AWK.

#### Hasil : 
A. <br>
![Screenshot 2024-03-28 163049](https://github.com/sisop-its-s24/praktikum-modul-1-d21/blob/main/resources/Screen%20Shot%202024-03-29%20at%2023.56.29.png) <br>
#### Kendala :

C. Karena ada aturan baru dimana 1 mahasiswa hanya boleh submit 1 proposal, maka komandan juga meminta Bubu untuk memberikan list mahasiswa yang mengajukan 2 proposal. Tampilkan data pembimbingnya karena ingin di kontak komandan.
#### Penyelesaian :

 Membuat dan menjalankan file pkm-c.sh dengan cara :<br>
 ```
   nano pkm-c.sh
```
```
chmod +x pkm-c.sh
```
```
./pkm-c.sh
```
Input :<br>
 ```
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
```
Penjelasan :<br>
1.``` awk -F '\t' '```: Ini memulai perintah awk dan mengatur field separator (pemisah kolom) menjadi tab (\t).

2.```NR>1 && NF==7 {```: Awk akan menjalankan blok kode yang berada di dalam kurung kurawal ini untuk setiap baris yang memenuhi kondisi bahwa nomor baris (NR) lebih besar dari 1 (artinya tidak termasuk baris header) dan jumlah field (NF) sama dengan 7 (artinya ada 7 kolom pada baris tersebut).

3.```gsub("_", " ", $2);```: Ini mengganti semua underscore (_) dengan spasi pada kolom kedua.

4.``` proposal_count[$2]++;```: Ini menghitung jumlah proposal untuk setiap pengusul. Array proposal_count digunakan untuk menyimpan jumlah proposal untuk setiap nama pengusul.

5.```if (proposal_count[$2] == 2) {```: Jika jumlah proposal untuk pengusul tertentu sama dengan 2, maka jalankan blok kode di bawahnya.

6.```pengusul[$2] = $2;```: Ini menyimpan nama pengusul ke dalam array pengusul.

7.``` pembimbing[$2] = $6;```: Ini menyimpan nama pembimbing ke dalam array pembimbing untuk pengusul yang memiliki dua proposal.

8.```} else if (proposal_count[$2] > 2) {```: Jika jumlah proposal untuk pengusul tertentu lebih dari 2, maka hapus data pengusul tersebut dari array pengusul.

9.``` delete pengusul[$2];```: Ini menghapus data pengusul dari array pengusul.

10.``` END {```: Awk akan menjalankan blok kode yang berada di dalam kurung kurawal ini setelah selesai membaca seluruh baris pada file.

11.```for (pengusul_name in proposal_count) {```: Awk akan melakukan iterasi untuk setiap nama pengusul yang terdapat dalam array proposal_count.

12.```if (proposal_count[pengusul_name] > 1) {```: Jika jumlah proposal untuk pengusul tertentu lebih dari 1, maka jalankan blok kode di bawahnya.

13.```print "Nama Pengusul:", pengusul_name, "Pembimbing:", pembimbing[pengusul_name];```: Ini mencetak nama pengusul beserta nama pembimbingnya jika pengusul tersebut memiliki lebih dari satu proposal.

#### Hasil : 
A. <br>
![Screenshot 2024-03-28 163049](https://github.com/sisop-its-s24/praktikum-modul-1-d21/blob/main/resources/Screen%20Shot%202024-03-30%20at%2016.22.36.png) <br>
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

B. Yuan juga ingin membuat file bash register bernama yu_register.sh untuk handle peserta baru yang ingin upload proposal. Data baru ini akan langsung disimpan dalam file .csv tersebut. 
   Ketentuannya adalah:
   Memasukkan nama_pengusul, asal departemen, fakultas, judul proposal, dosen pendamping (nidn), skema pkm. (Sesuaikan dengan file .csv)
   Setiap percobaan register akan tercatat pada log.txt dengan format YY/MM/DD hh:mm:ss MESSAGE
   Dengan MESSAGE berupa:
   REGISTER: SUCCESS USER_NAME is registered. Proposal PROPOSAL_NUMBER is added
   Atau
   REGISTER: ERROR USER_NAME is already existed

#### Penyelesaian :
Membuat dan menjalankan file yu_register.sh dengan cara :<br>
```
nano yu_register.sh
```
```
chmod +x yu_register.sh
```
```
./yu_register.sh
```
Input :
```
#!/bin/bash

csv_file="data-pkm.csv"
log_file="log.txt"

log_message() {
    echo "$(date '+%y/%m/%d %H:%M:%S') $1" >> "$log_file"
}

register() {
    local data=("$@")  # Menyimpan argumen dalam array data
    local nama_pengusul="${data[0]}"
    local asal_departemen="${data[1]}"
    local fakultas="${data[2]}"
    local judul="${data[3]}"
    local pendamping="${data[4]}"
    local skema="${data[5]}"

    # Membersihkan input dari koma
    for i in {0..5}; do
        data[$i]=$(echo "${data[$i]}" | sed 's/,/\\,/g')
    done

    if grep -q "^.*${nama_pengusul}.*" "$csv_file"; then
        log_message "REGISTER: ERROR $nama_pengusul is already existed"
        echo "Error: User already exists."
        return 1
    fi

    # Menentukan nomor proposal
    if [[ -z "${data[6]}" || ! "${data[6]}" =~ ^[0-9]+$ ]]; then
        local last_number=$(tail -1 "$csv_file" | cut -d ',' -f1)
        data[6]=$((last_number + 1))
    fi

    # Menyimpan data proposal ke dalam file CSV
    echo "${data[*]}" | sed 's/\\,/,/g' >> "$csv_file"
    log_message "REGISTER: SUCCESS ${nama_pengusul} is registered. Proposal ${data[6]} is added"

    echo "Registration successful."
    return 0
}

read_input() {
    local prompt=$1
    local variable_name=$2
    read -p "$prompt: " "$variable_name"
}

main() {
    declare -a proposal_data

    read_input "Masukkan nama_pengusul" nama_pengusul
    read_input "Masukkan asal_departemen" asal_departemen
    read_input "Masukkan fakultas" fakultas
    read_input "Masukkan judul" judul
    read_input "Masukkan pendamping (ID)" pendamping
    read_input "Masukkan skema" skema

    # Menyimpan data input ke dalam array proposal_data
    proposal_data=("$nama_pengusul" "$asal_departemen" "$fakultas" "$judul" "$pendamping" "$skema")

    register "${proposal_data[@]}"
}

main "$@"
```
Penjelasan : <br>
1. ```csv_file="data-pkm.csv"```: Variabel csv_file menyimpan nama file CSV yang akan digunakan untuk menyimpan data proposal.

2.```log_file="log.txt"```: Variabel log_file menyimpan nama file log yang akan digunakan untuk mencatat pesan log.

3.```log_message()```: Ini adalah sebuah fungsi yang akan mencetak pesan log ke dalam file log dengan format tanggal dan waktu yang ditambahkan di depan pesan.

4.``` register()```: Ini adalah fungsi utama yang bertanggung jawab untuk mendaftarkan proposal penelitian.

   a.``` local data=("$@")```: Variabel lokal data menyimpan semua argumen yang diterima oleh fungsi ini dalam bentuk array.

   b. ```local nama_pengusul="${data[0]}", local asal_departemen="${data[1]}", dst.```: Variabel lokal ini menyimpan nilai dari array data ke dalam variabel-variabel lokal sesuai dengan posisi mereka dalam array.

   c.```Loop for```digunakan untuk membersihkan input dari koma (,) dengan mengubahnya menjadi \\, agar tidak terbaca sebagai pemisah dalam file CSV.

   d.``` if grep -q "^.*${nama_pengusul}.*" "$csv_file"; then```: Ini menggunakan grep untuk memeriksa apakah nama pengusul sudah ada dalam file CSV.

   e. Jika nama pengusul sudah ada, maka fungsi akan mencetak pesan log bahwa registrasi gagal dan mengembalikan nilai 1. Jika tidak, maka proses registrasi akan dilanjutkan.

   f. Bagian selanjutnya menentukan nomor proposal dengan mengambil nomor terakhir dari file CSV dan menambahkannya dengan 1.

   g. Kemudian data proposal akan disimpan ke dalam file CSV dengan menggunakan perintah echo dan sed untuk mengubah kembali tanda \\, menjadi ,.

   h. Terakhir, fungsi ini mencetak pesan log bahwa registrasi berhasil dan mengembalikan nilai 0.

6. ```read_input()```: Ini adalah fungsi kecil yang digunakan untuk membaca input dari pengguna dan menyimpannya ke dalam variabel yang disebutkan.

7.``` main()```: Fungsi utama dari skrip ini.

   a. Pertama, deklarasi array proposal_data.

   b. Kemudian, menggunakan read_input untuk membaca input dari pengguna

C.Yuan tidak ingin capek. Dia membuat automasi di file bash bernama yu_database.sh untuk dapat membuat file users.txt guna menyimpan username dan password dari para peserta. Ketentuannya adalah:<br>
File users.txt akan diupdate setiap 1 jam sekali<br>
Simpan konfigurasi cron pada file crontabs<br>

#### Penyelesaian :
Membuat file yu_database.sh dan input scriptnya dengan cara:<br>
```
nano yu_database.sh
```
ganti akses agar bisa di run
```
chmod +x yu_database.sh
```
kemudian jalankan scriptnya dengan:
```
./yu_database.sh
```
Untuk pengaturan crontabs dengan cara :<br>
```
crontabs -e
```
```
#!/bin/bash

while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema
do
    usrnme="$Nama_Pengusul"

    temp=$(echo "$Pendamping" | grep -o '[0-9]*')
    pass="$Fakultas$temp"

    echo "$usrnme:$pass" >> users.txt
done < /home/liares/Documents/sisop/pratikum1/praktikum-modul-1-d21/resources/data-pkm.csv
```
Untuk pengaturan crontab:
````
0 * * * * /home/liares/Documents/sisop/pratikum1/praktikum-modul-1-d21/task-2/yu_database.sh
````

#### Penjelasan:<br>
1.```while IFS=',' read -r No Nama_Pengusul Departemen Fakultas Judul Pendamping Skema``` loop whlle yang ngebaca data dari file data-pkm.csv dan setiap barisnya dipisah dengan ',', kemudian value dari masing-masing kolom disimpan sesuai 7 variabel sesuai.<br>
2.```do usrnme="$Nama_Pengusul"```variable usrnme akses value dari variable Nama_Pengusul dengan '$', jadi value dari Nama_Pengusul disimpen ke usrnme<br>
3.```temp=$(echo "$Pendamping" | grep -o '[0-9]*')```Karena pass ngebutuhin nomor nip doang dari pendamping dan di dalam kolom Pendamping itu gabung ama namanya maka perlu dipisah dengan perintah grep, dimana grep akan hanya mengambil value dari Pendamping yang hanya berupa angka 0-9. Hasilnya akan disimpan ke temp.<br>
4.```pass="$Fakultas$temp"```Disini tinggal gabungin antara value dari variabel fakultas dan variabel temp(nomor nip pendamping) untuk menjadi pass. Hasilnya akan disimpanke pass.<br>
5.```echo "$usrnme:$pass" >> users.txt```Sesuai dengan soal, ingin menyimpan semua pass dan usrnme dari data-pkm.csv ke users.txt, maka kita print value dari variable usrnme dan pass ke dalam users.txt<br>
6.```done < /home/liares/Documents/sisop/pratikum1/praktikum-modul-1-d21/resources/data-pkm.csv``` ini merupakan end loop, dan file yang akan dibaca adalah dari path ./home/.../data-pkm.csv<br>
7.```0 * * * * /home/liares/Documents/sisop/pratikum1/praktikum-modul-1-d21/task-2/yu_database.sh```Karena soal pengen users.txt diupdate setiap 1 jam sekali, maka script yu_database.sh akan kita run setiap 1 jam sekali dengan cronjob 0**** yang menunjukkan 1 jam sekali.<br>.

#### Hasil :
A.<br>
![Screenshot 2024-03-28 163721](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/20de0483-dda3-4e94-93b2-219e270322ae)<br>
<br>
![Screenshot 2024-03-28 163857](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/3fde77f5-425f-427b-b7e6-706ba0eeff54)<br>
<br>

B.<br>
![Screenshot 2024-03-28 163049]() <br>
![Screenshot from 2024-03-30 18-17-04](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/104217128/7c2611df-6845-4402-bca7-b119ecc10bee)<br>
![Screenshot from 2024-03-30 18-18-41](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/104217128/fbff95c5-6b61-4d6f-9e8d-d63b94438fff)<br>
![Screenshot from 2024-03-30 18-18-55](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/104217128/77e4ff95-5022-4b12-9ceb-59e7fa741068)<br>

C.<br>
![Screenshot from 2024-03-30 11-52-54](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/104217128/e1ce5794-7a84-4621-aa4d-403973b99514)<br>
<br>
#### Kendala : 
Pada nomor 2A terdapat beberapa kata yang masih tidak bisa login padahal username dan password sudah benar.<br>


### 3. Task 3 - Magang Bubu (Bubu's Internship)
A. Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-30 15:00:00, maka file log yang akan tergenerate adalah metrics_20240330150000.log.<br>
 #### Penyelesaian :

 Membuat dan menjalankan file minute_log.sh dengan cara :<br>
```
nano minute_log.sh
```
```
chmod +x minute_log.sh
```
```
./minute_log.sh
```
Input : <br>
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
Mmebuka crontabs dengan cara :<br>
```
crontabs -e
```
Input : <br>
```* * * * * /home/helsasp/minute_log.sh``` <br>
Penjelasan : <br>
Jadwal eksekusi tugas diatur untuk menjalankan skrip setiap menit tanpa pembatasan pada jam, hari dalam bulan, bulan, atau hari dalam minggu.Path lengkap ke skrip atau program yang akan dijalankan adalah /home/helsasp/minute_log.sh. Dengan demikian, skrip minute_log.sh akan dijalankan setiap menit tanpa ada batasan pada waktu, tanggal, atau hari dalam seminggu di dalam direktori /home/helsasp/<br>

C.Kemudian, buat satu script untuk membuat aggregasi file log ke satuan jam. Script aggregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file aggregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File aggregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil aggregasi metrics_agg_2023033015.log dengan format metrics_agg_{YmdH}.log. <br>
#### Penyelesaian :
Membuat dan menjalankan file aggregate_minutes_to_hourly_log.sh dengan cara :<br>
```
nano aggregate_minutes_to_hourly_log.sh
```
```
chmod +x aggregate_minutes_to_hourly_log.sh
```
```
./aggregate_minutes_to_hourly_log.sh
```
Input : <br>
```
#!/bin/bash

waktu=$(date +"%Y%m%d%H")
log_folder="/home/$USER/metrics"

aggregation_hourly="${log_folder}/metrics_agg_${waktu}.log"
minute_logfile=$(find "$log_folder" -name "metrics_${waktu}*.log")

#Array
declare -a sumMemTotal=()
declare -a sumMemUsed=()
declare -a sumMemFree=()
declare -a sumMemShared=()
declare -a sumMemBuff=()
declare -a sumMemAvailable=()
declare -a sumSwapTotal=()
declare -a sumSwapUsed=()
declare -a sumSwapFree=()
declare -a sumPathSize=()

# Function Max, Min, AVG
findMax() {
  max=$(printf '%d\n' "${@}" | sort -rn | head -n 1)
  echo "$max"
}

findMin() {
  min=$(printf '%d\n' "${@}" | sort -n | head -n 1)
  echo "$min"
}

findAVG() {
  jumlahData=0
  banyakData=0
  
  for value in "$@"; do
    jumlahData=$(echo "$jumlahData + $value" | bc)
    ((banyakData++))
  done
  
  average=$(echo "scale=1; $jumlahData / $banyakData" | bc)
  if [[ "${average#*.}" == "0" ]]; then
      echo "${average%.*}" 
  else
      echo "$average" # remove .0
  fi
}

#Read metrics
for log in $minute_logfile; do   

    IFS=, read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size < <(tail -n 1 "$log")
path_size="${path_size//M/}"
path_size="${path_size//K/}"
path_size="${path_size//B/}"

sumMemTotal+=("$mem_total")
sumMemUsed+=("$mem_used")
sumMemFree+=("$mem_free")
sumMemShared+=("$mem_shared")
sumMemBuff+=("$mem_buff")
sumMemAvailable+=("$mem_available")
sumSwapTotal+=("$swap_total")
sumSwapUsed+=("$swap_used")
sumSwapFree+=("$swap_free")
sumPathSize+=("$path_size")

done

#MIN VALUE
min_mem_total=$(findMin "${sumMemTotal[@]}")
min_mem_used=$(findMin "${sumMemUsed[@]}")
min_mem_free=$(findMin "${sumMemFree[@]}")
min_mem_shared=$(findMin "${sumMemShared[@]}")
min_mem_buff=$(findMin "${sumMemBuff[@]}")
min_mem_available=$(findMin "${sumMemAvailable[@]}")
min_swap_total=$(findMin "${sumSwapTotal[@]}")
min_swap_used=$(findMin "${sumSwapUsed[@]}")
min_swap_free=$(findMin "${sumSwapFree[@]}")
min_path_size=$(findMin "${sumPathSize[@]}")

#MAX VALUE
max_mem_total=$(findMax "${sumMemTotal[@]}")
max_mem_used=$(findMax "${sumMemUsed[@]}")
max_mem_free=$(findMax "${sumMemFree[@]}")
max_mem_shared=$(findMax "${sumMemShared[@]}")
max_mem_buff=$(findMax "${sumMemBuff[@]}")
max_mem_available=$(findMax "${sumMemAvailable[@]}")
max_swap_total=$(findMax "${sumSwapTotal[@]}")
max_swap_used=$(findMax "${sumSwapUsed[@]}")
max_swap_free=$(findMax "${sumSwapFree[@]}")
max_path_size=$(findMax "${sumPathSize[@]}")

#AVG VALUE
avg_mem_total=$(findAVG "${sumMemTotal[@]}")
avg_mem_used=$(findAVG "${sumMemUsed[@]}")
avg_mem_free=$(findAVG "${sumMemFree[@]}")
avg_mem_shared=$(findAVG "${sumMemShared[@]}")
avg_mem_buff=$(findAVG "${sumMemBuff[@]}")
avg_mem_available=$(findAVG "${sumMemAvailable[@]}")
avg_swap_total=$(findAVG "${sumSwapTotal[@]}")
avg_swap_used=$(findAVG "${sumSwapUsed[@]}")
avg_swap_free=$(findAVG "${sumSwapFree[@]}")
avg_path_size=$(findAVG "${sumPathSize[@]}")

#Result
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$aggregation_hourly"
echo "minimum,$min_mem_total,$min_mem_used,$min_mem_free,$min_mem_shared,$min_mem_buff,$min_mem_available,$min_swap_total,$min_swap_used,$min_swap_free,/home/$USER,${min_path_size}M" >> "$aggregation_hourly"
echo "maximum,$max_mem_total,$max_mem_used,$max_mem_free,$max_mem_shared,$max_mem_buff,$max_mem_available,$max_swap_total,$max_swap_used,$max_swap_free,/home/$USER,${max_path_size}M" >> "$aggregation_hourly"
echo "average,$avg_mem_total,$avg_mem_used,$avg_mem_free,$avg_mem_shared,$avg_mem_buff,$avg_mem_available,$avg_swap_total,$avg_swap_used,$avg_swap_free,/home/$USER,${avg_path_size}M" >> "$aggregation_hourly"

#User Permission
chmod 400 "$aggregation_hourly"

```
Penjelasan : 

1.```waktu=$(date +"%Y%m%d%H")```:Menyimpan timestamp saat ini dalam format YMDH. <br>
2.```log_folder="/home/$USER/metrics"```: Mnyimpan jalur folder di mana file log akan disimpan. $USER adalah variabel berisi nama pengguna saat ini.<br>
3.```aggregation_hourly="${log_folder}/metrics_agg_${waktu}.log"```: Menyimpan jalur file log hasil aggregasi.<br>
4.```minute_logfile=$(find "$log_folder" -name "metrics_${waktu}*.log")```: Menyimpan daftar file log per menit yang akan dianalisis.<br>
5.```declare -a sumMemTotal=(), dan seterusnya ```: Mendeklarasikan array untuk menyimpan data yang akan dihitung nanti.<br>
6.``` findMax() {max=$(printf '%d\n' "${@}" | sort -rn | head -n 1)echo "$max"}``` : Fungsi untuk mencari nilai maksimum dari sebuah array dengan disortir secara numerik (-n) dalam urutan menurun (-r), sehingga nilai terbesar akan berada di atas.Output dari perintah sort tersebut kemudian dipiping ke perintah head untuk mengambil hanya baris pertama, yang berisi nilai maksimum<br>
7. ```findMin() {min=$(printf '%d\n' "${@}" | sort -n | head -n 1)echo "$min"} ```: Fungsi untuk menemukan nilai minimum dari sebuah array dengan diurutkan secara numerik (-n), sehingga nilai minimum akan berada di bagian atas.Output dari perintah sort tersebut kemudian dipiping ke perintah head untuk mengambil hanya baris pertama, yang berisi nilai minimum.<br>
8. ```findAVG() {jumlahData=0  banyakData=0 for value in "$@"; do  jumlahData=$(echo "$jumlahData + $value" | bc)  ((banyakData++)) done average=$(echo "scale=1; $jumlahData / $banyakData" | bc) if [[ "${average#*.}" == "0" ]]; then echo "${average%.*}"  else echo "$average" #remove .0 fi} ``` : Fungsi untuk menghitung rata - rata dengan menghitung jumlah data/angka di array dibagi banyak data. Rata-rata ditulis hingga 1 satuan di belakang koma. Jika rata-rata bilangan penuh maka akan dioutputkan tanpa koma.<br>
9. ```for log in $minute_logfile; do   IFS=, read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size < <(tail -n 1 "$log")path_size="${path_size//M/}" path_size="${path_size//K/}"path_size="${path_size//B/}" ```: Membaca file log per menit dan untuk path size akan diambil angkanya saja dan meremove sizenya dalam M,K,B. Penggunaan tail -n 1 digunakan untuk mendapatkan baris terakhir dari file log<br>
10. ```sumMemTotal+=("$mem_total") dan seterusnya ``` : Array untuk menyimpan total semua angka/data yang ada di file log<br>
11. ```min_mem_total=$(findMin "${sumMemTotal[@]}") dan seterusnya ```: Variable untuk mendapatkan nilai minimum dari masing - masing kategori dengan masuk ke fungsi findMin<br>
12. ```max_mem_total=$(findMax "${sumMemTotal[@]}") dan seterusnya ```: Variable untuk mendapatkan nilai maksimum dari masing - masing kategori dengan masuk ke fungsi findMax <br>
13. ```avg_mem_total=$(findAVG "${sumMemTotal[@]}") dan seterusnya ```: Variable untuk mendapatkan nilai rata - rata dari masing - masing kategori dengan masuk ke fungsi findAVG<br>
14. ```echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$aggregation_hourly" ```: Mencetak header pada baris pertama di file aggregation_hourly sesuai format di awal.<br>
15.```echo"minimum,$min_mem_total,$min_mem_used,$min_mem_free,$min_mem_shared,$min_mem_buff,$min_mem_available,$min_swap_total,$min_swap_used,$min_swap_free,/home/$USER,${min_path_size}M" >> "$aggregation_hourly"echo "maximum,$max_mem_total,$max_mem_used,$max_mem_free,$max_mem_shared,$max_mem_buff,$max_mem_available,$max_swap_total,$max_swap_used,$max_swap_free,/home/$USER,${max_path_size}M" >> "$aggregation_hourly"echo "average,$avg_mem_total,$avg_mem_used,$avg_mem_free,$avg_mem_shared,$avg_mem_buff,$avg_mem_available,$avg_swap_total,$avg_swap_used,$avg_swap_free,/home/$USER,${avg_path_size}M" >> "$aggregation_hourly" ```: Mengoutputkan nilai minimum, maksimum, dan rata - rata tiap kategori<br>
16. ```chmod 400 "$metrics_file"```: Mengatur izin file log yang dibuat sehingga hanya pengguna yang memiliki izin baca saja.<br>

Untuk menjalankan otomatis setiap jam, digunakan Crontabs. <br>
Mmebuka crontabs dengan cara :<br>
```
crontabs -e
```
Input : <br>
```0 * * * * /home/helsasp/aggregate_minutes_to_hourly_log.sh``` <br>
Penjelasan : <br>
Jadwal eksekusi tugas diatur untuk menjalankan skrip setiap jam tanpa pembatasan hari dalam bulan, bulan, atau hari dalam minggu.Path lengkap ke skrip atau program yang akan dijalankan adalah /home/helsasp/aggregate_minutes_to_hourly_log.sh. Dengan demikian, skrip aggregate_minutes_to_hourly_log.sh akan dijalankan setiap jam tanpa ada batasan pada waktu, tanggal, atau hari dalam seminggu di dalam direktori /home/helsasp/<br>

D. Selanjutnya agar lebih menghemat penyimpan, buatlah script backup_metrics.sh. Dimana script ini akan menyimpan semua log metrics aggregasi mulai dari pukul 00:00 sampai 23:59 didalam 1 file .gz menggunakan gunzip. Contoh nama file hasil zip backup_metrics_{date_YmdH}.gz <br>

#### Penyelesaian :
Membuat dan menjalankan file backup_metrics.sh dengan cara :<br>
```
nano backup_metrics.sh
```
```
chmod +x backup_metrics.sh
```
```
./backup_metrics.sh
```
Input : <br>
```
#!/bin/bash

logFolder="/home/$USER/metrics"
backupFile="/home/$USER"
day=$(date +"%Y%m%d")
hour=$(date +"%H")

cd "$logFolder" || exit

tar -cf "$backupFile/backup_metrics_${day}${hour}.tar" metrics_agg_"${day}"*.log
gzip -f "$backupFile/backup_metrics_${day}${hour}.tar"

mv "$backupFile/backup_metrics_${day}${hour}.tar.gz" "$backupFile/backup_metrics_${day}${hour}.gz"
```
Penjelasan :<br>
1. ```logFolder="/home/$USER/metrics"``` : menyimpan path ke folder di mana file log metrik berada. <br>
2. ```backupFile="/home/$USER"``` : menyimpan path ke folder tempat backup akan disimpan.<br>
3. ```day=$(date +"%Y%m%d")``` : menyimpan tanggal saat ini dalam format tahun-bulan-tanggal<br>
4. ```hour=$(date +"%H") ```: menyimpan jam saat ini dalam format 24 jam<br>
5. ```cd "$logFolder" || exit``` : berpindah ke direktori $logFolder atau keluar dari skrip jika tidak dapat.<br>
6. ```tar -cf "$backupFile/backup_metrics_${day}${hour}.tar" metrics_agg_"${day}"*.log ```: membuat sebuah file tar yang berisi semua file log metrik yang sesuai dengan pola metrics_agg_${day}*.log<br>
7. ```gzip -f "$backupFile/backup_metrics_${day}${hour}.tar ```: mengompresi file tar yang dibuat sebelumnya ke dalam format gzip (-f untuk memaksa kompresi)<br>
8. ```mv "$backupFile/backup_metrics_${day}${hour}.tar.gz" "$backupFile/backup_metrics_${day}${hour}.gz"```: Ini mengganti nama file terkompresi dari .tar.gz menjadi .gz.<br>

Untuk menjalankan otomatis setiap jam, digunakan Crontabs. <br>
Membuka crontabs dengan cara :<br>
```
crontabs -e
```
Input : <br>
```0 * * * * /home/helsasp/backup_metrics.sh``` <br>
Penjelasan : <br>
Jadwal eksekusi tugas diatur untuk menjalankan skrip setiap jam tanpa pembatasan hari dalam bulan, bulan, atau hari dalam minggu.Path lengkap ke skrip atau program yang akan dijalankan adalah /home/helsasp/backup_metrics.sh. Dengan demikian, skrip backup_metrics.sh akan dijalankan setiap jam tanpa ada batasan pada waktu, tanggal, atau hari dalam seminggu di dalam direktori /home/helsasp/<br>

E.Karena file log bersifat sensitif pastikan semua file log hanya dapat dibaca oleh user pemilik file.
#### Penyelesaian:
Terdapat 2 log pada soal nomor 3, yaitu log yang terbentuk dari minute_log.sh, dan log yang terbentuk dari aggregate_minutes_to_hourly_log.sh. Oleh karena itu pada minute_log.sh seperti pada script di atas sudah ditambahkan chmod 400 "$metrics_file" dan pada aggregate_minutes_to_hourly_log.sh sudah ditambahkan chmod 400 "$aggregation_hourly".

#### Hasil :
A. <br>
![Screenshot 2024-03-28 164206](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/2e0979b6-db8d-4819-b7da-4750eec145ab)<br>
B. <br>
![Screenshot 2024-03-28 164335](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/36317e06-4740-4f24-9143-f763445b279f)<br>
C. <br>
![Screenshot 2024-03-28 164501](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/4cf4e39f-7739-4278-b0fa-1440fd8db70f)<br>
<br>
![Screenshot 2024-03-28 164634](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/bd43cdc7-17e3-4a8f-b0ff-b379c5dfaec3)<br>
D. <br>
![Screenshot 2024-03-29 133155](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/49a340e2-d1ae-424e-b809-23764b173c6d)


#### Kendala : 
Pada no 3D awalnya tidak bisa mengompress beberapa file menjadi 1, namun sudah bisa dengan tar dan sudah direvisi.


### 4. Task 4 - LDR Isabel (Isabel Sad Relationship)
A. Isabel sedang LDR dengan pacarnya dan sangat rindu. Isabel ingin menyimpan semua foto-foto yang dikirim oleh pacarnya. Bantulah Isabel menyimpan gambar "Mingyu Seventeen”.
Berikut adalah ketentuan yang diinginkan Isabel:
   Gambarnya di download setiap 5 jam sekali mulai dari saat script dijalankan dan memperhatikan waktu sekarang. Jika waktu genap, maka simpan foto sebanyak 5x. Jika waktu ganjil, maka simpan foto sebanyak 3x. (Contoh : pukul sekarang 12.38, maka pukul 12 adalah genap     sehingga simpan foto sebanyak 5x).
   Jika pukul menunjukkan 00.00, maka simpan foto sebanyak 10x.
   File yang didownload memiliki format nama foto_NOMOR.FILE dengan NOMOR.FILE adalah urutan file yang download (foto_1, foto_2, dst)
   File batch yang didownload akan dimasukkan ke dalam folder dengan format nama folder_NOMOR.FOLDER dengan NOMOR.FOLDER adalah urutan folder saat dibuat (folder_1, folder_2, dst)

#### Penyelesaian :
Membuat dan menjalankan file isabel.sh dengan cara :<br>
```
nano isabel.sh
```
```
chmod +x isabel.sh
```
```
./isabel.sh
```
Input : <br>
```
 #!/bin/bash

curr_jam=$(date +"%H")

get_num_photos() {
    if [ "$1" == "00" ]; then
        echo 10
    elif [ $((curr_jam % 2)) -eq 0 ]; then
        echo 5
    else
        echo 3
    fi
}

num_photos=$(get_num_photos "$curr_jam")
idx=0;
folder_name="folder_$((++idx))" 

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
```
Penjelasan :<br>
1.``` curr_jam=$(date +"%H")```: Variabel curr_jam menyimpan jam saat ini dalam format 24 jam.

2. ```get_num_photos()```: Fungsi ini digunakan untuk mengembalikan jumlah foto yang akan diunduh berdasarkan jam saat ini.

   a. Jika jam saat ini adalah pukul 00:00, maka akan mengembalikan angka 10.

   b. Jika jam saat ini merupakan angka genap, maka akan mengembalikan angka 5.

   c. Jika jam saat ini bukan angka genap, maka akan mengembalikan angka 3.

3. ```num_photos=$(get_num_photos "$curr_jam")```: Menggunakan fungsi get_num_photos untuk mendapatkan jumlah foto yang harus diunduh berdasarkan jam saat ini.

4.``` idx=0; folder_name="folder_$((++idx))"```: Menginisialisasi variabel idx dengan 0 dan membuat nama folder baru berdasarkan nilai dari idx.

5.``` download_photos()```: Fungsi ini digunakan untuk mengunduh foto-foto ke dalam folder yang telah dibuat.

   a. Parameter folder menyimpan nama folder tempat foto-foto akan disimpan.

   b. Parameter num menyimpan jumlah foto yang akan diunduh.

c. Melakukan iterasi sebanyak num untuk mengunduh foto-foto dengan menggunakan perintah wget.

6. ```mkdir "$folder_name"```: Membuat folder baru dengan nama yang telah ditentukan sebelumnya.

7. ```download_photos "$folder_name" "$num_photos"```: Memanggil fungsi download_photos dengan argumen nama folder dan jumlah foto yang akan diunduh.

8.```echo "Photos downloaded successfully :)"```: Mencetak pesan bahwa unduhan foto berhasil.

#### Hasil : 
A. <br>
![Screenshot 2024-03-28 163049](https://github.com/sisop-its-s24/praktikum-modul-1-d21/blob/main/resources/Screen%20Shot%202024-03-30%20at%2016.29.34.png) <br>
#### Kendala :

B.Karena memory laptop Isabel penuh, maka bantulah Isabel untuk zip foto-foto tersebut dengan ketentuan:<br>
Isabel harus melakukan zip setiap 1 jam dengan nama zip ayang_NOMOR.ZIP dengan NOMOR.ZIP adalah urutan folder saat dibuat (ayang_1, ayang_2, dst). Yang di ZIP hanyalah folder dari soal di atas. <br>
#### Penyelesaian : <br>
```

```

#### Penjelasan :


C.Ternyata laptop Isabel masih penuh, bantulah dia untuk delete semua folder dan zip setiap hari pada pukul 02.00!
#### Penyelesaian : <br>
```
0 2 * * * bash -c 'rm -rf folder_* ayang_*.zip'
```

#### Penjelasan : <br>
1.```0 2 * * *```karena soal minta untuk delete semua folder dan zip pada cronjob kita set jam  0 2.<br>
2.```bash -c``` untuk execute command yang akan kita jalanin. <br>
3.```'rm -rf folder_* ayang_*.zip'```command yang akan ngedelete semua file dengan format nama awal folder_ dan ayang_.zip.

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


#### Hasil :

D. <br>
![Screenshot 2024-03-28 165145](https://github.com/sisop-its-s24/praktikum-modul-1-d21/assets/144691463/2f4236cd-b88f-4bea-a702-ff7cffd00b01) <br>

#### Kendala :
   




   
   
