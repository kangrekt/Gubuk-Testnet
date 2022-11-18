<p style="font-size:14px" align="right">
<a href="https://discord.gg/RJBCrAXsru" target="_blank">Join EG Discord <img src="https://www.pngarts.com/files/12/Blue-Discord-Logo-Icon-PNG-Photo.png" width="30"/></a>
  
  <p align="center">
  <img height="100" height="auto" src="https://user-images.githubusercontent.com/38981255/201691739-df61f26e-5c05-46b5-8ce6-0981a6615d60.PNG">
</p>

#   Tutor Gitopia Testnet Node

Tutor Official
> - [Tutor validator](https://docs.gitopia.com/installation/index.html)

Explorer :
> - [Explorer Checker](https://gitopia.explorers.guru/)

###  Persyaratan Perangkat Keras Minimum
 - 4x CPU; semakin cepat kecepatan jam semakin baik
 -RAM 8GB
 - Penyimpanan 100GB (SSD atau NVME)

###  Opsi 1 (otomatis)
```
wget -O gitopia.sh https://raw.githubusercontent.com/kangrekt/Gubuk-Testnet/main/GITOPIA/gitopia.sh && chmod +x gitopia.sh && ./gitopia.sh
```
##  Pasang instalasi

Muat variabel ke dalam sistem
```
source $HOME/.bash_profile
```

Selanjutnya pastikan blok tersinkron dan status menjadi False. Gunakan perintah di bawah ini untuk memeriksa status sinkronisasi
```
curl -s localhost:41657/status | jq .result.sync_info
```
### Create wallet
Membuat Wallet baru
```
gitopiad keys add $WALLET
```

(OPTIONAL) Jika Anda Mempunyai Wallet Sebelumnya, Silahkan Import Pharse
```
gitopiad keys add $WALLET --recover
```

Untuk melihat daftar wallet
```
gitopiad keys list
```

### Save Info Wallet
Add wallet and valoper address into variables 
```
GITOPIA_WALLET_ADDRESS=$(gitopiad keys show $WALLET -a)
GITOPIA_VALOPER_ADDRESS=$(gitopiad keys show $WALLET --bech val -a)
echo 'export GITOPIA_WALLET_ADDRESS='${GITOPIA_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export GITOPIA_VALOPER_ADDRESS='${GITOPIA_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```

### Fund your wallet

- Import Validator Pharse Wallet Kalian ke Kepler
- Open Web : https://gitopia.com/
- Connect Wallet
- Get 10 Tlore Done

### SNAPSHOOT (Form KjNodes) Buat Loncat Ke Block Saat Ini

Stop Layanan dan Reset

```
sudo systemctl stop gitopiad
cp $HOME/.gitopia/data/priv_validator_state.json $HOME/.gitopia/priv_validator_state.json.backup
rm -rf $HOME/.gitopia/data
```
Download Snapshoot Terbaru (Size File 880 MB)
```
curl -L https://snapshots.kjnodes.com/gitopia-testnet/snapshot_latest.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.gitopia
mv $HOME/.gitopia/priv_validator_state.json.backup $HOME/.gitopia/data/priv_validator_state.json
```
Muat Ulang Layanan dan Periksa Block
```
sudo systemctl start gitopiad && journalctl -u gitopiad -f --no-hostname -o cat
```

### Membuat validator
Before creating validator please make sure that you have at least 1 tlore (1 tlore is equal to 1000000 utlore) and your node is synchronized

To check your wallet balance:
```
gitopiad query bank balances $GITOPIA_WALLET_ADDRESS
```
> If your wallet does not show any balance than probably your node is still syncing. Please wait until it finish to synchronize and then continue 
To create your validator run command below
```
gitopiad tx staking create-validator \
  --amount 95000000utlore \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(gitopiad tendermint show-validator) \
  --moniker $NODENAME \
  --chain-id $GITOPIA_CHAIN_ID \
  --fees 250utlore
```
### Check your validator key
```
[[ $(gitopiad q staking validator $GITOPIA_VALOPER_ADDRESS -oj | jq -r .consensus_pubkey.key) = $(gitopiad status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e "\n\e[1m\e[32mTrue\e[0m\n" || echo -e "\n\e[1m\e[31mFalse\e[0m\n"
```

### Get list of validators
```
gitopiad q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl
```

## Get currently connected peer list with ids
```
curl -sS http://localhost:${GITOPIA_PORT}657/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"' | awk -F ':' '{print $1":"$(NF)}'
```

## Kumpulan Perintah Yang Berguna (Optional)
### Service management
Check logs
```
journalctl -fu gitopiad -o cat
```

Start service
```
sudo systemctl start gitopiad
```

Stop service
```
sudo systemctl stop gitopiad
```

Restart service
```
sudo systemctl restart gitopiad
```

### Node info
Synchronization info
```
gitopiad status 2>&1 | jq .SyncInfo
```

Validator info
```
gitopiad status 2>&1 | jq .ValidatorInfo
```

Node info
```
gitopiad status 2>&1 | jq .NodeInfo
```

Show node id
```
gitopiad tendermint show-node-id
```

### Wallet operations
List of wallets
```
gitopiad keys list
```

Recover wallet
```
gitopiad keys add $WALLET --recover
```

Delete wallet
```
gitopiad keys delete $WALLET
```

Get wallet balance
```
gitopiad query bank balances $GITOPIA_WALLET_ADDRESS
```

Transfer funds
```
gitopiad tx bank send $GITOPIA_WALLET_ADDRESS <TO_GITOPIA_WALLET_ADDRESS> 10000000utlore
```

### Voting
```
gitopiad tx gov vote 1 yes --from $WALLET --chain-id=$GITOPIA_CHAIN_ID
```

### Staking, Delegation and Rewards
Delegate stake
```
gitopiad tx staking delegate $GITOPIA_VALOPER_ADDRESS 10000000utlore --from=$WALLET --chain-id=$GITOPIA_CHAIN_ID --gas=auto
```

Redelegate stake from validator to another validator
```
gitopiad tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000utlore --from=$WALLET --chain-id=$GITOPIA_CHAIN_ID --gas=auto
```

Withdraw all rewards
```
gitopiad tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$GITOPIA_CHAIN_ID --gas=auto
```

Withdraw rewards with commision
```
gitopiad tx distribution withdraw-rewards $GITOPIA_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$GITOPIA_CHAIN_ID
```

### Validator management
Edit validator
```
gitopiad tx staking edit-validator \
  --moniker=$NODENAME \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$GITOPIA_CHAIN_ID \
  --from=$WALLET
```

Unjail validator
```
gitopiad tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$GITOPIA_CHAIN_ID \
  --gas=auto
```

### Hapus Node
This commands will completely remove node from server. Use at your own risk!
```
sudo systemctl stop gitopiad
sudo systemctl disable gitopiad
sudo rm /etc/systemd/system/gitopia* -rf
sudo rm $(which gitopiad) -rf
sudo rm $HOME/.gitopia* -rf
sudo rm $HOME/gitopia -rf
sed -i '/GITOPIA_/d' ~/.bash_profile
```
