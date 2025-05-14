#!/bin/bash

# Variables Centreon API
#CENTREON_URL="http://localhost/centreon"
#USERNAME="admin"
#PASSWORD="motdepasse"

# Veuillez changer les paramètres de l'hôte à créer
#HOST_NAME="serveur-test"
#HOST_ALIAS="Serveur Test"
#HOST_IP="192.168.1.100"
#TEMPLATE="generic-host"

# Récupération du token
TOKEN=$(curl -s -X POST -d "username=${USERNAME}&password=${PASSWORD}" ${CENTREON_URL}/api/index.php?ac>
if [[ "$TOKEN" == "null" || -z "$TOKEN" ]]; then
  echo "❌ Échec de l'authentification à l'API Centreon"
  exit 1
fi

echo "🔐 Authentification réussie"

# Création de l’hôte
curl -s -X POST -H "Content-Type: application/json" -H "centreon-auth-token: $TOKEN" \
    -d "{\"name\": \"${HOST_NAME}\", \"alias\": \"${HOST_ALIAS}\", \"address\": \"${HOST_IP}\", \"templ>    ${CENTREON_URL}/api/latest/configuration/hosts

echo "✅ Hôte $HOST_NAME ajouté"
