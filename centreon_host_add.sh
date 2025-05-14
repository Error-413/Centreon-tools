#!/bin/bash

# ============================
# Configuration API Centreon
# ============================
CENTREON_URL="http://localhost/centreon"
USERNAME="admin"
PASSWORD="centreon"

# ============================
# Paramètres de l’hôte à créer
# ============================
HOST_NAME="serveur-test"
HOST_ALIAS="Serveur Test"
HOST_IP="192.168.1.100"
TEMPLATE="generic-host"

# ============================
# Récupération du token Centreon
# ============================
TOKEN=$(curl -s -X POST "${CENTREON_URL}/api/index.php?action=authenticate" \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"$USERNAME\", \"password\": \"$PASSWORD\"}" | jq -r '.authToken')

if [[ "$TOKEN" == "null" || -z "$TOKEN" ]]; then
  echo "❌ Échec de l'authentification à l'API Centreon"
  exit 1
fi

echo "🔐 Authentification réussie"

# ============================
# Création de l’hôte
# ============================
curl -s -X POST "${CENTREON_URL}/api/latest/configuration/hosts" \
  -H "Content-Type: application/json" \
  -H "centreon-auth-token: ${TOKEN}" \
  -d "{
        \"name\": \"$HOST_NAME\",
        \"alias\": \"$HOST_ALIAS\",
        \"address\": \"$HOST_IP\",
        \"templates\": [\"$TEMPLATE\"]
      }"

echo "✅ Hôte $HOST_NAME ajouté avec succès"
