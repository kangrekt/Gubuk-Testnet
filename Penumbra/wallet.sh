# Install CometBFT
cd ..
git clone https://github.com/cometbft/cometbft.git
cd cometbft
git checkout v0.38.2

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
echo "MAU BUAT WALLET BARU/IMPORT? Tulis => 'new' atau 'restore' <="
read WALLET_CHOICE

if [ "$WALLET_CHOICE" = "BARU" ]; then
    ./target/release/pcli init soft-kms generate
elif [ "$WALLET_CHOICE" = "restore" ]; then
    ./target/release/pcli init soft-kms import-phrase
    echo "Enter Phrase:"
    read SEED_PHRASE
    echo $SEED_PHRASE | ./target/release/pcli init soft-kms import-phrase
else
    echo "Invalid choice. Exiting."
    exit 1
fi

# Launch the node and CometBFT in tmux
tmux new-session -d -s penumbra './target/release/pd start'
tmux split-window -h 'cometbft start --home ~/.penumbra/testnet_data/node0/cometbft'
tmux attach -t penumbra