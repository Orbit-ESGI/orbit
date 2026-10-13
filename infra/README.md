# infra/ — Couche 0 : le socle

| Dossier | Outil | Rôle |
|---|---|---|
| `terraform/` | OpenTofu | **Créer** les ressources : VM Proxmox (sites A et B), enregistrements DNS Cloudflare |
| `ansible/` | Ansible | **Configurer** les machines : durcissement, WireGuard, installation de Kubernetes |

Règle d'or : OpenTofu crée, Ansible configure, ArgoCD déploie. Personne ne modifie une machine à la main.
