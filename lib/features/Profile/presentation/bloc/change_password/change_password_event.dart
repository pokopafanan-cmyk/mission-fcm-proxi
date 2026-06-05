part of 'change_password_bloc.dart';

/// Classe de base représentant un événement du formulaire de modification de Mot de passe
sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

/// Déclenché lorsque le champ login est modifié
final class ChangeLoginChanged extends ChangePasswordEvent {
  final String login;

  const ChangeLoginChanged(this.login);

  @override
  List<Object> get props => [login];
}

/// Déclenché lorsque le champ ancien mot de passe est modifié
final class ChangeOldPasswordChanged extends ChangePasswordEvent {
  final String oldPassword;

  const ChangeOldPasswordChanged(this.oldPassword);

  @override
  List<Object> get props => [oldPassword];
}


/// Déclenché lorsque le champ nouveau mot de passe est modifié
final class ChangeNewPasswordChanged extends ChangePasswordEvent {
  final String newPassword;

  const ChangeNewPasswordChanged(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

/// Déclenché lorsque le champ confirmation du nouveau mot de passe est modifié
final class ChangeConfirmNewPasswordChanged extends ChangePasswordEvent {
  final String confirmNewPassword;

  const ChangeConfirmNewPasswordChanged(this.confirmNewPassword);

  @override
  List<Object> get props => [confirmNewPassword];
}


/// Déclenché lorsque l'utilisateur soumet le formulaire de modification
final class ChangePasswordSubmitted extends ChangePasswordEvent {
  @override
  List<Object> get props => [];
}

