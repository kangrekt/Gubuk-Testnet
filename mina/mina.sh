echo -e '\e[36mGarapan :\e[39m' Mina Protocol Testnet
echo -e '\e[36mTwitter :\e[39m' @igot_rug
echo "======================================="

sleep 2

echo -e "\e[1m\e[32m1. Allow Port... \e[0m" && sleep 1
ufw allow 22 && ufw allow 3000
ufw enable -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
# packages
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

# Install Nodejs
sudo apt install -y nodejs

echo -e "\e[1m\e[32m2. Installing zkapp-cli... \e[0m" && sleep 1
# Install zkapp-cli
git clone https://github.com/o1-labs/zkapp-cli

# instal -g zkapp-cli
npm instal -g zkapp-cli@0.5.3
