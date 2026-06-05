part of 'users_bloc.dart';

/// Classe scellée représentant l’ensemble des événements liés aux utilisateurs
sealed class UsersEvent extends Equatable {

  const UsersEvent();

  @override
  List<Object> get props => [];
}

/// Événement déclenché pour charger la liste des utilisateurs
class UsersRequested extends UsersEvent {}

/// Événement déclenché pour rafraîchir la liste des utilisateurs
/// (pull-to-refresh, reload après une action, etc.)
class UsersRefreshed extends UsersEvent {}

/// Événement déclenché pour filtrer la liste des utilisateurs
/// en fonction d’un texte de recherche
class UsersFiltered extends UsersEvent {

  /// Texte utilisé pour filtrer les utilisateurs
  final String query;

  const UsersFiltered(this.query);

  @override
  List<Object> get props => [query];
}



