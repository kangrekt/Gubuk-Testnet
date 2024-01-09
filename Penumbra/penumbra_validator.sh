#!/bin/bash

# Установка jq для обработки JSON
sudo apt install -y jq

# Проверка статуса синхронизации ноды
SYNC_STATUS=$(curl -s http://0.0.0.0:26657/status | jq .result.sync_info.catching_up)
if [ "$SYNC_STATUS" = "true" ]; then
    echo "Your node is not synchronized. Please wait until it is fully synced before proceeding."
    exit 1
fi

# Переход в директорию Penumbra
cd /root/penumbra

# Создание файла validator.toml
./target/release/pcli validator definition template \
    --tendermint-validator-keyfile ~/.penumbra/testnet_data/node0/cometbft/config/priv_validator_key.json \
    --file validator.toml

# Запрос имени валидатора
echo "Enter the name of your validator:"
read NAMA_VALIDATOR

# Обновление файла validator.toml
sed -i "s/enabled = false/enabled = true/" validator.toml
sed -i "s/name = \".*\"/name = \"$NAMA_VALIDATOR\"/" validator.toml

# Загрузка определения валидатора
./target/release/pcli validator definition upload --file validator.toml

# Получение и вывод на экран идентификатора валидатора
VALIDATOR_IDENTITY=$(./target/release/pcli validator identity)
echo "Validator identity: $VALIDATOR_IDENTITY"
