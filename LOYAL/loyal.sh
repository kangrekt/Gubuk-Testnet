@@ -0,0 +1,161 @@
#!/bin/bash
clear
echo "==================================================================="
echo -e "\e[92m"
echo  "   _    _                   __ _                  ";
echo  "  | |  / /                 |  _ \                 ";
echo  "  | |_/ / __ _ _ __   __ _ | |_) |___ _   _| |_   "; 
echo  "  |  _ < / _' | '_ \ / _' ||   _// _ \ |/ /|  __/ ";
echo  "  | | \ \ (_| | | | | (_| || |\ \  __/   < | |    ";
echo  "  |_|  \_\__,_|_| |_|\__, ||_| \_\___|_|\_\ \__\  ";
echo  "                     |___/                        ";

echo -e "\e[0m"
echo "===================================================================" 

echo -e '\e[36mGarapan :\e[39m' Loyal Testnet Convert Script by nodeist
echo -e '\e[36mTwitter :\e[39m' @igot_rug
echo "======================================="

sleep 2

LYL_WALLET=wallet
LYL=loyald
LYL_ID=loyal-1
LYL_PORT=56
LYL_FOLDER=.loyal
LYL_FOLDER2=loyal
LYL_VER=v0.25.1
LYL_REPO=https://github.com/LoyalLabs/loyal.git
LYL_GENESIS=https://raw.githubusercontent.com/LoyalLabs/net/main/mainnet/genesis.json
LYL_ADDRBOOK=
LYL_MIN_GAS=0
LYL_DENOM=ulyl
LYL_SEEDS=7490c272d1c9db40b7b9b61b0df3bb4365cb63a6@loyal-seed.netdots.net:26656,b66ecdf36bb19a9af0460b3ae0901aece93ae006@pubnode1.joinloyal.io:26656
LYL_PEERS=7490c272d1c9db40b7b9b61b0df3bb4365cb63a6@54.80.32.192:26656,b66ecdf36bb19a9af0460b3ae0901aece93ae006@44.211.18.98:26656,a19b19f09084e9f1579243a5613efde8ae5aa946@65.21.199.148:26624,607dbee191f06d9479d7ae8f9fc5de75ca840d6f@185.215.167.227:31656,7617462cde13616cfc2d4c590ef099818e5f46ca@135.181.20.44:2566,0f47d3c784ab55288a780201a3f38066f702fe3a@135.181.176.109:48656,b3a25bb1cc653dfb37205b9b6e590afd66e390ad@209.18.90.20:26656,4dee73af0dfcf44523e82b7b20fcb48ffea5138c@162.19.93.127:26656,f15a7901ea4a3b318ebc196915b72c3cf54dc6d6@18.236.110.150:26656,d5f8d8b15a062817aa8ac1d4de905e1e852a81f2@194.163.148.193:2566,0b0a94003813f2bf8d891f40661ba53a6546a8c6@149.28.200.189:2566,57fc833bf73d3cac97dcf91a8e101c35e1bbb4ab@139.180.141.77:2566,d0e0ca1af09674f71101658f646175b4e17bc5ca@65.20.66.44:2566,dbb485929f41f6cd96dc7abccb65f0f9d73180a1@185.250.36.53:2566,056011f128eb099993db18c4fcdf66d19007a1e8@20.255.163.130:2566,461ddc6d315e933d5cdb0d7f6b8d413f11539d0b@159.65.155.162:2566,3136e8dbb70e15de949e70a4ed343f9a429d8584@167.99.218.248:2566,1cc290ad5c70027acbd534a13809769640fd0f6f@75.119.144.35:2566,17e0f31850ebe5db70d0bc4f153eb3378920b3b8@216.250.122.218:2566,4976b12c010b22df6bb243be4d2bac49505b6802@185.192.97.126:2566,d6f8ddbff223c5c8ef5f51ebe2490a8f0f17e25f@194.233.77.238:2566,f6153ac4a479a5ef661439ac01017a5c1f109c5e@165.232.163.114:2566,90f8b6e507488bb32cfb4465b32ea24ce7f0cedf@128.199.238.50:2566,49e67c49521e347de873c459fd0311ee17c63932@62.151.183.227:2566,e397a9fc169e7e6721a94f4fd43e0e036aeca2eb@20.163.88.92:2566,8bc9d0a9fae7047fd10a1f8d59304b0bea8b1ccd@161.97.140.6:2566,9d3e2a92c38d499ae0b891563728460d87495feb@198.71.61.63:2566,9771ae4427617b12a49680419a4cb0e15e03a4b4@185.188.249.173:2566,2b9f555e4e0fe197664ed11cd7e1a05c020e5583@178.18.247.240:2566,c9b5c9ac6758bcf5dcddd108d3fc5f7805a70f71@217.160.64.238:2566,ecd750c265d8f0854ab8dc99a1d982ad5e386715@142.132.201.130:26656,112b8bf9f2672233f2377caf76a437af0cb0ffe3@20.166.24.21:2566,15070caeafb62d2c0f27363890669cd702946d9f@161.35.60.67:2566,14f43f2c814ac0a6546956e53a08325fca5780b0@108.175.1.50:2566,fd23f238dc33ce68313cd44ccb24f0ed39b339c4@185.208.207.37:2566,6da737d895eae548dd128a32369d8fed6085c94e@104.254.247.189:2566,7237e0b01016512c4b26f11d2b73eb4e458f6292@185.215.166.204:2566,cbb624e948a4d878d9152974dbe7cb9366514efc@194.163.162.155:2566,7ec8edefd8d3ea7c0eaf5db84fa4b4f60dbb5140@128.199.218.60:2566,08762fcf6e4372653eb008637bec7fe732677b78@194.233.86.202:2566,b8b6f17a6fd4b69d198fa248e3105b93ea48d973@38.242.217.226:2566,9af946a0b5a69dfc4dc6e2ea030d84849251c104@139.180.146.130:2566,f630eb3d031148f656e8b56e60be95f09a0a2105@20.15.224.74:2566,c549997c59be890f12a9d86f89b3ccb9a858ee64@193.203.15.48:2566,89344bd087489f84873b5d245d26c5956febf4fa@103.150.196.211:2566,0f6ae49a796c21de773864b0b227f5ca6f6a60c9@38.242.138.108:2566,6b503c62b125e920d76971b52c1195d589d3fdf4@20.2.80.251:2566,5c332ecd0bffe5a6f5142a783489a1ef3f052886@142.93.205.59:2566,3c3420337d9a2e31449ecfdcb0c2e74359a707bd@134.209.104.178:2566,e6c30c9952302a257f0cbc47159a979cef477511@157.230.63.159:2566,9fa6c4f5e0f3a73a668befcde07b7dfb3119b1c4@161.35.215.48:2566,6de4b209afffb810700ac5407656ac8d0acb5d33@149.102.155.26:2566,e53e92aa6b56122517168f7a4850a14c9c7936ae@198.199.122.214:2566,bc09e5bc8a7f5a49a9c50fee927e3227e5645dcc@108.175.1.164:2566,6aae36d693c9421a88402359d27756a6f8618774@165.232.163.39:2566,45b081644640aced493058a125331493ceaf60dd@95.217.109.218:26656,7d65add543debfe636907e31dd464db05f8b01a8@185.135.137.136:2566,af75c1cebd4e67e3e0062b4906679307bdc7c74c@178.128.159.18:2566,8292a767d30eded0feac55b51159becd72b72ccd@174.138.22.89:2566,4500267f22c9208ab80c0c33b6e756112b0c5a4e@159.65.13.181:2566,57d32a4400be9145892f1b5ea08412d58a2d0960@161.97.133.62:2566,4f80657f51ccc47037694af3f5cae04ffb2b95d7@149.102.159.26:2566,57bd21f1ef48d1e44d6c1ded0d83695cb3cc76da@157.230.36.242:2566,2e3768f50014361c43e7e02a738cace6bb7ced5d@149.102.159.250:2566,9f779b69d2ba3548de5427432571e8f88f72a59a@149.102.153.60:2566,1aada59e8e6867d241c3a276dd96d3fd99c2a985@185.202.239.46:2566,8c408810c753909e1135afd4293ac60eff479b5e@165.22.18.152:2566,d69dbd23d7e0ed93eeb9f98c221e17e1c1ce6033@212.227.118.231:13656,93cbd0f1942f75cf47908d25a9beddcc6b7ab36c@194.233.85.199:2566,844996d23989daa50bbabe4b84bc14ec98aa889e@128.199.170.238:2566,b00a09236eec12427ad91e4c505f69a301ad9f06@185.197.250.215:2566,911b315ca74c1f295d1805cf713c433c6decedfd@38.242.153.15:2566,0b2113702b974e608a85ee73e1f94cbc5921fe85@149.102.129.254:2566,c1746ba47139141709629423c9d3edc1fb7659fc@165.232.145.9:2566,8e9db92c14f591a5b2fabee987259d94f7ee3293@139.59.236.118:2566,1e1f5c3ff4454d53c54dcdb8c058ab8849413e20@143.198.200.191:2566,ce7c47621a76c35cb65f88bf677f674ccc1dd4b8@188.166.59.252:2566,e0ba7dce4cb8b77fc2dc429459b437b92a4fcd02@20.255.233.110:2566,8c6d33e8f5ff6f0c4d6ea447a59741720861cbac@154.26.138.211:2566,16b680ac5b3063eb6aaf34d8244ebefb4f853c8f@185.250.36.181:2566,c8946adbfadbf57a9b19cfe8c90cd860a8af83e5@147.182.199.144:2566,2432ce2d74fb45c2b52bb89ee36da726d0111b04@209.145.57.213:2566,aaea8484c0f2596dd289ac80a6eebf5b42851599@157.230.250.84:2566,81172e99ee1056ebeb3df8227142c68d9f8c2332@185.208.207.77:2566,83e5912a538e314ca251858259b3363e41581154@185.208.207.36:2566,7b08eab2174621e1df0c12f44a9638e0e9425b99@161.35.234.36:2566,54d64f3030c9ced899159a10cbefa501cdd9c34b@38.242.130.204:2566,68e2fae4bf533ece9fc0f6e9171240b0a751155f@74.208.93.113:2566,9e4e9ac13abffdf2681575dbd2d8ec4bad181962@103.150.196.238:2566


