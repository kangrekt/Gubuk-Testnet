#!/bin/bash
set -e

curl -s https://file.winsnip.xyz/file/uploads/Logo-winsip.sh | bash
sleep 5

apt update
apt install python3 nano git screen -y

cd 
git clone https://github.com/winsnip/moonbix.git

cd moonbix
pip install -r requirements.txt --break-system-packages 
python3 -m venv moonbix
source moonbix/bin/activate 
pip install -r requirements.txt

[[ -f ../moonbix.sh ]] && rm /root/moonbix.sh
[[ -f requirements.txt ]] && rm requirements.txt

while true; do
    nano data.txt
    read -p "Apakah ingin menambahkan token lagi? (y/n): " add_token
    if [[ "$add_token" != "y" && "$add_token" != "Y" ]]; then
        break
    fi
done

read -p "Apakah Anda ingin menggunakan proxy? (y/n): " use_proxy

if [[ "$use_proxy" == "y" || "$use_proxy" == "Y" ]]; then
    if [[ -f ../proxy.txt ]]; then
        proxy=$(<../proxy.txt)
        if [[ -z "$proxy" ]]; then
            nano ../proxy.txt
            proxy=$(<../proxy.txt)
        fi
    else
        nano ../proxy.txt
        proxy=$(<../proxy.txt)
    fi

    screen -S moonbix -dm bash -c "http_proxy=$proxy https_proxy=$proxy python3 main.py"
    echo "Moonbix berhasil dijalankan dengan proxy di dalam screen session"
    echo "Gunakan 'screen -r moonbix' untuk mengakses sesi"
else
    screen -S moonbix -dm bash -c "python3 main.py"
    echo "Moonbix berhasil dijalankan tanpa proxy di dalam screen session"
    echo "Gunakan 'screen -r moonbix' untuk mengakses sesi"
fi
