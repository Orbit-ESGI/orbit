# Préparer son poste (Windows)

## 1. WSL2 (une fois, PowerShell administrateur)
```powershell
wsl --install -d Ubuntu
```
Redémarrer, puis ouvrir « Ubuntu » et créer son utilisateur.

## 2. Outils (dans Ubuntu / WSL2)
```bash
sudo apt update && sudo apt install -y git make python3-pip pipx
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc && exec bash
```

## 3. Cloner le dépôt et installer les outils du projet
```bash
git clone git@gitlab.com:<groupe>/orbit.git && cd orbit
mise trust && make outils
```

## 4. Clé SSH dédiée au projet
```bash
ssh-keygen -t ed25519 -C "prenom@orbit" -f ~/.ssh/orbit_ed25519
```
Ajouter la clé publique (`~/.ssh/orbit_ed25519.pub`) dans GitLab → Preferences → SSH Keys.

## 5. Vérifier
```bash
make help
make lint
```
