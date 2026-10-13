# Projet ORBIT — consignes pour Claude

Contexte complet : voir `README.md` et `docs/`.

## Objectif prioritaire : 20/20
Projet annuel ESGI Reims (Bachelor 3 Systèmes, Réseaux & Cloud), équipe de 3, notes précédentes 17/20.
Tout ce que Claude produit doit viser la meilleure note possible, avec un niveau mastère :
- **Tout en code** : Terraform/OpenTofu, Ansible, manifests K8s, GitOps. Aucune config faite à la main
  sans être ensuite codifiée. Objectif : tout reconstruire depuis Git en une commande.
- **Sécurité dès la conception** : moindre privilège, aucun secret en clair dans Git (Vault / SOPS),
  durcissement, chiffrement des flux.
- **Prouver plutôt qu'affirmer** : mesures (RTO/RPO, SLO, temps de bascule), tests, captures, chiffres.
- **Documenter chaque choix** : un ADR dans `docs/adr/` pour toute décision structurante
  (contexte, options, décision, conséquences). Schémas d'architecture à jour.
- **Pensée soutenance** : pour chaque brique, anticiper la question du jury (« et si ça tombe ? »,
  « pourquoi cet outil ? ») et la démo live associée.
- **Pédagogie** : l'équipe doit comprendre le projet de A à Z. Expliquer le « pourquoi » des choix,
  simplement, sans jargon inutile.
- **Périmètre maîtrisé** : MVP (couches 0 à 3 + bascule) d'abord, puis paliers. Signaler tout risque de dérive.
- Tenir à jour `docs/questions-ouvertes.md` et les ADR au fil de l'avancement.

## Accès VPS OVH (site C)
- Connexion : `ssh vps-ovh` (alias défini dans `~/.ssh/config`, clé `~/.ssh/atelia_ovh`, utilisateur `ubuntu`, IP 217.182.253.181).
- Pour les commandes non interactives : `ssh -o BatchMode=yes vps-ovh '<commande>'`.
- `sudo` fonctionne sans mot de passe.
- Victor autorise Claude à s'y connecter sans redemander, pour l'inspection et les tâches du projet.
  Les actions destructives ou irréversibles (suppression de données, de conteneurs, de volumes, réinstallation)
  doivent toujours être confirmées avant exécution.

## État du VPS (2026-10-13)
- Ubuntu 26.04 LTS, noyau 7.0, KVM, 4 vCPU, 7,6 Go RAM, 64 Go disque libre.
- SSH par clé uniquement (PasswordAuthentication no, PermitRootLogin no), fail2ban actif.
- Géré par Ansible (`make vps`, playbook `infra/ansible/playbooks/vps.yml`) : ne plus rien modifier à la main.
- ufw actif : 22, 80, 443 (TCP) + 51820 (UDP), v4 + v6 ; relais autorisé sur wg0.
- WireGuard hub `wg0` = 10.200.0.1/24, clé publique `E6lCLZX6AxoWZZF9pfh4so44nQGfqWy5daz8MSm9Qn8=`, aucun pair encore.
- SSH durci (AllowUsers ubuntu, MaxAuthTries 3, pas de X11/agent forwarding), fail2ban progressif, fuseau Europe/Paris.
- Anciens services atelia / domiscan / caddy / cloudflared arrêtés et désactivés, non supprimés.
- Docker installé : attention, les ports publiés par Docker contournent ufw.
- Rôle ORBIT : hub WireGuard, témoin, point d'entrée public. Pas de Kubernetes dessus.
