echo -e "\e[0m"
echo "==================================================================="

echo -e '\e[36mGarapan :\e[39m' Planq Testnet
echo -e '\e[36mTwitter :\e[39m' @igot_rug
echo "======================================="

sleep 2

# set vars
if [ ! $NODENAME ]; then
	read -p "Enter node name: " NODENAME
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
PLANQ_PORT=41
if [ ! $WALLET ]; then
	echo "export WALLET=wallet" >> $HOME/.bash_profile
fi
echo "export CHAIN_ID=planq_7070-2" >> $HOME/.bash_profile
echo "export PLANQ_PORT=${PLANQ_PORT}" >> $HOME/.bash_profile
source $HOME/.bash_profile

echo '================================================='
echo -e "Your node name: \e[1m\e[32m$NODENAME\e[0m"
echo -e "Your wallet name: \e[1m\e[32m$WALLET\e[0m"
echo -e "Your chain name: \e[1m\e[32m$CHAIN_ID\e[0m"
echo -e "Your port: \e[1m\e[32m$PLANQ_PORT\e[0m"
echo '================================================='
sleep 2

echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 1
# update
sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
# packages
sudo apt install curl build-essential git wget jq make gcc tmux chrony -y

# install go
if ! [ -x "$(command -v go)" ]; then
  ver="1.19.4"
  cd $HOME
  wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
  rm "go$ver.linux-amd64.tar.gz"
  echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
  source ~/.bash_profile
fi

# install go
apt install make

echo -e "\e[1m\e[32m3. Downloading and building binaries... \e[0m" && sleep 1
# download and build binaries
cd $HOME && rm -rf planq
git clone https://github.com/planq-network/planq.git && cd planq
cd planq
git fetch
git checkout main 
make install

# config
planqd config chain-id $CHAIN_ID
planqd config keyring-backend test
planqd config node tcp://localhost:${PLANQ_PORT}657

# init
planqd init $NODENAME --chain-id planq_7070-2

# download genesis and addrbook
SNAP_RPC1="http://bd-evmos-mainnet-state-sync-us-01.bdnodes.net:26657"
SNAP_RPC="http://bd-evmos-mainnet-state-sync-eu-01.bdnodes.net:26657"
CHAIN_ID="planq_7070-2"
PEER="96557e26aabf3b23e8ff5282d03196892a7776fc@bd-evmos-mainnet-state-sync-us-01.bdnodes.net,dec587d55ff38827ebc6312cedda6085c59683b6@bd-evmos-mainnet-state-sync-eu-01.bdnodes.net"
wget -O $HOME/genesis.json https://raw.githubusercontent.com/planq-network/networks/main/mainnet/genesis.json 


# set peers and seeds
SEEDS=`curl -sL https://raw.githubusercontent.com/planq-network/networks/main/mainnet/seeds.txt | awk '{print $1}' | paste -s -d, -`
PEERS=`curl -sL https://raw.githubusercontent.com/planq-network/networks/main/mainnet/peers.txt | sort -R | head -n 10 | awk '{print $1}' | paste -s -d, -`

sed -i.bak -e "s/^seeds =.*/seeds = \"$SEEDS\"/" ~/.planqd/config/config.toml
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" ~/.planqd/config/config.toml

# set custom ports
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${PLANQ_PORT}658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${PLANQ_PORT}657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${PLANQ_PORT}060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${PLANQ_PORT}656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${PLANQ_PORT}660\"%" $HOME/.planqd/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${PLANQ_PORT}317\"%; s%^address = \":8080\"%address = \":${PLANQ_PORT}080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${PLANQ_PORT}090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${PLANQ_PORT}091\"%; s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:${PLANQ_PORT}545\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:${PLANQ_PORT}546\"%" $HOME/.planqd/config/app.toml

# config pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.planqd/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.planqd/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.planqd/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.planqd/config/app.toml

# set minimum gas price and timeout commit
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0utlore\"/" $HOME/.planqd/config/app.toml

# enable prometheus
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.planqd/config/config.toml

# reset
plangd tendermint unsafe-reset-all --home $HOME/.planqd

echo -e "\e[1m\e[32m4. Starting service... \e[0m" && sleep 1
# create service
sudo tee /etc/systemd/system/planqd.service > /dev/null <<EOF
[Unit]
Description=Planqd Node
After=network.target
#
[Service]
User=$USER
Type=simple
ExecStart=$(which planqd) start
Restart=on-failure
LimitNOFILE=65535
#
[Install]
WantedBy=multi-user.target" > $HOME/planqd.service; sudo mv $HOME/planqd.service /etc/systemd/system/

sudo systemctl enable planqd.service && sudo systemctl daemon-reload


# start service
sudo systemctl daemon-reload
sudo systemctl enable planqd
sudo systemctl restart planqd

sytemctl start planqd

journalctl -u planqd -f

