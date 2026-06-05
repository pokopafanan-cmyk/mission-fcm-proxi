/// Classe de base représentant une erreur métier de l’application
abstract class Failure {
  /// Message lisible destiné à l’interface utilisateur
  final String message;

  const Failure(this.message);
}

/// Erreur liée à l’absence de connexion réseau
class NetworkFailure extends Failure {
  const NetworkFailure()
      : super('Aucune connexion Internet, veuillez vous connecter à internet');
}

/// Erreur liée à l’authentification (login, session, droits, etc.)
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Erreur applicative générique (cas non spécialisés)
class AppFailure extends Failure {
  const AppFailure(super.message);
}

/// Erreur provenant du serveur (API, backend)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Erreur inconnue ou inattendue
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

/// Erreur liée à la validation des données (formulaire, règles métier)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Erreur liée au cache ou au stockage local
class CacheFailure extends Failure {
  const CacheFailure() : super('Données introuvables');
}

