part of 'request_password_reset_bloc.dart';

class RequestPasswordResetState extends Equatable with FormzMixin {

  /// Champ email saisi par l'utilisateur (géré avec Formz)
  final EmailInput email;

  /// État global de soumission du formulaire (initial, loading, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message à afficher à l'utilisateur (erreur ou succès)
  final String? message;

  /// État initial du formulaire "Mot de passe oublié"
  const RequestPasswordResetState({
    this.email = const EmailInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Crée une nouvelle instance du state en mettant à jour uniquement les champs fournis. Utilisé par le Bloc pour produire un nouvel état immuable.
  RequestPasswordResetState copyWith({
    EmailInput? email,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return RequestPasswordResetState(
      email: email ?? this.email,
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
  List<Object?> get props => [email, submissionStatus, message];

  /// Champs à valider automatiquement par Formz
  @override
  List<FormzInput> get inputs => [email];

}

