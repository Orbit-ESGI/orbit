# Questions ouvertes / à vérifier

## Proxmox de l'école (admin ESGI)
- [ ] Quotas : ~16 vCPU, ~40 Go RAM, ~300 Go disque possibles ?
- [ ] Token API Proxmox pour Terraform (création / destruction de VM) ?
- [ ] UDP sortant autorisé (WireGuard 51820) ? Sinon prévoir un tunnel sur TCP 443.
- [ ] VM allumées 24/7, y compris pendant les vacances ? Snapshots possibles ?
- [ ] VLAN / sous-réseau dédié, IP fixes ?

## Serveur d'alternance
- [ ] Accord écrit de l'entreprise (prêt, durée, usage), données effacées avant prêt
- [ ] Caractéristiques : CPU, RAM (32 Go+ idéal), disques
- [ ] Bruit et consommation électrique à domicile
- [ ] Box : IP dynamique ? CGNAT ? (sans importance si tunnel WireGuard sortant vers le VPS)

## VPS OVH (alias SSH `vps-ovh`)
- [x] Caractéristiques : KVM, Ubuntu 26.04 LTS, noyau 7.0, 4 vCPU, 7,6 Go RAM (~6,7 Go dispo), 64 Go disque libre, IPv4 + IPv6, WireGuard OK
- [x] Déjà en service dessus : Caddy (80/443), cloudflared, Next.js (:3000 exposé), uvicorn (:8080 local), PostgreSQL Docker (:5432 local), service :8787 local
- [x] 2026-10-13 : services jugés inutiles par Victor → arrêtés et désactivés (atelia, atelia-broker,
  domiscan-render, caddy, cloudflared, timers atelia-sauvegarde et cloudflared-update, conteneur atelia-db).
  Rien n'a été supprimé (fichiers, volume PostgreSQL, unités systemd conservés). Seul SSH (22) reste exposé.
- [ ] Rôle ORBIT retenu : léger (hub WireGuard, témoin, entrée via Caddy) — pas de Kubernetes pour ne pas casser l'existant

## Équipe
- [x] 3 membres
- [ ] Attribution nominative des 3 rôles (voir README)
