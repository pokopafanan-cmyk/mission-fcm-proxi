part of 'reset_password_bloc.dart';

/// Classe de base représentant un événement du formulaire d'inscription
sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

/// Déclenché lorsque le champ login est modifié
final class ResetPasswordUserKeyChanged extends ResetPasswordEvent {
  final String userKey;

  const ResetPasswordUserKeyChanged(this.userKey);

  @override
  List<Object> get props => [userKey];
}


/// Déclenché lorsque le champ mot de passe est modifié
final class ResetPasswordChanged extends ResetPasswordEvent {
  final String password;

  const ResetPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

/// Déclenché lorsque le champ confirmation du mot de passe est modifié
final class ResetConfirmPasswordChanged extends ResetPasswordEvent {
  final String confirmPassword;

  const ResetConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

/// Déclenché lorsque l'utilisateur soumet le formulaire d'inscription
final class ResetPasswordSubmitted extends ResetPasswordEvent {
  @override
  List<Object> get props => [];
}
