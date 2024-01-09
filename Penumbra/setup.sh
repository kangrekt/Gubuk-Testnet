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
echo "==================================================================="                                    "

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

echo "       OK LANJOOOOOOOOOOOOOOTTTT                  "