# ADR 0001 — Trois sites sans cloud payant

- **Statut** : accepté
- **Date** : 2026-10-13

## Contexte
Le projet visait au départ un site on-prem (Proxmox école) + un cloud payant (OVH/Scaleway).
L'équipe ne veut rien dépenser. Un serveur peut être prêté par l'entreprise d'alternance
et hébergé à domicile, et un VPS OVH est déjà disponible.

## Décision
- Site A : Proxmox de l'école (principal).
- Site B : serveur d'alternance à domicile, sous Proxmox (secours).
- Site C : VPS OVH (entrée publique, hub WireGuard, témoin de quorum).
- Remplacements gratuits : domaine existant `vpn-ctf.pro` (Cloudflare) avec le sous-domaine
  `orbit.vpn-ctf.pro`, stockage objet via MinIO
  auto-hébergé (sauvegardes croisées A↔B), GitHub (offre étudiante) pour le code et la CI.

## Conséquences
- + Coût nul, et trois sites indépendants (meilleur qu'un hybride à deux sites pour le quorum).
- + Même hyperviseur (Proxmox) sur A et B : une seule base de code Terraform.
- − Pas de « cloud managé » au sens strict : l'argument souveraineté reste valable (OVH, matériel maîtrisé).
- − Le VPS reste un SPOF pour l'entrée publique (voir ADR 0002).
- − Dépendance à la connexion internet du domicile.
