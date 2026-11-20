# AGENTS.md – Nourou Academy (lis ce fichier EN ENTIER avant toute action)

## 0. Règles d'or
- Tu es un agent de développement qui travaille sous la direction d'Abdoul Aziz (le client-développeur) et d'un agent « maître » qui rédige les instructions. Exécute les instructions à la lettre. Si une instruction est ambiguë, choisis l'option la plus sûre, note ton choix dans docs/DECISIONS.md, et continue. Ne pose une question que si tu es complètement bloqué.
- Parle à l'utilisateur en FRANÇAIS, de façon simple et directe. Le code, les noms de variables, les commits et les commentaires sont en ANGLAIS.
- AVANT de commencer : lis AGENTS.md, docs/PROGRESS.md et docs/DECISIONS.md, puis exécute `git log --oneline -20` et `git status`. Reprends exactement où le dernier agent s'est arrêté.
- PENDANT le travail : après chaque petite étape terminée (une fonctionnalité, un écran, une correction), mets à jour docs/PROGRESS.md puis fais un commit git clair. Ne travaille jamais plus de 20 minutes sans mettre à jour PROGRESS.md. Ton quota peut s'arrêter à tout moment : un autre agent doit pouvoir continuer sans te parler.
- À LA FIN de chaque session : docs/PROGRESS.md doit contenir l'état réel, la prochaine action précise, et les problèmes connus.
- N'invente jamais un résultat. Si tu n'as pas pu tester quelque chose, écris-le dans PROGRESS.md.
- N'écris jamais de clé secrète dans le code ni dans git. Utilise un fichier .env ignoré par git.
- Ne supprime pas de fichiers existants et ne change pas l'architecture sans l'écrire dans DECISIONS.md avec la raison.
- Vérifie toujours avant de dire « terminé » : `flutter analyze` sans erreur, `flutter test` qui passe, l'application qui se lance sur le téléphone ou l'émulateur Android.

## 1. Le produit
Application mobile ANDROID (iOS plus tard) pour Nourou Academy, un centre de formation. Elle vend des formations en vidéo.
- Un apprenant crée un compte, choisit une formation, paie. Son compte est ensuite activé et il accède aux vidéos de cette formation.
- Les vidéos ne sont PAS téléchargeables ni partageables. Mais elles sont lisibles HORS CONNEXION, uniquement dans l'application, grâce à un stockage chiffré privé et à une licence qui expire (par exemple 30 jours, renouvelée à la reconnexion).
- Public : jeunes et adultes au Burkina Faso. Beaucoup de téléphones Android d'entrée de gamme et de connexions lentes. L'application doit rester fluide.
- Volume prévu : environ 50 vidéos de 45 minutes maximum. La démo en utilisera 5 à 10.
- Langue de l'interface : français.

## 2. Direction artistique (à respecter strictement)
Objectif : une application qui a l'air d'une application professionnelle à plusieurs millions de dollars.
- Style : 3D RÉALISTE et premium. PAS de style dessin animé, PAS de mascotte enfantine, PAS d'icônes cartoon.
- Couleurs VIVES et riches : bleu indigo profond, or/ambre, corail, vert menthe. Dégradés soignés, lumières douces, reflets, ombres réalistes, profondeur. Mode sombre et mode clair.
- Matière et profondeur : effet verre dépoli (glassmorphism) maîtrisé, cartes avec relief, parallaxe sur plusieurs couches, objets 3D qui réagissent à l'inclinaison du téléphone (gyroscope) et au toucher.
- Mouvement : tout est fluide à 60 images par seconde. Transitions partagées entre écrans (Hero), micro-animations qui répondent aux actions de l'utilisateur, un grand moment d'animation à l'ouverture. Pas d'animation gratuite partout : le mouvement doit guider l'œil.
- Page d'accueil : la photo détourée du coach sort d'un grand cercle lumineux (la tête dépasse du cercle), avec parallaxe, bulles d'information flottantes (série de jours, badge, progression).
- Typographie : une police d'affichage forte (ex. Bricolage Grotesque ou équivalent) + une police de texte très lisible. Échelle typographique cohérente.
- Textes : phrases courtes, verbes d'action, vocabulaire simple. Les erreurs expliquent quoi faire.
- Accessibilité : contrastes suffisants, tailles tactiles d'au moins 48 dp, respect de « réduire les animations ».

