# ADR 0005 — Réseau overlay WireGuard en étoile et plan d'adressage

- **Statut** : accepté
- **Date** : 2026-10-13

## Contexte
Les sites A (école) et B (domicile) sont derrière du NAT : aucun port entrant n'est garanti.
Seul le VPS (site C) a une IP publique fixe. Les trois sites doivent pourtant se joindre
de façon chiffrée (ClusterMesh, réplication PostgreSQL, sauvegardes croisées, témoin).

## Options
1. **Maillage complet WireGuard** (chaque site parle à chaque site) : impossible sans port entrant sur A et B.
2. **Étoile (hub-and-spoke) WireGuard natif, hub sur le VPS** : A et B ouvrent un tunnel *sortant* vers le VPS.
3. **Tailscale / Headscale / Netmaker** : maillage automatique avec traversée de NAT, mais une brique de
   plus à opérer (ou un service tiers), et moins pédagogique.

## Décision
Option 2, configurée par le rôle Ansible `wireguard` (`make vps`).

| Réseau | Plage | Remarque |
|---|---|---|
| Overlay WireGuard | `10.200.0.0/24` | `.1` hub (VPS), `.10` passerelle site A, `.20` passerelle site B, `.100`–`.199` postes d'admin |
| LAN des VM site A | `10.10.0.0/16` | à confirmer avec l'admin Proxmox de l'école |
| LAN des VM site B | `10.20.0.0/16` | bridge Proxmox interne, NATé derrière la box |
| Pods / services K8s site A | `10.42.0.0/16` / `10.43.0.0/16` | doivent être **uniques** entre clusters (exigence ClusterMesh) |
| Pods / services K8s site B | `10.44.0.0/16` / `10.45.0.0/16` | |
| À éviter | `172.17.0.0/16`, `172.18.0.0/16`, `192.168.0.0/16` | réseaux Docker du VPS, box internet |

Règles de sécurité :
- **La clé privée est générée sur chaque machine et n'en sort jamais** (ni Git, ni Ansible, ni journaux) ;
  wg-quick la charge via `PostUp`. Seules les clés publiques sont dans l'inventaire.
- Chaque pair n'est autorisé que pour ses propres plages (`AllowedIPs`) : un site ne peut pas usurper l'autre.
- Les pairs derrière NAT envoient un keepalive toutes les 25 s pour garder le tunnel ouvert.

## Conséquences
- + Aucun port à ouvrir sur le réseau de l'école ni sur la box ; seul UDP 51820 est ouvert sur le VPS.
- + Un nouveau site = une entrée dans l'inventaire (clé publique + plages), puis `make vps`.
- − **Le VPS devient un point de passage obligé entre A et B.** S'il tombe, A et B ne se voient plus :
  ClusterMesh et la réplication s'arrêtent, et sans le témoin aucun site n'a la majorité.
  Comportement voulu : le primaire (A) continue de servir, aucune bascule automatique n'a lieu
  (pas de split-brain). Piste d'amélioration : un tunnel direct A↔B de secours si un port peut être
  ouvert sur la box du site B (voir questions ouvertes).
- − Si l'école bloque l'UDP sortant, il faudra encapsuler WireGuard dans TCP 443 (ex. `udp2raw`, `wstunnel`).
