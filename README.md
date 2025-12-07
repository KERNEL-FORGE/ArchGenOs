# ArchGenOS

ArchGenOS est une distribution Arch Linux légère, moderne et prête à l'emploi, conçue pour offrir une expérience de bureau fluide et personnalisable avec le compositeur Wayland [Hyprland](https://hyprland.org/).

Ce dépôt contient tout le nécessaire pour construire l'image ISO d'ArchGenOS. La compilation est automatisée à l'aide de GitHub Actions, mais peut également être effectuée manuellement.

![Logo_ArchGenOS](Logo_ArchGenOS.jpg)  <!-- L'utilisateur devra ajouter cette image -->

## Fonctionnalités

*   **Bureau Hyprland :** Un compositeur Wayland dynamique et extensible avec des animations fluides.
*   **Léger et rapide :** Basé sur Arch Linux, le système est minimal et réactif.
*   **Prêt à l'emploi :** Inclut un ensemble d'applications et de configurations par défaut pour une expérience de bureau complète dès le premier démarrage.
*   **Compilation automatisée :** L'ISO est automatiquement compilé via GitHub Actions à chaque `push` sur la branche `main`.

## Compilation

### Via GitHub Actions (recommandé)

1.  Faites un `fork` de ce dépôt.
2.  Activez les "Actions" dans les paramètres de votre dépôt forké.
3.  Effectuez un `push` sur la branche `main` de votre dépôt (par exemple, en modifiant ce README).
4.  L'action de compilation se déclenchera. Une fois terminée, vous pourrez télécharger l'image ISO directement depuis l'onglet "Actions" en tant qu'artefact de build.

### Manuellement (sur un système Arch Linux)

1.  **Installer `archiso` :**
    ```bash
    sudo pacman -S archiso
    ```

2.  **Cloner le dépôt :**
    ```bash
    git clone https://github.com/VOTRE_NOM/archgenos.git
    cd archgenos
    ```

3.  **Lancer la compilation :**
    ```bash
    sudo mkarchiso -v -w /tmp/archiso-work -o out/ ./archiso
    ```

4.  L'image ISO compilée sera disponible dans le répertoire `out/`.

## Personnalisation

La personnalisation de la distribution se fait en modifiant les fichiers du profil `archiso/`.

*   **Ajouter/Supprimer des paquets :** Modifiez le fichier `archiso/packages.x86_64`.
*   **Modifier les configurations par défaut :** Les fichiers de configuration pour Hyprland, Kitty, Waybar, etc., se trouvent dans `archiso/airootfs/etc/skel/.config/`. Ces fichiers sont copiés dans le répertoire personnel de l'utilisateur live.
*   **Changer l'identité de la distribution :** Le nom, la version et d'autres métadonnées de l'ISO peuvent être modifiés dans `archiso/profiledef.sh`.
*   **Modifier le logo de démarrage :** Remplacez les fichiers `splash.jpg` dans `archiso/isolinux/` et `archiso/efiboot/grub/` par votre propre image.
*   **Scripts d'installation :** Pour des configurations plus avancées (par exemple, la création d'utilisateurs, la configuration de services), vous pouvez créer des scripts et les exécuter depuis `archiso/airootfs/root/customize_airootfs.sh` (ce fichier doit être créé).

## Licence

Ce projet est sous licence MIT.


---

# ArchGenOS - Édition Minecraft & Streaming (Xubuntu)

Cette branche contient une édition spéciale **Minecraft & Streaming** d'ArchGenOS, basée sur **Xubuntu 24.04 LTS**.

## 🚀 Fonctionnalités Clés

| Catégorie | Fonctionnalité | Description |
| :--- | :--- | :--- |
| **Base Système** | Xubuntu 24.04 LTS | Stabilité à long terme (LTS) d'Ubuntu avec l'environnement de bureau léger XFCE pour des performances maximales. |
| **Performance** | Noyau XanMod | Un noyau Linux optimisé pour les jeux et les charges de travail à faible latence, améliorant la réactivité du système et les FPS en jeu. |
| **Gaming** | TLauncher Préinstallé | Le lanceur Minecraft populaire est préinstallé avec le JRE (Java Runtime Environment) requis pour un lancement immédiat. |
| **Streaming** | OBS Studio Préinstallé | Le logiciel de capture et de diffusion est inclus, avec les dépendances nécessaires pour l'encodage matériel (NVENC/VAAPI) si les pilotes sont installés. |
| **Esthétique** | Thème Minecraft | Personnalisation visuelle incluant un fond d'écran 4K sur le thème Minecraft et un thème de curseur pixelisé. |

## 🛠️ Processus de Construction

Cette distribution est construite à l'aide de l'outil **`live-build`** de Debian/Ubuntu. Tous les fichiers de configuration se trouvent dans le répertoire `live-build/`.

### 1. Construction Automatique (Recommandé)

Le moyen le plus simple de générer l'image ISO est d'utiliser la **GitHub Action** configurée dans ce dépôt.

1.  **Déclenchement :** Le workflow se lance automatiquement à chaque *push* sur la branche `feature/minecraft-distro`.
2.  **Suivi :** Rendez-vous dans l'onglet **Actions** de ce dépôt pour suivre la progression de la construction.
3.  **Téléchargement :** Une fois la construction terminée, l'image ISO sera disponible en téléchargement dans la section **Artifacts** du workflow sous le nom `minecraft-live-iso`.

### 2. Construction Manuelle

Pour construire l'ISO localement, vous devez disposer d'une machine Linux (Ubuntu/Debian) avec `live-build` installé.

1.  **Cloner le dépôt :**
    ```bash
    git clone https://github.com/KERNEL-FORGE/ArchGenOs.git
    cd ArchGenOs/live-build
    ```
2.  **Installer les dépendances :**
    ```bash
    sudo apt update
    sudo apt install live-build debootstrap git wget curl
    ```
3.  **Lancer la construction :**
    ```bash
    sudo lb build
    ```
    L'image ISO finale (`live-image-amd64.hybrid.iso`) sera générée dans le répertoire `live-build/`.

## ⚙️ Détails de la Configuration

Les scripts de personnalisation se trouvent dans `live-build/config/chroot_local-hooks/`:

*   **`01-xanmod-key.sh`** : Ajoute la clé GPG du dépôt XanMod.
*   **`02-custom-config.sh`** :
    *   Installe le noyau `linux-xanmod-x64v3`.
    *   Télécharge et configure le fond d'écran et le thème de curseur Minecraft.
    *   Télécharge le `TLauncher.jar` et crée les lanceurs de bureau pour TLauncher et OBS Studio.

## 📝 Utilisation de l'ISO

1.  **Créer une clé USB bootable :** Utilisez un outil comme Balena Etcher ou Rufus pour écrire l'image ISO sur une clé USB.
2.  **Démarrer :** Démarrez votre ordinateur à partir de la clé USB.
3.  **Session Live :** La distribution démarrera directement dans une session Live XFCE. Vous y trouverez les lanceurs TLauncher et OBS Studio sur le bureau, prêts à l'emploi.
4.  **Installation :** L'installeur standard d'Ubuntu est inclus pour une installation permanente sur votre disque dur.

---
*Auteur : Manus AI*
*Dépôt : [KERNEL-FORGE/ArchGenOs](https://github.com/KERNEL-FORGE/ArchGenOs)*
