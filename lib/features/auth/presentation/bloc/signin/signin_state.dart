part of 'signin_bloc.dart';

/// State du formulaire de connexion (login + mot de passe)
class SignInState extends Equatable with FormzMixin {

  /// Champ login (email / username / téléphone selon le cas)
  final LoginInput login;

  /// Champ mot de passe
  final PasswordInput password;

  /// Statut global de soumission du formulaire (initial, loading, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message associé à l'état (erreur ou succès)
  final String? message;

  /// Constructeur avec valeurs par défaut (inputs en mode `pure`)
  const SignInState({
    this.login = const LoginInput.pure(),
    this.password = const PasswordInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Crée une nouvelle instance du state en mettant à jour uniquement les champs fournis. Utilisé par le Bloc pour produire un nouvel état immuable.
  SignInState copyWith({
    LoginInput? login,
    PasswordInput? password,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return SignInState(
      login: login ?? this.login,
      password: password ?? this.password,
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
  List<Object?> get props => [login, password, submissionStatus, message];

  /// Liste des inputs Formz utilisés pour la validation globale
  @override
  List<FormzInput> get inputs => [login, password];
}
