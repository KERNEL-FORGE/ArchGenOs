#!/bin/sh
set -e

# Ajouter la clé GPG du dépôt XanMod
wget -O /etc/apt/keyrings/xanmod-archive-keyring.gpg https://dl.xanmod.org/archive-keyring.gpg
chmod 644 /etc/apt/keyrings/xanmod-archive-keyring.gpg

# Mettre à jour la liste des paquets
apt update

exit 0
