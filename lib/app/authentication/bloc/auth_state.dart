part of 'auth_bloc.dart';

/// Classe de base représentant l'état de l'authentification
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// État initial avant toute action d'authentification
final class AuthInitial extends AuthState {}

/// État indiquant qu'une action d'authentification est en cours
final class AuthLoading extends AuthState {}

/// État lorsque l'utilisateur est authentifié avec succès
final class AuthAuthenticated extends AuthState {
  /// L'utilisateur connecté
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

/// État lorsque l'utilisateur n'est pas authentifié
final class AuthUnauthenticated extends AuthState {
  /// Message optionnel expliquant la raison
  final String message;

  const AuthUnauthenticated({this.message = ""});

  @override
  List<Object> get props => [message];
}

/// État lorsque la session de l'utilisateur a expiré
final class AuthExpired extends AuthState {
  /// Message expliquant la raison de l'expiration
  final String message;

  const AuthExpired({required this.message});

  @override
  List<Object> get props => [message];
}

/// État indiquant que l'utilisateur est en train de se déconnecter
final class AuthLoggingOut extends AuthState {
  /// Message optionnel
  final String message;

  const AuthLoggingOut({this.message = ""});

  @override
  List<Object> get props => [message];
}

/// État représentant une erreur liée à l'authentification
final class AuthFailure extends AuthState {
  /// Message d'erreur
  final String message;

  /// Exception associée (optionnelle)
  final Exception? exception;

  const AuthFailure(this.message, {this.exception});

  @override
  List<Object> get props => [message, exception ?? Exception()];

  @override
  String toString() => 'AuthFailure(message: $message, exception: $exception)';
}