## 3. Réalisme 3D : comment on le fait (important)
La 3D temps réel lourde ralentit les téléphones modestes. On obtient un rendu réaliste ainsi :
1. Objets 3D pré-rendus (rendus Blender, ou assets 3D libres de droits) exportés en WebP/PNG avec transparence, en plusieurs couches pour la parallaxe, ou en séquences d'images courtes.
2. Animations interactives avec Rive (fichiers .riv) et Lottie pour les éléments dynamiques.
3. Shaders de fragment Flutter (fichiers GLSL .frag) pour les effets de lumière, de verre, de brillance et de particules.
4. 3D temps réel uniquement pour UNE scène-vedette (par exemple l'accueil), via un package 3D Flutter adapté, et seulement si la fluidité reste bonne.
5. Réglage de qualité automatique : détecte les téléphones modestes et réduit les effets (moins de particules, pas de flou lourd) pour garder la fluidité. Prévois un réglage « Économie » dans le profil.
Règle : si un effet fait descendre sous 50 images par seconde sur un appareil modeste, simplifie-le.
Si tu n'as pas encore d'assets 3D, utilise des placeholders propres (dégradés, formes avec ombres réalistes) et liste dans docs/ASSETS_TODO.md chaque asset à produire, avec sa taille et son format.

## 4. Pile technique (versions les plus récentes et stables)
- Flutter stable (dernière version) + Dart récent, Material 3, moteur Impeller.
- Architecture : features par dossiers (lib/features/...), couche data séparée par interfaces (repository) pour pouvoir changer de backend sans toucher à l'interface.
- État : Riverpod (dernière version stable). Navigation : go_router.
- Animations : flutter_animate, rive, lottie, shaders GLSL.
- Stockage local : drift (SQLite) pour les métadonnées hors ligne ; flutter_secure_storage pour les clés.
- Backend de démo : données simulées (mock) derrière les interfaces. Ensuite Firebase (Auth + Firestore) ou Supabase.
- Vidéo : lecteur compatible HLS (media_kit ou video_player/better_player_plus, choisis après avoir comparé et note ton choix dans DECISIONS.md).
- Vérifie la version actuelle de chaque package sur pub.dev avant de l'ajouter. N'utilise pas de package abandonné.
- Qualité : analysis_options strict (flutter_lints), tests unitaires sur la logique, un test de widget par écran principal.

## 5. Sécurité des vidéos (non négociable)
- Bloquer les captures et enregistrements d'écran sur l'écran de lecture avec FLAG_SECURE (via MethodChannel dans MainActivity.kt).
- Aucun bouton de téléchargement ni de partage.
- Hors connexion : les vidéos sont stockées CHIFFRÉES (AES-256-GCM ou équivalent) dans le dossier privé de l'application. Les clés sont dans l'Android Keystore (via flutter_secure_storage). Le déchiffrement se fait à la volée pendant la lecture (par exemple via un petit serveur local 127.0.0.1 sur port aléatoire avec jeton, ou un DataSource natif). Jamais de fichier vidéo en clair sur le stockage.
- Licence hors ligne avec date d'expiration ; au-delà, la lecture est refusée jusqu'à la reconnexion.
- Compte lié à 1 ou 2 appareils maximum.
- Filigrane dynamique (nom ou numéro de l'élève) qui se déplace lentement sur la vidéo.
- Refuser la lecture hors ligne si l'appareil est rooté (avertissement clair à l'utilisateur).
- Aucune protection n'est absolue : documente les limites dans docs/SECURITY.md.

## 6. Écrans de l'application
Ouverture (splash animé) → Intro (3 écrans) → Connexion/Inscription → Accueil (coach, progression, formations) → Catalogue → Fiche formation → Paiement (simulé au départ) → Lecteur vidéo protégé → Mes téléchargements hors ligne → Défis et badges → Profil et réglages.

## 7. Définition de « terminé » pour chaque étape
1. Ça compile : `flutter analyze` sans erreur.
2. Les tests passent.
3. Ça se lance sur Android et ça reste fluide.
4. PROGRESS.md est à jour, DECISIONS.md complété, commit fait.
5. Résumé en français pour l'utilisateur : ce qui marche, ce qui reste, la commande pour tester.
