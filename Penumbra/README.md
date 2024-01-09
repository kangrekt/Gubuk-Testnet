
Tutor Official
> - Official https://guide.penumbra.zone/main/index.html
> - Discord https://discord.gg/8QCunyuNF8

###  Persyaratan Perangkat Keras Minimum
 - 4x CPU; semakin cepat kecepatan jam semakin baik
 -RAM 8GB
 - Penyimpanan 100GB (SSD atau NVME)

###  Otomatis Install
```
wget -O penumbra_64-2.sh https://raw.githubusercontent.com/kangrekt/Gubuk-Testnet/main/Penumbra/penumbra_64-2.sh && chmod +x penumbra_64-2.sh && ./penumbra_64-2.sh
```
Tunggu sampai proses selesai, disini Anda boleh kelon atau coli dulu :v
Setelah proses selesai maka akan ada output #NAMA NODEMU 
Kemudian Output #Wallet new/restore, untuk membuat wallet baru ketikan 'new' (tanpa kutip)
untuk restore ketikan 'restore' (tanpa kutip).. Setelah itu otomatis muncul output silahkan CTRL+C

##### =>=>=> SAVE SEED PHRASE JANGAN LUPA <=<=<=

# Request Saldo

### Download Wallet Extension [DISINI](https://chromewebstore.google.com/detail/penumbra-wallet/lkpmkhpnhknhmibgnmmhdhgdilepfghe?hl=en-US&utm_source=ext_sidebar)
###Import Phrase yang di buat tadi ke wallet kemudian request Faucet di Discord

## pcli executable
```
find / -name pcli 2>/dev/null
```
## pcli PATH
```
echo "export PATH=\$PATH:/root/penumbra/target/release" >> $HOME/.profile
source $HOME/.profile
```
## Cek Sync
```
pcli view sync
```
## Cek saldo
```
pcli view balance
```

# BUAT VALIDATOR OTOMATIS
```
curl -O https://raw.githubusercontent.com/kangrekt/Gubuk-Testnet/main/Penumbra/penumbra_validator.sh && chmod +x penumbra_validator.sh && ./penumbra_validator.sh
```

### Delegate Validatormu
Cek Identitas validator
```
pcli validator identity
```
Delegate
```
pcli tx delegate 99penumbra --to <Identitas validatormu>
```
## Cek Status Validator
```
pcli query validator list -i
```

#UNTUK MENJADI AKTIVE SILAHKAN NUYUL FAUCET, SARAN PAKAI VPS LAIN UNTUK NUYUL..

### Send saldo ke address lain
```
pcli tx send 99penumbra --to penumbrav2t...
```
#SELAMAT NGOPI

