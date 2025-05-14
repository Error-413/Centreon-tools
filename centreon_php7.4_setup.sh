#!/bin/bash

# Vérification des privilèges root
if [[ $EUID -ne 0 ]]; then
  echo "Ce script doit être exécuté en tant que root"
  exit 1
fi

echo "🚧 Suppression de PHP 8.2..."
a2dismod php8.2
apt purge -y php8.2*

echo "🔄 Mise à jour des dépôts..."
apt update

echo "📦 Installation des dépôts pour PHP 7.4..."
apt install -y software-properties-common
add-apt-repository ppa:ondrej/php -y
apt update

echo "📦 Installation de PHP 7.4 et ses modules..."
apt install -y php7.4 php7.4-cli php7.4-fpm php7.4-mysql php7.4-snmp php7.4-xml php7.4-mbstring php7.4->
echo "🔁 Activation de PHP 7.4 dans Apache..."
a2enmod php7.4
systemctl restart apache2

echo "✅ PHP 7.4 installé et activé avec succès."
php -v
