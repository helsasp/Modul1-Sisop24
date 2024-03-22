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
    echo "${data[*]}" >> "$csv_file"
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