sleep 1

echo "export LYL_WALLET=${LYL_WALLET}" >> $HOME/.bash_profile
echo "export LYL=${LYL}" >> $HOME/.bash_profile
echo "export LYL_ID=${LYL_ID}" >> $HOME/.bash_profile
echo "export LYL_PORT=${LYL_PORT}" >> $HOME/.bash_profile
echo "export LYL_FOLDER=${LYL_FOLDER}" >> $HOME/.bash_profile
echo "export LYL_FOLDER2=${LYL_FOLDER2}" >> $HOME/.bash_profile
echo "export LYL_VER=${LYL_VER}" >> $HOME/.bash_profile
echo "export LYL_REPO=${LYL_REPO}" >> $HOME/.bash_profile
echo "export LYL_GENESIS=${LYL_GENESIS}" >> $HOME/.bash_profile
echo "export LYL_PEERS=${LYL_PEERS}" >> $HOME/.bash_profile
echo "export LYL_SEED=${LYL_SEED}" >> $HOME/.bash_profile
echo "export LYL_MIN_GAS=${LYL_MIN_GAS}" >> $HOME/.bash_profile
echo "export LYL_DENOM=${LYL_DENOM}" >> $HOME/.bash_profile
source $HOME/.bash_profile

sleep 1

if [ ! $LYL_NODENAME ]; then
	read -p "Nama Node: " LYL_NODENAME
	echo 'export LYL_NODENAME='$LYL_NODENAME >> $HOME/.bash_profile
