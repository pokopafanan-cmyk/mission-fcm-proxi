part of 'users_bloc.dart';

/// État du bloc de gestion des utilisateurs
class UsersState extends Equatable {

  /// Liste complète des utilisateurs récupérés (source)
  final List<User> allUsers;

  /// Liste des utilisateurs affichés
  final List<User> users;

  /// Statut global de l’état (initial, loading, success, failure, etc.)
  final Status status;

  /// Indique si toutes les données ont été chargées
  /// (utile pour la pagination / infinite scroll)
  final bool hasReachedMax;

  /// Message d’erreur ou d’information à afficher à l’utilisateur
  final String? message;

  const UsersState({
    this.status = Status.initial,
    this.allUsers = const <User>[],
    this.users = const <User>[],
    this.hasReachedMax = false,
    this.message,
  });

  /// Permet de créer une nouvelle instance de l’état
  /// en modifiant uniquement certains champs
  UsersState copyWith({
    List<User>? allUsers,
    List<User>? users,
    Status? status,
    bool? hasReachedMax,
    String? message,
  }) {
    return UsersState(
      allUsers: allUsers ?? this.allUsers,
      users: users ?? this.users,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [allUsers, users, status, hasReachedMax, message];
}
