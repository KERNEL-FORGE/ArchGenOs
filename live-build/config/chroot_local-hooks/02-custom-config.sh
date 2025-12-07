#!/bin/sh
set -e

# --- 1. Installation du Noyau XanMod ---
# Installer le noyau XanMod (x64v3 pour les CPU modernes)
apt install -y linux-xanmod-x64v3

# --- 2. Installation des Logiciels ---
# TLauncher est un .jar, nous installons juste Java
# openjdk-17-jre est déjà dans minecraft.list

# OBS Studio est déjà dans minecraft.list
# Installation des dépendances pour le support NVENC (nécessite les pilotes NVIDIA)
# Nous allons supposer que les pilotes NVIDIA seront installés après l'installation de l'OS.
# Ajout de paquets utilitaires pour la personnalisation
apt install -y wget curl unzip xfce4-goodies

# --- 3. Thème Minecraft ---

# Téléchargement d'un thème de curseur Minecraft (exemple)
# Note: L'URL de téléchargement direct est souvent instable, nous allons simuler le téléchargement
# et créer un répertoire de thème de curseur simple pour la démonstration.
# Pour une construction réelle, il faudrait s'assurer de la persistance de l'URL ou inclure le fichier.
# Ici, nous allons juste nous assurer que le répertoire existe pour la configuration.
mkdir -p /usr/share/icons/Minecraft/cursors

# Téléchargement d'un fond d'écran Minecraft 4K (exemple)
# Utilisation d'une image générique de Minecraft pour l'exemple
WALLPAPER_URL="https://i.imgur.com/8Q8o3tZ.png" # Exemple d'image de fond d'écran Minecraft
WALLPAPER_PATH="/usr/share/backgrounds/minecraft-wallpaper.png"
wget -O "$WALLPAPER_PATH" "$WALLPAPER_URL"

# Configuration du thème par défaut pour l'utilisateur live (xfce4)
# Création du répertoire de configuration pour l'utilisateur 'user' (utilisateur par défaut de live-build)
mkdir -p /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/

# Configuration du fond d'écran
cat << EOF > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitor0" type="empty">
        <property name="workspace0" type="empty">
          <property name="last-image" type="string" value="$WALLPAPER_PATH"/>
          <property name="image-style" type="int" value="5"/>
        </property>
      </property>
    </property>
  </property>
</channel>
EOF

# Configuration du thème de curseur
cat << EOF > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Xft" type="empty">
    <property name="DPI" type="int" value="96"/>
  </property>
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="Adwaita-dark"/>
    <property name="IconThemeName" type="string" value="Adwaita"/>
    <property name="CursorThemeName" type="string" value="Minecraft"/>
    <property name="CursorThemeSize" type="int" value="24"/>
  </property>
</channel>
EOF

# --- 4. Configuration TLauncher et OBS Studio ---

# Téléchargement de TLauncher
TLAUNCHER_URL="https://tlauncher.org/jar"
TLAUNCHER_PATH="/usr/local/bin/TLauncher.jar"
wget -O "$TLAUNCHER_PATH" "$TLAUNCHER_URL"
chmod +x "$TLAUNCHER_PATH"

# Création du lanceur de bureau pour TLauncher
cat << EOF > /etc/skel/Desktop/TLauncher.desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=java -jar /usr/local/bin/TLauncher.jar
Name=TLauncher (Minecraft)
Comment=Lanceur Minecraft optimisé
Icon=minecraft
Categories=Game;
EOF

# Création du lanceur de bureau pour OBS Studio
cat << EOF > /etc/skel/Desktop/OBS-Studio.desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=obs
Name=OBS Studio (Streaming)
Comment=Logiciel de streaming et d'enregistrement optimisé
Icon=obs-studio
Categories=AudioVideo;Recorder;
EOF

# Rendre les lanceurs exécutables
chmod +x /etc/skel/Desktop/TLauncher.desktop
chmod +x /etc/skel/Desktop/OBS-Studio.desktop

# Nettoyage
rm -rf /var/lib/apt/lists/*

exit 0
