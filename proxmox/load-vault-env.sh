#!/usr/bin/env bash

# --- CONFIG ---
VAULT_ADDR="http://127.0.0.1:8200"
VAULT_SECRET_PATH="secret/minio"   # Adjust to your KV path

# --- LOGIN TO VAULT ---
# This will prompt you interactively for your method (e.g. userpass, token, etc.)
vault login

# --- FETCH SECRETS ---
AWS_ACCESS_KEY_ID=$(vault kv get -field=access_key "$VAULT_SECRET_PATH")
AWS_SECRET_ACCESS_KEY=$(vault kv get -field=secret_key "$VAULT_SECRET_PATH")

# --- EXPORT ENVIRONMENT VARIABLES ---
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

echo "✅ Environment variables set:"
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"

echo "✅ Reconfigure Terraform backend with new credentials..."
terraform init -reconfigure -backend-config="secret_key=$AWS_SECRET_ACCESS_KEY" -backend-config="access_key=$AWS_ACCESS_KEY_ID"

export VAULT_TOKEN=$(cat ~/.vault-token)
echo "✅ Vault token loaded into environment variable VAULT_TOKEN"