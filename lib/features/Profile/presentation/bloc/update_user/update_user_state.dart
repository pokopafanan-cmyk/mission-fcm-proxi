part of 'update_user_bloc.dart';

/// État du formulaire de modification avec validation Formz
class UpdateUserState extends Equatable with FormzMixin {

  /// Utilisateur de référence pour comparer les valeurs initiales et modifiées du formulaire.
  final User? user;

  /// Champ login de l'utilisateur
  final LoginInput login;

  /// Champ nom de l'utilisateur
  final NomInput nom;

  /// Champ prénoms de l'utilisateur
  final PrenomsInput prenoms;

  /// Champ email de l'utilisateur
  final EmailInput email;

  /// Champ numéro de mobile de l'utilisateur
  final MobileInput mobile;

  /// Statut de soumission du formulaire (initial, inProgress, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message optionnel (erreur ou info)
  final String? message;

  const UpdateUserState({
    this.user,
    this.login = const LoginInput.pure(),
    this.nom = const NomInput.pure(),
    this.prenoms = const PrenomsInput.pure(),
    this.email = const EmailInput.pure(),
    this.mobile = const MobileInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Crée une nouvelle instance du state en mettant à jour uniquement les champs fournis.
  /// Utilisé par le Bloc pour produire un nouvel état immuable.
  UpdateUserState copyWith({
    User? user,
    LoginInput? login,
    NomInput? nom,
    PrenomsInput? prenoms,
    EmailInput? email,
    MobileInput? mobile,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return UpdateUserState(
      user: user ?? this.user,
      login: login ?? this.login,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
    );
  }


  /// Indique si au moins un champ du formulaire a été modifié
  /// par rapport aux informations initiales de l'utilisateur.
  /// Utilisé pour activer ou désactiver le bouton de soumission.
  bool get isModified {
    if (user == null) return false;

    return login.value != user!.login ||
      nom.value != user!.nom ||
      prenoms.value != user!.prenoms ||
      email.value != user!.email ||
      mobile.value != user!.localMobile;
  }

  /// Le formulaire peut être soumis uniquement si :
  /// - tous les champs sont valides (Formz)
  /// - au moins un champ a été modifié
  /// - aucune soumission n'est en cours
  bool get canSubmit => isValid && isModified && !submissionStatus.isInProgress;

  /// Propriétés utilisées par Equatable pour comparer les states.
  /// initialUser est volontairement exclu : il sert uniquement de référence et ne doit pas déclencher de rebuild inutile de l'UI.
  @override
  List<Object?> get props => [login, nom, prenoms, email, mobile, submissionStatus, message];

  /// Retourne la liste des inputs pour la validation Formz
  @override
  List<FormzInput> get inputs => [login, nom, prenoms, email, mobile];

}
