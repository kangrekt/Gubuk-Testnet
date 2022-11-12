<p style="font-size:14px" align="right">
<a href="https://t.me/bangpateng_group" target="_blank">Join EG Discord <img src="https://www.pngarts.com/files/12/Blue-Discord-Logo-Icon-PNG-Photo.png" width="30"/></a>

<p align="center">
  <img height="150" height="auto" src="https://user-images.githubusercontent.com/38981255/185994172-0b4e4ea8-f81a-48db-8020-9be619f485b7.png">
</p>

# ALEO PROVER TESTNET INCENTIVIZED

### ✅️ Aleo Discord

https://discord.gg/U3BJMSVNVc

### ✅️ My server Discord

https://discord.gg/RJBCrAXsru

### ✅️ Website

https://www.aleo.org/

##  Spesifiksi Minimal

Berikut adalah persyaratan **minimum** untuk menjalankan node Aleo:

 -  **CPU** : 16-core (lebih disukai 32-core)
 -  **RAM** : Memori 16GB (lebih disukai 32GB)
 -  **Penyimpanan** : 128GB ruang disk
 -  **Jaringan** : 50 Mbps upload **dan** bandwidth download

# Instal Otomatis

```
wget -O prover.sh https://raw.githubusercontent.com/kangrekt/Gubuk-Testnet/main/Aleo-Prover/prover.sh && chmod +x prover.sh && ./prover.sh
```

Biarkan Instalisasi Selesai Lama Kudu Sabar dan Jangan Lupa Backup Semua Data Kalian Yang Muncul, Setelah Instalisasi Otomatis

# Run Prover

```
cd snarkOS
screen -R prover
```

```
./run-prover.sh
```
- Masukan Private Key Yang Sudah Kalian Backup Sebelumnya dan Diamkan Hingga Selesai. 
- `ctrl A D` untuk Menyimpan Screen Agar Jalan di Background Pc Kalian
- Jika anda Ingin Kembali ke Screen Yang Sedang Jalan, Gunakan Perintah `screen -Rd prover`

## Uninstal (Gunakan Jika Mau Menghapus Data Node)

```
rustup self uninstall
rm -rf prover.sh
rm -rf snarkOS
```
