# DECISIONS – Nourou Academy

## Journal des décisions (le plus récent en haut)

### 2026-11-20 – Dossier de travail
- **Décision** : Le projet reste dans `~/Documents/app` au lieu de `~/development/nourou_academy` car le projet Flutter y existe déjà avec la config Android générée.
- **Raison** : Éviter de perdre la configuration Android existante et les fichiers déjà en place.

### 2026-11-20 – Restructuration du code existant
- **Décision** : Le prototype monofichier `lib/main.dart` (880 lignes) sera découpé en architecture features. L'ancien code sera remplacé, pas supprimé d'un coup : chaque widget sera migré dans son nouveau fichier.
- **Raison** : AGENTS.md impose une architecture par features avec Riverpod + go_router. Le code existant utilise `material_ui` et n'a ni gestion d'état ni routing.

### 2026-11-20 – Remplacement de material_ui par flutter SDK Material
- **Décision** : Supprimer la dépendance `material_ui` (package tiers) et utiliser directement `package:flutter/material.dart` (SDK natif).
- **Raison** : `material_ui` est un wrapper non standard. Flutter inclut déjà Material 3 nativement. Toutes les dépendances doivent être mainstream et maintenues.
