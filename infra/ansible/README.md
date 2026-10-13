# Ansible

- `inventories/prod/hosts.yml` : la liste des machines, groupées par site.
- `playbooks/` : les scénarios (ex. `vps.yml` configure le site C).
- `roles/` : les briques réutilisables (`commun`, `durcissement`, `wireguard`, ...).

Lancer depuis la racine du dépôt : `make collections` (une fois), `make ping`, `make vps-check`, `make vps`.

| Rôle | Ce qu'il fait |
|---|---|
| `commun` | paquets de base, fuseau horaire, mises à jour de sécurité automatiques, horloge (chrony) |
| `durcissement` | SSH (clé uniquement, utilisateurs autorisés, 3 essais), fail2ban progressif, sysctl réseau, ufw « tout refuser » |
| `wireguard` | interface `wg0` en hub ou en pair ; clé privée générée sur la machine, jamais dans Git |

Règles : chaque rôle est **idempotent** (relancer ne change rien si tout est déjà bon) et passe
`ansible-lint` au profil `production`. Toujours `make vps-check` avant `make vps`.
