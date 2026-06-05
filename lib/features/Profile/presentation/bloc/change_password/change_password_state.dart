part of 'change_password_bloc.dart';

/// État du formulaire de modification avec validation Formz
class ChangePasswordState extends Equatable with FormzMixin {

  /// Champ login de l'utilisateur
  final LoginInput login;

  /// Champ mot de passe de l'utilisateur
  final PasswordInput oldPassword;

  /// Champ mot de passe de l'utilisateur
  final PasswordInput newPassword;

  /// Champ de confirmation du mot de passe
  final ConfirmPasswordInput confirmNewPassword;

  /// Statut de soumission du formulaire (initial, inProgress, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message optionnel (erreur ou info)
  final String? message;

  const ChangePasswordState({
    this.login = const LoginInput.pure(),
    this.oldPassword = const PasswordInput.pure(),
    this.newPassword = const PasswordInput.pure(),
    this.confirmNewPassword = const ConfirmPasswordInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Permet de créer une nouvelle instance du state en modifiant uniquement certains champs
  ChangePasswordState copyWith({
    LoginInput? login,
    PasswordInput? oldPassword,
    PasswordInput? newPassword,
    ConfirmPasswordInput? confirmNewPassword,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return ChangePasswordState(
      login: login ?? this.login,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? ConfirmPasswordInput.dirty(
        confirmPassword: this.confirmNewPassword.value,
        password: (newPassword ?? this.newPassword).value,
      ),
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
    );
  }

  /// Le formulaire peut être soumis uniquement si :
  /// - tous les champs sont valides (Formz)
  /// - aucune soumission n'est en cours
  bool get canSubmit => isValid && !submissionStatus.isInProgress;

  /// Propriétés pour Equatable (comparaison de state)
  @override
  List<Object?> get props => [login, oldPassword, newPassword, confirmNewPassword, submissionStatus, message];

  /// Retourne la liste des inputs pour la validation Formz
  @override
  List<FormzInput> get inputs => [login, oldPassword, newPassword, confirmNewPassword];

}