fi

echo -e "Nama Node: \e[1m\e[32m$LYL_NODENAME\e[0m"
echo -e "Nama Wallet: \e[1m\e[32m$LYL_WALLET\e[0m"
echo -e "Chain ID: \e[1m\e[32m$LYL_ID\e[0m"
echo -e "PORT: \e[1m\e[32m$LYL_PORT\e[0m"
echo '================================================='

sleep 2

echo -e "\e[1m\e[32m1. Update... \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Insall Build... \e[0m" && sleep 1
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y

echo -e "\e[1m\e[32m3. Install Go... \e[0m" && sleep 1
ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version

sleep 1

echo -e "\e[1m\e[32m4. Clone Repo... \e[0m" && sleep 1
cd $HOME
wget https://github.com/LoyalLabs/loyal/releases/download/v0.25.1/loyal_v0.25.1_linux_amd64.tar.gz
tar xzf loyal_v0.25.1_linux_amd64.tar.gz
chmod 775 loyald
sudo mv loyald /usr/local/bin/
sudo rm loyal_v0.25.1_linux_amd64.tar.gz

sleep 1

echo -e "\e[1m\e[32m5. Konfigurasi... \e[0m" && sleep 1
$LYL config chain-id $LYL_ID
$LYL config keyring-backend file
$LYL init $LYL_NODENAME --chain-id $LYL_ID

