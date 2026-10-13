# ADR 0003 — Monorepo et outillage commun

- **Statut** : accepté
- **Date** : 2026-10-13

## Contexte
Trois personnes travaillent sur l'infra, la plateforme Kubernetes et la CI/CD.
Les postes sont sous Windows ; Ansible ne s'exécute pas nativement sous Windows.

## Options envisagées
1. **Un dépôt par couche** (infra, plateforme, apps) : séparation nette, mais dépendances
   difficiles à suivre et trois pipelines à maintenir.
2. **Monorepo** : tout au même endroit, une seule CI, une vision globale pour le jury.

## Décision
- **Monorepo** sur gitlab.com, organisé par couche (`infra/`, `kubernetes/`, `tests/`, `docs/`).
- **OpenTofu** plutôt que Terraform : open source (licence MPL), compatible, sans la licence BSL de HashiCorp.
- **Poste de travail : WSL2 (Ubuntu) + mise** pour installer les mêmes versions d'outils chez les 3 membres (`.mise.toml`).
- **Garde-fous dès le premier commit** : pre-commit (gitleaks, yamllint, tofu fmt) en local, et les mêmes contrôles en CI.
- Fins de ligne forcées en LF (`.gitattributes`) pour éviter les scripts cassés par Windows.

## Conséquences
- + Un seul `git clone` pour tout comprendre et tout reconstruire.
- + Les fuites de secrets sont bloquées avant même d'arriver sur GitLab.
- − Chaque membre doit installer WSL2 (une fois).
- − Dans un monorepo, il faudra des règles CI (`rules: changes`) pour ne lancer que les jobs utiles.
