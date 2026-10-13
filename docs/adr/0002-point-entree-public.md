# ADR 0002 — Point d'entrée public

- **Statut** : à décider
- **Date** : 2026-10-13

## Contexte
Les sites A (école) et B (domicile) ne sont pas joignables depuis internet. Il faut un point
d'entrée public, et idéalement pas de point de défaillance unique.

## Options
1. **VPS OVH seul** comme reverse proxy → simple et souverain, mais SPOF.
2. **Cloudflare Tunnel** (gratuit) lancé depuis A et B → pas de port ouvert, bascule automatique
   entre les connecteurs, mais dépendance à Cloudflare (acteur US, Cloud Act).
3. **Les deux** : VPS en entrée principale, Cloudflare Tunnel en secours.

## Décision
À trancher par l'équipe. Quel que soit le choix, il doit être argumenté en soutenance.
