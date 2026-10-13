# kubernetes/ — Couches 1 à 7, pilotées par GitOps

| Dossier | Contenu |
|---|---|
| `bootstrap/` | Le strict minimum installé à la main une seule fois : ArgoCD. Ensuite ArgoCD gère tout le reste. |
| `platform/` | Les briques de la plateforme : Cilium, cert-manager, external-dns, Kyverno, Vault, monitoring, CloudNativePG... |
| `apps/` | Les applications métier (l'application de démo). |
| `clusters/site-a`, `clusters/site-b` | Ce qui est spécifique à chaque cluster (valeurs, overrides). |

Principe GitOps : ce qui n'est pas dans Git n'existe pas. ArgoCD corrige toute modification manuelle.
