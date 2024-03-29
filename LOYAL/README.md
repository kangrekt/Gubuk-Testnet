# LOYAL TESTNET

## Persyaratan Perangkat Keras Minimum

3x CPU; semakin tinggi kecepatan clock semakin baik
RAM 4GB
Disk 80GB
Koneksi Internet yang persisten (lalu lintas minimum 10Mbps selama testnet - setidaknya 100Mbps diharapkan untuk produksi)

### ✅️ Loyal Discord

https://discord.gg/Az5J2zV8Qj

### ✅️ My server Discord

https://discord.gg/RJBCrAXsru

### ✅️ Website Explorer

https://explorer.nodestake.top/loyal-testnet

### ✅️ Docs Official

https://docs.joinloyal.io/validators/run-a-loyal-validator

## Instalisasi Otomatis

```
wget -O loyal.sh https://raw.githubusercontent.com/kangrekt/Gubuk-Testnet/main/LOYAL/loyal.sh && chmod +x loyal.sh && ./loyal.sh
```

### Langkah-Langkah Pasca-Instalasi

Pastikan Validator tersinkron dengan Blok 

```
loyald status 2>&1 | jq .SyncInfo
```

### Membuat Dompet
Gunakan perintah berikut Untuk membuat dompet baru, Keyring pharphase isi katasandi bebas
```
loyald keys add LYL_WALLET
```
(OPSIONAL) Untuk memulihkan dompet Anda menggunakan mnemonic:
```
loyald keys add LYL_WALLET --recover
```
### Untuk mengetahui daftar dompet saat ini:
```
loyald keys list
```
## Simpan Informasi Dompet

Tambahkan Alamat Dompet:
```
LYL_WALLET_ADDRESS=$(loyald keys show LYL_WALLET -a)
```
Enter keyring passphrase: Kata Sandi Anda
```
LYL_VALOPER_ADDRESS=$(loyald keys show LYL_WALLET --bech val -a)
```
Enter keyring passphrase: Isi Kandi Sandi Anda
```
echo 'export LYL_WALLET_ADDRESS='${LYL_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export LYL_VALOPER_ADDRESS='${LYL_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Claim Faucet
Gunakan perintah berikut untuk claim Faucet
```
curl -X POST "https://faucet.joinloyal.io/" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{  \"address\": \"WALLETLOYAL\",  \"coins\": [    \"10000000ulyl\"  ]}"
```
Ubah WALLETLOYAL manjadi wallet Loyal Anda

## Cek Saldo:
```
loyald query bank balances LYL_WALLET_ADDRESS
```
Jika saldo masih 0, tunggu sampe tersyncron dlu :v

## Membuat Validator:
```
loyald tx staking create-validator \
  --amount loyald tx staking create-validator \
  --amount 1900000ulyl \
  --from LYL_WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(loyald tendermint show-validator) \
  --moniker $NODENAME \
  --chain-id $LYL_ID \
  --fees 500ulyl
```

## Perintah yang Berguna

Manajemen Pelayanan Periksa Log:

```
journalctl -fu loyald -o cat
```

Mulai Service:

```
systemctl start loyald
```

Stop Service:

```
systemctl stop loyald
```
Restart Service:
```
systemctl restart loyald
```
Informasi Node Informasi Sinkronisasi:
```
loyald status 2>&1 | jq .SyncInfo
```
Informasi Validator:
```
loyald status 2>&1 | jq .ValidatorInfo
```
Informasi Node:
```
loyald status 2>&1 | jq .NodeInfo
```
Tampilkan ID Node:
```
loyald tendermint show-node-id
```
## Transaksi Dompet

### Daftar Dompet:
```
loyald keys list
```
### Pulihkan dompet menggunakan Mnemonic:
```
loyald keys add LYL_WALLET --recover
```
### Delet Wallet:
```
loyald keys delete LYL_WALLET
```
### Check Saldo Wallet:
```
loyald query bank balances LYL_WALLET_ADDRESS
```
### Transfer Saldo ke Wallet lain:
```
loyald tx bank send LYL_WALLET_ADDRESS <TO_WALLET_ADDRESS> 10000000ulyl
```
### Voting Power
```
loyald tx gov vote 1 yes --from LYL_WALLET --chain-id=$LYL_ID
```
### Stake, Delegate, dan Reward

Delegate:
```
loyald tx staking delegate $LYL_VALOPER_ADDRESS 10000000ulyl --from=LYL_WALLET --chain-id=$LYL_ID --fees 250ulyl
```
### Mentransfer ulang bagian dari validator ke validator lain:
```
loyald tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000ulyl --from=LYL_WALLET --chain-id=$LYL_ID --fees 250ulyl
```
### Claim semua Reward:
```
loyald tx distribution withdraw-all-rewards --from=LYL_WALLET --chain-id=$LYL_ID --fees 250ulyl
```
### Claim Reward:
```
loyald tx distribution withdraw-rewards $LYL_VALOPER_ADDRESS --from=LYL_WALLET --commission --chain-id=$LYL_ID
```
### Ubah Nama Validator:
```
loyald tx staking edit-validator \
--moniker=NEWNODENAME \
--chain-id=$LYL_ID \
--from=LYL_WALLET
```
### Unjail:
```
loyald tx slashing unjail \
  --broadcast-mode=block \
  --from=LYL_WALLET \
  --chain-id=$LYL_ID \
  --gas=auto --fees 250ulyl
```
### Untuk Menghapus Node Sepenuhnya:
```
sudo systemctl stop loyald
sudo systemctl disable loyald
sudo rm /etc/systemd/system/loyald* -rf
sudo rm $(which loyald) -rf
sudo rm $HOME/.loyal* -rf
sudo rm $HOME/loyal* -rf
sed -i '/LYL_/d' ~/.bash_profile
```
