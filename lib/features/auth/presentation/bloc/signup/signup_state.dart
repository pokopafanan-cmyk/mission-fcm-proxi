part of 'signup_bloc.dart';

/// État du formulaire d'inscription avec validation Formz
class SignUpState extends Equatable with FormzMixin {

  /// Champ login de l'utilisateur
  final LoginInput login;

  /// Champ nom de l'utilisateur
  final NomInput nom;

  /// Champ prénoms de l'utilisateur
  final PrenomsInput prenoms;

  /// Champ email de l'utilisateur
  final EmailInput email;

  /// Champ mot de passe de l'utilisateur
  final PasswordInput password;

  /// Champ de confirmation du mot de passe
  final ConfirmPasswordInput confirmPassword;

  /// Champ numéro de mobile de l'utilisateur
  final MobileInput mobile;

  /// Statut de soumission du formulaire (initial, inProgress, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message optionnel (erreur ou info)
  final String? message;

  const SignUpState({
    this.login = const LoginInput.pure(),
    this.nom = const NomInput.pure(),
    this.prenoms = const PrenomsInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.mobile = const MobileInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Crée une nouvelle instance du state en mettant à jour uniquement les champs fournis. Utilisé par le Bloc pour produire un nouvel état immuable.
  SignUpState copyWith({
    LoginInput? login,
    NomInput? nom,
    PrenomsInput? prenoms,
    EmailInput? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    MobileInput? mobile,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return SignUpState(
      login: login ?? this.login,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? ConfirmPasswordInput.dirty(
        confirmPassword: this.confirmPassword.value,
        password: (password ?? this.password).value,
      ),
      mobile: mobile ?? this.mobile,
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
  List<Object?> get props => [login, nom, prenoms, email, password, confirmPassword, mobile, submissionStatus, message];

  /// Retourne la liste des inputs pour la validation Formz
  @override
  List<FormzInput> get inputs => [login, nom, prenoms, email, password, confirmPassword, mobile];

}
