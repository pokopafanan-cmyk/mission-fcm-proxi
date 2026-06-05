part of 'auth_bloc.dart';

/// Classe de base représentant un événement lié à l'authentification
sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

/// Vérifie l'état de l'authentification au lancement de l'application
final class AuthCheckStatus extends AuthEvent {

  const AuthCheckStatus();

  @override
  List<Object> get props => [];

}

/// Déclenché lorsqu'un utilisateur est authentifié ou que son profil est mis à jour
final class AuthUserAuthenticated extends AuthEvent {

  /// Utilisateur connecté
  final User user;

  const AuthUserAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// Déclenché pour déconnecter l'utilisateur
final class AuthUserLogout extends AuthEvent {

  final LogoutReason reason;

  const AuthUserLogout(this.reason);

  @override
  List<Object> get props => [reason];
}

/// Déclenché pour rafraîchir le token d'authentification
final class AuthUserTokenRefresh extends AuthEvent {
  const AuthUserTokenRefresh();

  @override
  List<Object> get props => [];
}

/// Déclenché pour vérifier la validité de la session ou du token
final class AuthUserValidityCheck extends AuthEvent {
  const AuthUserValidityCheck();

  @override
  List<Object> get props => [];
}

/// Déclenché lorsque les informations de l'utilisateur sont mises à jour
final class AuthUserUpdated extends AuthEvent {
  /// Utilisateur avec les nouvelles informations
  final User user;

  const AuthUserUpdated(this.user);

  @override
  List<Object> get props => [user];
}

/// Déclenché lorsque la session de l'utilisateur a expiré
final class AuthUserExpiredEvent extends AuthEvent {
  /// Message expliquant l'expiration
  final String message;

  const AuthUserExpiredEvent(this.message);

  @override
  List<Object> get props => [message];
}
