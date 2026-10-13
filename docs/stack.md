# Stack technique (couches)

| Couche | Rôle | Outils |
|---|---|---|
| 0 — Socle & IaC | Créer et configurer les VM de façon reproductible | Proxmox, OpenTofu/Terraform (provider bpg/proxmox), Ansible |
| 1 — Kubernetes | Clusters multi-sites | k3s ou RKE2 (HA etcd 3 nœuds sur le site A) |
| 2 — Réseau | CNI eBPF, multi-cluster, chiffrement, policies L7 | Cilium, ClusterMesh, WireGuard, Hubble |
| 3 — GitOps | Git = source de vérité | ArgoCD + ApplicationSets |
| 4 — Supply chain | Build sécurisé et vérifié | GitHub Actions, Trivy, Syft (SBOM), Cosign, Kyverno, Harbor — objectif SLSA niveau 2-3 |
| 5 — Zero Trust & secrets | Identités et secrets dynamiques | Vault, Keycloak (SSO + MFA), identités de workload Cilium/SPIFFE |
| 6 — Observabilité & runtime | Voir et détecter | Prometheus, Grafana, Loki, Tempo/OpenTelemetry, Falco ou Tetragon, SLO |
| 7 — Résilience | PRA/PCA prouvé par la mesure | CloudNativePG, Velero, MinIO, Chaos Mesh |

## Services gratuits utilisés
- GitHub avec le Student Developer Pack (dépôt public : Actions illimitées, protection de branche, secret scanning, CodeQL, GHCR, Dependabot)
- Nom de domaine : `vpn-ctf.pro` (déjà possédé, géré sur Cloudflare) → sous-domaine dédié `*.orbit.vpn-ctf.pro`
- DNS + TLS : Cloudflare DNS (gratuit), certificats Let's Encrypt via cert-manager en challenge **DNS-01**
  (fonctionne sans port entrant, permet un wildcard `*.orbit.vpn-ctf.pro`), enregistrements gérés par external-dns
- Token API Cloudflare **limité à la zone `vpn-ctf.pro`** (permission DNS:Edit uniquement), stocké dans Vault
- Supervision externe optionnelle : Grafana Cloud (plan gratuit)
