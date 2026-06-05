
/// Représente l’état courant d’un processus (chargement, succès ou échec)
enum Status { initial, loading, success, failure }

enum LogoutReason {

  /// Déconnexion volontaire déclenchée par l'utilisateur
  userInitiated,

  /// Déconnexion imposée par le serveur (session expirée, token invalide, etc.)
  serverForced,
}