import '../../domain/entities/user.dart';

class UserModel {

  final String login;
  final String nom;
  final String prenoms;
  final String email;
  final String mobile;
  final String active;
  final String dateCreation;
  final String? session;

  const UserModel({
    required this.login,
    required this.nom,
    required this.prenoms,
    required this.email,
    required this.mobile,
    required this.active,
    required this.dateCreation,
    this.session,
  });

  /// Factory pour convertir une Entité (Domain) en Model (Data)
  factory UserModel.fromEntity(User entity, {String? session}) {
    return UserModel(
      login: entity.login,
      nom: entity.nom,
      prenoms: entity.prenoms,
      email: entity.email,
      mobile: entity.mobile,
      active: entity.active,
      dateCreation: entity.dateCreation,
      session: session,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      login: json['user_login'] as String,
      nom: json['user_nom'] as String,
      prenoms: json['user_prenoms'] as String,
      email: json['user_email'] as String,
      mobile: json['user_mobile'] as String,
      active: json['user_active'] as String,
      dateCreation: json['user_date'] as String,
      session: json['user_session'] as String?,
    );
  }

  /// Convertit le modèle en entité pour le domaine
  User toEntity() => User(
    login: login,
    nom: nom,
    prenoms: prenoms,
    email: email,
    mobile: mobile,
    active: active,
    dateCreation: dateCreation
  );

  Map<String, dynamic> toMap() => {
    'user_session': session,
    'user_nom': nom,
    'user_login': login,
    'user_prenoms': prenoms,
    'user_email': email,
    'user_mobile': mobile,
    'user_active': active,
    'user_date': dateCreation,
  };
}
