# Architecture ORBIT

## Les 3 sites

| Site | Matériel | Rôle |
|---|---|---|
| **A — École** | VM sur le Proxmox ESGI | Site principal : cluster K8s HA (3 nœuds), outils de gestion (ArgoCD, Vault, Keycloak, Harbor) |
| **B — Domicile** | Serveur prêté par l'alternance, sous Proxmox | Site de secours (PRA) : cluster K8s secondaire, réplique PostgreSQL, sauvegardes MinIO du site A |
| **C — VPS OVH** | VPS public | Point d'entrée public (ingress / reverse proxy), hub WireGuard, **témoin (witness)** pour le quorum |

Trois sites = un vrai quorum : en cas de coupure réseau entre A et B, le témoin C tranche
et évite le split-brain (deux bases qui se croient primaires en même temps).

## Réseau
- Les sites A et B sont derrière du NAT (réseau école, box internet) : ils ouvrent un tunnel
  **WireGuard sortant** vers le VPS (topologie hub-and-spoke). Aucun port entrant à ouvrir.
- Cilium ClusterMesh relie les clusters K8s A et B à travers ce tunnel.
- Le trafic public arrive sur le VPS puis est routé vers le site actif.

## Flux de déploiement
1. `git push` sur gitlab.com
2. Runner CI auto-hébergé : build → scan Trivy → SBOM → signature Cosign → push Harbor
3. ArgoCD (ApplicationSets) déploie sur les clusters A et B
4. Kyverno refuse toute image non signée

## Résilience
- PostgreSQL via CloudNativePG : primaire sur A, réplique sur B.
- Sauvegardes croisées : Velero + MinIO (A sauvegarde sur B, B sauvegarde sur A).
- Chaos engineering (Chaos Mesh) et mesure réelle du RTO / RPO.

## Limites connues
- **Le VPS est un point de défaillance unique pour l'entrée publique.**
  Atténuation possible et gratuite : Cloudflare Tunnel depuis A et B (voir ADR 0002),
  au prix d'une dépendance à un acteur américain (à argumenter vis-à-vis de la souveraineté).
- Le serveur domicile dépend de la box internet (IP dynamique, coupures possibles).
