# ADR 0004 — Dépôt GitHub public et protection de `main`

- **Statut** : accepté
- **Date** : 2026-10-13

## Contexte
L'organisation `Orbit-ESGI` est sur le plan gratuit. Sur un dépôt **privé**, GitHub refuse la
protection de branche (HTTP 403 « Upgrade to GitHub Pro or make this repository public »).
Sans protection, n'importe qui peut pousser directement sur `main`, ce qui contredit le principe
GitOps (Git = source de vérité, toute modification relue et testée).

## Options
1. **Dépôt public** : protection de branche, secret scanning + push protection, CodeQL et Actions gratuits.
2. **GitHub Team via GitHub Education** : dépôt privé conservé, mais demande à valider (délai incertain).
3. **Pas de protection** : discipline d'équipe uniquement.

## Décision
Option 1. Le dépôt est public depuis le 2026-10-13. Règles sur `main` :
- passage obligatoire par une pull request avec **1 approbation**, approbations invalidées à chaque nouveau commit ;
- CI obligatoire et à jour : `gitleaks`, `yamllint`, `tofu-fmt`, `ansible-lint` ;
- historique linéaire, conversations résolues, ni force-push ni suppression ;
- secret scanning + push protection et CodeQL (configuration par défaut) activés.

## Conséquences
- + Garde-fous gratuits et vérifiables en démo (une PR qui contient un secret est bloquée).
- + Projet visible (portfolio, jury).
- − Tout le dépôt est lisible par tous : **aucun secret en clair**, jamais (SOPS/Vault, gitleaks en
  pre-commit et en CI). L'historique a été vérifié avant le passage en public.
- − Des informations d'infrastructure sont visibles (IP publique du VPS, noms d'hôtes). Elles ne sont
  pas secrètes (déjà exposées par le DNS) ; la sécurité repose sur l'authentification (SSH par clé,
  WireGuard), pas sur l'obscurité.
- − Les admins peuvent contourner la protection (`enforce_admins: false`) en cas d'urgence : à n'utiliser
  qu'exceptionnellement et à tracer.
