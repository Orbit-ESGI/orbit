# Ansible

- `inventories/prod/hosts.yml` : la liste des machines, groupées par site.
- `playbooks/` : les scénarios (ex. `vps.yml` configure le site C).
- `roles/` : les briques réutilisables (`commun`, `durcissement`, `wireguard`, ...).

Lancer depuis la racine du dépôt : `make ping`, `make vps`.
