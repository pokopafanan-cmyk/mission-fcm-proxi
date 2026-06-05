part of 'signin_bloc.dart';

/// Événements possibles liés au formulaire de connexion
sealed class SignInEvent extends Equatable {
  const SignInEvent();
}

/// Événement déclenché lorsque le login est modifié
final class SignInLoginChanged extends SignInEvent {

  /// Nouvelle valeur du login
  final String login;

  const SignInLoginChanged(this.login);

  @override
  List<Object> get props => [login];
}

/// Événement déclenché lorsque le mot de passe est modifié
final class SignInPasswordChanged extends SignInEvent {

  /// Nouvelle valeur du mot de passe
  final String password;

  const SignInPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

/// Événement déclenché lors de la soumission du formulaire de connexion
final class SignInSubmitted extends SignInEvent {

  @override
  List<Object> get props => [];
}
