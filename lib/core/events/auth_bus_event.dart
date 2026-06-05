/// Classe scellée représentant un événement d'authentification.
///
/// Être `sealed` garantit que tous les types d'événements
/// sont connus à la compilation, ce qui facilite :
/// - le pattern matching
/// - la maintenance
/// - l'évolution contrôlée
sealed class AuthBusEvent {}

/// Événement indiquant qu'un logout doit être déclenché immédiatement.
///
/// Typiquement émis lorsque :
/// - le token est expiré
/// - la session est invalide
/// - le backend force une déconnexion
///
/// Le champ `reason` permet de transmettre une information
/// optionnelle à des fins de logging ou d'affichage utilisateur.
class ForceLogoutEvent extends AuthBusEvent {
  final String? reason;

  ForceLogoutEvent({this.reason});
}