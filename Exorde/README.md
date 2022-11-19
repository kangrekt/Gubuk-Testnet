# Tutorial ExordeLabs Incentive Testnet

### ✅️ Exorde Discord

https://discord.gg/exordelabs

### ✅️ My server Discord

https://discord.gg/RJBCrAXsru

### ✅️ Website

https://exorde.network


## Persyaratan perangkat keras

| Komponen | Spesifikasi minimal |
|----------|---------------------|
|CPU|Intel Core i3 or i5|
|RAM|4 GB DDR4 RAM|
|Penyimpanan|500 GB HDD|
|Koneksi|100 Mbit/s port|


## Install Docker

### Update apt

```
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    screen \
    git
```

### Tambahkan kunci GPG Docker resmi

```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```


### Setting repositori

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Install Docker

```
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

```

### Cek Docker

```
docker --version
```

> Jika sukses maka akan keluar output: `Docker version 20.10.20, build 9fdeb9c`

### Install Exorde

```
git clone https://github.com/exorde-labs/ExordeModuleCLI.git
```

### Masuk ke folder Exorde

```
cd ExordeModuleCLI
```

### Build Docker

```
docker build -t exorde-cli . 
```

### Jalankan validator

Buka layar baru menggunakan `screen`

```
screen -Rd exorde
```

Lalu jalankan perintah dibawah (ubah ETHWALLET dengan wallet anda)

```
docker rm $(docker ps -a -q) --force
docker rmi $(docker images -a -q) --force
docker run -d --restart unless-stopped --pull always --name exorde-cli rg.fr-par.scw.cloud/exorde-labs/exorde-cli -m ETHWALLET -l 2
```

Untuk keluar dari terminal gunakan perintah 

```CTRL + A + D```

Untuk masuk ke terminal gunakan perintah 

```
screen -r exorde
```
### Jangan lupa Send Feedback di Discord


> Untuk logging bisa diisi 0, 1, 2, 3, 4 detail logging akan saya jelaskan dibawah


## Logging

| Logging level | Keterangan |
|---------------|------------|
|0|Tidak ada log|
|1|Log biasa|
|2|Log validasi|
|3|Log validasi dan scrapping|
|4|Log validasi (detail) + log scrapping (untuk troubleshoot)

> Saya menyarankan menggunakan Logging level 4 agar mempermudah troubleshoot jika ada masalah
