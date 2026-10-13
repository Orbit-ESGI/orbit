# Runbook — Ajouter un pair WireGuard (site ou poste d'admin)

Plan d'adressage : voir [ADR 0005](../adr/0005-reseau-overlay-wireguard.md).

## 1. Sur le nouveau pair : générer sa clé (elle ne quitte jamais la machine)
```bash
sudo apt install wireguard-tools
umask 077
wg genkey | sudo tee /etc/wireguard/wg0.key | wg pubkey   # affiche la clé PUBLIQUE
```
Pour une machine gérée par Ansible (passerelle de site), le rôle `wireguard` fait cette étape tout seul.

## 2. Déclarer le pair dans l'inventaire (via une pull request)
Dans `infra/ansible/inventories/prod/group_vars/site_c_vps.yml` :
```yaml
wireguard_pairs:
  - nom: site-a-passerelle
    cle_publique: "<clé publique du pair>"
    allowed_ips: [10.200.0.10/32, 10.10.0.0/16]   # IP dans le tunnel + LAN annoncé
```

## 3. Appliquer sur le hub
```bash
make vps-check   # vérifier ce qui va changer
make vps         # appliquer (le tunnel du hub redémarre quelques secondes)
```

## 4. Configurer le pair
`/etc/wireguard/wg0.conf` du pair (clé publique du hub : `make vps` l'affiche, ou `sudo wg show` sur le VPS) :
```ini
[Interface]
Address = 10.200.0.10/24
PostUp = wg set %i private-key /etc/wireguard/%i.key

[Peer]
PublicKey = <clé publique du hub>
Endpoint = 217.182.253.181:51820
AllowedIPs = 10.200.0.0/24, 10.20.0.0/16   # overlay + LAN de l'autre site
PersistentKeepalive = 25
```
Puis `sudo systemctl enable --now wg-quick@wg0`.

## 5. Vérifier
```bash
ping -c 3 10.200.0.1      # depuis le pair
sudo wg show              # sur le hub : "latest handshake" récent pour le pair
```

## Retirer un pair
Supprimer son entrée dans l'inventaire, PR, `make vps`. Sa clé n'est plus acceptée immédiatement.