wget $LYL_GENESIS -O $HOME/$LYL_FOLDER/config/genesis.json
wget $LYL_ADDRBOOK -O $HOME/$LYL_FOLDER/config/addrbook.json

SEEDS="$LYL_SEEDS"
PEERS="$LYL_PEERS"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/$LYL_FOLDER/config/config.toml

sleep 1

# config pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$LYL_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$LYL_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$LYL_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$LYL_FOLDER/config/app.toml

sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:2${LYL_PORT}8\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:2${LYL_PORT}7\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${LYL_PORT}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:2${LYL_PORT}6\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":2${LYL_PORT}0\"%" $HOME/$LYL_FOLDER/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${LYL_PORT}7\"%; s%^address = \":8080\"%address = \":${LYL_PORT}80\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${LYL_PORT}90\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${LYL_PORT}91\"%" $HOME/$LYL_FOLDER/config/app.toml
sed -i.bak -e "s%^node = \"tcp://localhost:26657\"%node = \"tcp://localhost:2${LYL_PORT}7\"%" $HOME/$LYL_FOLDER/config/client.toml

sed -i -e "s/prometheus = false/prometheus = true/" $HOME/$LYL_FOLDER/config/config.toml

sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.000025$LYL_DENOM\"/" $HOME/$LYL_FOLDER/config/app.toml

indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/$LYL_FOLDER/config/config.toml

$LYL tendermint unsafe-reset-all --home $HOME/$LYL_FOLDER

echo -e "\e[1m\e[32m6. Mulai Service... \e[0m" && sleep 1
# create service
sudo tee /etc/systemd/system/$LYL.service > /dev/null <<EOF
[Unit]
Description=$LYL
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which $LYL) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable $LYL
sudo systemctl restart $LYL

echo '=============== Instalisasi Selesai Bang ==================='
echo -e 'Check Log Node: \e[1m\e[32mjournalctl -fu loyald -o cat\e[0m'
echo -e "\e[1m\e[31mSpecial Thanks Nodeist for Original Script <3\e[0m"
echo -e "Check Status Node: \e[1m\e[32mcurl -s localhost:${LYL_PORT}657/status | jq .result.sync_info\e[0m"

source $HOME/.bash_profile
