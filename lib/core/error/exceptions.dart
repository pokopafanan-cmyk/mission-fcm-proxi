/// Exception de base pour toutes les erreurs techniques de l’application
abstract class AppException implements Exception {
  /// Message descriptif de l’erreur
  final String message;

  /// Code HTTP optionnel associé à l’erreur
  final int? statusCode;

  const AppException(this.message, {this.statusCode});
}

/// Exception levée lorsqu’aucune connexion réseau n’est disponible
class NetworkException extends AppException {
  const NetworkException() : super('');
}

/// Exception représentant une erreur retournée par le serveur
class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

/// Exception levée lorsque la réponse serveur est invalide ou mal formée (JSON)
class ParsingException extends ServerException {
  const ParsingException()
      : super('Données JSON mal formatées');
}

/// Exception levée lorsque la session utilisateur n’est plus valide
class UnauthorizedException extends ServerException {
  const UnauthorizedException()
      : super('Session expirée', statusCode: 401);
}








