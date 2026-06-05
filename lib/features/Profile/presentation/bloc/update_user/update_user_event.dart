part of 'update_user_bloc.dart';

/// Classe de base représentant un événement du formulaire d'inscription
sealed class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();
}

/// Déclenché lorsque le champ login est modifié
final class UpdateUserLoginChanged extends UpdateUserEvent {
  final String login;

  const UpdateUserLoginChanged(this.login);

  @override
  List<Object> get props => [login];
}

/// Déclenché lorsque le champ nom est modifié
final class UpdateUserNomChanged extends UpdateUserEvent {
  final String nom;

  const UpdateUserNomChanged(this.nom);

  @override
  List<Object> get props => [nom];
}

/// Déclenché lorsque le champ prénoms est modifié
final class UpdateUserPrenomsChanged extends UpdateUserEvent {
  final String prenoms;

  const UpdateUserPrenomsChanged(this.prenoms);

  @override
  List<Object> get props => [prenoms];
}

/// Déclenché lorsque le champ email est modifié
final class UpdateUserEmailChanged extends UpdateUserEvent {
  final String email;

  const UpdateUserEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

/// Déclenché lorsque le champ numéro de téléphone est modifié
final class UpdateUserMobileChanged extends UpdateUserEvent {
  final String mobile;

  const UpdateUserMobileChanged(this.mobile);

  @override
  List<Object> get props => [mobile];
}


/// Événement déclenché pour initialiser le formulaire de mise à jour des infos de l'utilisateur.
/// Il est généralement envoyé au moment où l’écran de modification du profil est affiché.
class UpdateUserFormInitialized extends UpdateUserEvent {

  /// Utilisateur actuellement connecté dont les informations serviront à pré-remplir le formulaire
  final User user;

  /// Constructeur avec l'utilisateur à charger dans le formulaire
  const UpdateUserFormInitialized(this.user);

  @override
  List<Object> get props => [user];
}



/// Déclenché lorsque l'utilisateur soumet le formulaire de modification
final class UpdateUserSubmitted extends UpdateUserEvent {
  @override
  List<Object> get props => [];
}

