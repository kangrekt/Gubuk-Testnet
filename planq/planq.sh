# set vars
if [ ! $NODENAME ]; then
	read -p "Enter node name: " NODENAME
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
PLANQ_PORT=12
if [ ! $WALLET ]; then
	echo "export WALLET=wallet" >> $HOME/.bash_profile
fi
echo "export PLANQ_CHAIN_ID=planq_7070-2" >> $HOME/.bash_profile
echo "export PLANQ_PORT=${PLANGQ_PORT}" >> $HOME/.bash_profile
source $HOME/.bash_profile

echo '================================================='
echo -e "Your node name: \e[1m\e[32m$NODENAME\e[0m"
echo -e "Your wallet name: \e[1m\e[32m$WALLET\e[0m"
echo -e "Your chain name: \e[1m\e[32m$PLANQ_CHAIN_ID\e[0m"
echo -e "Your port: \e[1m\e[32m$PLANQ_PORT\e[0m"
echo '================================================='
sleep 2

sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
# packages
sudo apt install curl build-essential git wget jq make gcc tmux -y

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
go version

echo -e "\e[1m\e[32m3. Downloading and building binaries... \e[0m" && sleep 1
# download binary
cd $HOME
git clone https://github.com/planq-network/planq.git && cd planq
git fetch
git checkout main
make install 

# config
planqd config chain-id planq_7070-2

# init
plangd init $NODENAME --chain-id planq_7070-2

# download genesis and addrbook
wget https://raw.githubusercontent.com/planq-network/networks/main/mainnet/genesis.json
mv genesis.json ~/.planqd/config/

# set seeds and peers
SEEDS=`curl -sL https://raw.githubusercontent.com/planq-network/networks/main/mainnet/seeds.txt | awk '{print $1}' | paste -s -d, -`
PEERS=`curl -sL https://raw.githubusercontent.com/planq-network/networks/main/mainnet/peers.txt | sort -R | head -n 10 | awk '{print $1}' | paste -s -d, -`

sed -i.bak -e "s/^seeds =.*/seeds = \"$SEEDS\"/" ~/.planqd/config/config.toml
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" ~/.planqd/config/config.toml

# reset
planqd tendermint unsafe-reset-all --home $HOME/.planqd

echo -e "\e[1m\e[32m4. Starting service... \e[0m" && sleep 1
# create service
echo "[Unit]
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


# start service
sudo systemctl daemon-reload
sudo systemctl enable planqd
sudo systemctl restart plangd

echo '=============== SETUP FINISHED ==================='
echo -e 'To check logs: \e[1m\e[32mjournalctl -u planqd -f\e[0m'
echo -e "To check sync status: \e[1m\e[32mstatus 2>&1 | jq .SyncInfo\e[0m"
