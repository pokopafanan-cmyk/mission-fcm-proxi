part of 'signup_bloc.dart';

/// Classe de base représentant un événement du formulaire d'inscription
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
}

/// Déclenché lorsque le champ login est modifié
final class SignUpLoginChanged extends SignUpEvent {
  final String login;

  const SignUpLoginChanged(this.login);

  @override
  List<Object> get props => [login];
}

/// Déclenché lorsque le champ nom est modifié
final class SignUpNomChanged extends SignUpEvent {
  final String nom;

  const SignUpNomChanged(this.nom);

  @override
  List<Object> get props => [nom];
}

/// Déclenché lorsque le champ prénoms est modifié
final class SignUpPrenomsChanged extends SignUpEvent {
  final String prenoms;

  const SignUpPrenomsChanged(this.prenoms);

  @override
  List<Object> get props => [prenoms];
}

/// Déclenché lorsque le champ email est modifié
final class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

/// Déclenché lorsque le champ mot de passe est modifié
final class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

/// Déclenché lorsque le champ confirmation du mot de passe est modifié
final class SignUpConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;

  const SignUpConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

/// Déclenché lorsque le champ numéro de téléphone est modifié
final class SignUpMobileChanged extends SignUpEvent {
  final String mobile;

  const SignUpMobileChanged(this.mobile);

  @override
  List<Object> get props => [mobile];
}

/// Déclenché lorsque l'utilisateur soumet le formulaire d'inscription
final class SignUpSubmitted extends SignUpEvent {
  @override
  List<Object> get props => [];
}
