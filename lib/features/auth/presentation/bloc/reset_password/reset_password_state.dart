part of 'reset_password_bloc.dart';

/// État du formulaire d'inscription avec validation Formz
class ResetPasswordState extends Equatable with FormzMixin {

  /// Champ userKey de l'utilisateur
  final SecureStringInput userKey;

  /// Champ mot de passe de l'utilisateur
  final PasswordInput password;

  /// Champ de confirmation du mot de passe
  final ConfirmPasswordInput confirmPassword;

  /// Statut de soumission du formulaire (initial, inProgress, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message optionnel (erreur ou info)
  final String? message;

  const ResetPasswordState({
    this.userKey = const SecureStringInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Crée une nouvelle instance du state en mettant à jour uniquement les champs fournis. Utilisé par le Bloc pour produire un nouvel état immuable.
  ResetPasswordState copyWith({
    SecureStringInput? userKey,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return ResetPasswordState(
      userKey: userKey ?? this.userKey,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? ConfirmPasswordInput.dirty(
        confirmPassword: this.confirmPassword.value,
        password: (password ?? this.password).value,
      ),
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
    );
  }

  /// Le formulaire peut être soumis uniquement si :
  /// - tous les champs sont valides (Formz)
  /// - aucune soumission n'est en cours
  bool get canSubmit => isValid && !submissionStatus.isInProgress;

  /// Propriétés utilisées pour comparer deux états (Equatable)
  @override
  List<Object?> get props => [userKey, password, confirmPassword, submissionStatus, message];

  /// Retourne la liste des inputs pour la validation Formz
  @override
  List<FormzInput> get inputs => [userKey, password, confirmPassword];

}
