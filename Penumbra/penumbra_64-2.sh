#!/bin/bash

# Display ASCII logo with text "nodes.bond"
echo  "   _    _                   __ _                  "
echo  "  | |  / /                 |  _ \                 "
echo  "  | |_/ / __ _ _ __   __ _ | |_) |___ _   _| |_   " 
echo  "  |  _ < / _' | '_ \ / _' ||   _// _ \ |/ /|  __/ "
echo  "  | | \ \ (_| | | | | (_| || |\ \  __/   < | |    "
echo  "  |_|  \_\__,_|_| |_|\__, ||_| \_\___|_|\_\ \__\  "
echo  "                     |___/                        "
echo "       nodes.bond                  "
echo "                                   "

# Update package list and install dependencies
sudo apt-get update
sudo apt-get install -y build-essential pkg-config libssl-dev clang git-lfs tmux libclang-dev curl

# Install Go
GO_VERSION="1.18"
wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -xvf go${GO_VERSION}.linux-amd64.tar.gz
sudo mv go /usr/local

# Set Go environment variables
echo "export GOROOT=/usr/local/go" >> $HOME/.profile
echo "export GOPATH=$HOME/go" >> $HOME/.profile
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> $HOME/.profile
source $HOME/.profile

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Clone Penumbra repository and checkout the specified version
git clone https://github.com/penumbra-zone/penumbra
cd penumbra
git fetch
git checkout v0.64.1

# Build pcli and pd
cargo build --release --bin pcli
cargo build --release --bin pd

# Install CometBFT
cd ..
git clone https://github.com/cometbft/cometbft.git
cd cometbft
git checkout v0.37.2

# Update Go modules
go mod tidy

# Proceed with installation
make install
cd ..

# Request node name from the user
echo "NAMA NODEMU:"
read MY_NODE_NAME

# Retrieve the external IP address of the server
IP_ADDRESS=$(curl -s ifconfig.me)

# Join the testnet
cd penumbra
./target/release/pd testnet unsafe-reset-all
./target/release/pd testnet join --external-address $IP_ADDRESS:26656 --moniker $MY_NODE_NAME

# Create a new wallet or restore an existing one
echo "Wallet new/restore? Untuk buat baru ketikan 'new' untuk Restore ketikan 'restore' (TANPA KUTIP)"
read WALLET_CHOICE

if [ "$WALLET_CHOICE" = "new" ]; then
    ./target/release/pcli init soft-kms generate
elif [ "$WALLET_CHOICE" = "restore" ]; then
    ./target/release/pcli init soft-kms import-phrase
    echo "Enter your seed phrase:"
    read SEED_PHRASE
    echo $SEED_PHRASE | ./target/release/pcli init soft-kms import-phrase
else
    echo "Invalid choice. Exiting."
    exit 1
fi

# Launch the node and CometBFT in tmux
echo "       OK LANJOOOOOOOOOOOOOOTTTT                  "
