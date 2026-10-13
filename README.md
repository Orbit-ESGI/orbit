# ORBIT — Plateforme cloud souveraine, hybride et Zero Trust

Projet annuel — 3ᵉ année Bachelor Systèmes, Réseaux & Cloud Computing — ESGI Reims (2026-2027).
Objectif : 20/20, avec un niveau technique type mastère.

## Pitch
Une plateforme qui déploie des applications sur plusieurs sites (école, serveur perso, VPS),
de façon automatisée (GitOps), sécurisée de bout en bout (supply chain + Zero Trust),
et qui survit à la perte complète d'un site sans intervention humaine.

## Contraintes
- **Budget : 0 €.** Uniquement des ressources gratuites ou déjà disponibles.
- Infra disponible : VM sur le Proxmox de l'école, un serveur prêté par l'entreprise d'alternance (hébergé à domicile), un VPS OVH.

## Équipe (3 personnes)
| Rôle | Périmètre |
|---|---|
| **Réseau & sécurité réseau** | WireGuard, Cilium + ClusterMesh, Network Policies L7, Hubble, Tetragon/Falco, DNS Cloudflare |
| **Infra & résilience** | Proxmox, OpenTofu, Ansible, clusters K8s, CloudNativePG, Velero/MinIO, PRA, Chaos Mesh, mesures RTO/RPO |
| **DevSecOps & plateforme** | GitLab CI, Trivy/Syft/Cosign, Harbor, Kyverno, ArgoCD, Vault, Keycloak, observabilité/SLO |

Chaque membre doit pouvoir expliquer l'ensemble du projet en soutenance.

## Organisation du dépôt
```
orbit/
├── infra/              Couche 0 : OpenTofu (créer) + Ansible (configurer)
│   ├── terraform/      modules/ + envs/ (site-a-ecole, site-b-domicile, dns-cloudflare)
│   └── ansible/        inventaire par site, playbooks, rôles
├── kubernetes/         Couches 1 à 7, déployées par ArgoCD (GitOps)
│   ├── bootstrap/      ArgoCD (seule installation manuelle)
│   ├── platform/       Cilium, cert-manager, Kyverno, Vault, monitoring, CloudNativePG...
│   ├── apps/           application de démo
│   └── clusters/       spécificités site-a / site-b
├── ci/                 modèles de jobs GitLab CI (supply chain)
├── tests/              chaos engineering + mesures RTO/RPO/SLO
├── scripts/            utilitaires
└── docs/               architecture, ADR, runbooks, schémas, soutenance
```

## Démarrage rapide
Voir [docs/setup-poste.md](docs/setup-poste.md), puis `make help`.

## Documentation
- [Architecture](docs/architecture.md)
- [Stack technique](docs/stack.md)
- [Décisions d'architecture (ADR)](docs/adr/)
- [Questions ouvertes / à vérifier](docs/questions-ouvertes.md)
- [Préparer son poste](docs/setup-poste.md)
