# OpenTofu

- `modules/proxmox-vm/` : module réutilisable « une VM Proxmox » (utilisé par les sites A et B).
- `envs/site-a-ecole/` : VM du Proxmox de l'école.
- `envs/site-b-domicile/` : VM du serveur à domicile.
- `envs/dns-cloudflare/` : enregistrements DNS de `orbit.vpn-ctf.pro`.

Un dossier `envs/*` = un état (state) indépendant : une erreur sur un site ne casse pas l'autre.
Les fichiers `*.tfvars` contiennent des valeurs sensibles et ne sont pas commités : copier `*.tfvars.example`.
