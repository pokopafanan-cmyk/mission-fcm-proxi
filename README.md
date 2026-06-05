# proxi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




#  Mission Technique : Implémentation Complète FCM End-to-End

##  Vidéo de Démonstration
> **Lien de la vidéo (Test réel) :** https://1drv.ms/v/c/a21cd267d4e33670/IQDAD4CHHtuhSZyckFEXRHsZAV8spHWIwT3unIfx5IMVfks)

---

##  0. Compréhension Théorique & Architecture

### 0.1 Schéma Architectural du Flux FCM
Le schéma complet annoté décrivant le transit du Payload depuis notre backend jusqu'à l'application Flutter est disponible assets (`schema_architecture.jpg`).

### 0.2 Questions Théoriques Obligatoires
1. **Différence entre Notification Message et Data Message FCM :**
    - **Notification Message :** Contient le bloc `notification`. Géré directement par le système d'exploitation de l'appareil en arrière-plan. Le système affiche la bannière sans réveiller le code Dart.
    - **Data Message :** Contient uniquement le bloc `data` (Payload). Il est toujours transmis directement à l'application (Foreground/Background), laissant le code Flutter libre de traiter ou structurer l'information.
2. **Pourquoi un token FCM peut-il changer et quand le renouveler ?**
    - Le token change lors d'une réinstallation complète, d'une suppression des données de l'application ou d'une révocation de sécurité par Firebase. On le renouvelle dynamiquement à l'aide de l'écouteur `FirebaseMessaging.instance.onTokenRefresh`.
3. **Quel est le rôle d'APNs dans la chaîne FCM sur iOS ?**
    - APNs (Apple Push Notification service) est la passerelle obligatoire imposée par Apple. Firebase ne peut pas parler directement à un iPhone en tâche de fond ; il transmet le payload à l'APNs qui se charge de faire vibrer l'appareil iOS.
4. **Différence entre Foreground, Background et Terminated :**
    - **Foreground :** Application ouverte au premier plan. Interceptée par `FirebaseMessaging.onMessage`.
    - **Background :** Application réduite en tâche de fond. Interceptée au clic par `FirebaseMessaging.onMessageOpenedApp`.
    - **Terminated :** Application totalement fermée. Interceptée au démarrage à froid par `FirebaseMessaging.instance.getInitialMessage()`.
5. **Pourquoi ne faut-il jamais logger un token FCM en production ?**
    - Le token FCM fait office d'adresse d'aiguillage unique pour un appareil. Logger ce token en production expose l'utilisateur à des attaques de détournement de sessions ou à l'envoi de notifications frauduleuses/malveillantes (Spam, Phishing ciblé).

---

##  1. Références Officielles Exigées

| Sujet | Documentation Officielle Google / Firebase | Section Précise |
| :--- | :--- | :--- |
| **Initialisation Firebase** | [firebase.google.com/docs/flutter/setup](https://firebase.google.com/docs/flutter/setup) | *Initialize Firebase in your app* |
| **FlutterFire CLI** | [firebase.flutter.dev/docs/cli](https://firebase.flutter.dev/docs/cli) | *Installation & Configuration* |
| **FCM Client Flutter** | [firebase.google.com/docs/cloud-messaging/flutter/client](https://firebase.google.com/docs/cloud-messaging/flutter/client) | *Get a registration token* |
| **Backend Admin SDK** | [firebase.google.com/docs/admin/setup](https://firebase.google.com/docs/admin/setup) | *Initialize the SDK* |
| **Structure Payload** | [firebase.google.com/docs/reference/fcm/rest/v1/projects.messages](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages) | *Message, Notification, Data* |

---

##  2. Guide d'Installation et de Test

### Prérequis
- Flutter (Version 3.x)
- Node.js (Version 18+ ou 20+)
- Firebase CLI installé et connecté

### Lancement du Client (Flutter)
1. Nettoyer les caches locaux : `flutter clean && flutter pub get`
2. Lancer l'application sur un appareil Android physique ou émulateur : `flutter run`
3. Copier le Token FCM affiché de manière sécurisée sur l'écran d'accueil.

### Lancement du Serveur (Node.js)
1. Placer le fichier de configuration privée `serviceAccountKey.json` dans le dossier backend.
2. Installer le SDK : `npm install firebase-admin`
3. Remplacer la variable `registrationToken` dans `server.js` par le token copié.
4. Exécuter l'envoi : `node server.js` (Une réponse HTTP 200 confirme le succès).

---

##  3. Gestion des Erreurs et Cas Limites Implémentés

### Côté Client (Flutter)
- **Permissions Refusées :** Gérées visuellement via un composant `PermissionCard` explicite indiquant l'état `Inactif` à l'utilisateur sans faire crasher l'application.
- **Payload manquant ou partiel :** Utilisation systématique d'opérateurs de sécurité (`?? 'Sans titre'`) dans l'écran `NotifyDetailScreen` pour éviter tout crash d'affichage si le serveur omet des clés essentielles.

### Côté Backend (Node.js)
- **Token Invalide / Obsolète :** Interception du code d'erreur Firebase `messaging/registration-token-not-registered`. La logique métier prévoit le nettoyage immédiat de ce token obsolète en base de données.
- **Sécurité Critique :** La clé de compte de service (`serviceAccountKey.json`) est conservée exclusivement côté serveur et ajoutée au `.gitignore`. Elle n'est jamais exposée dans le code frontend de l'application mobile.