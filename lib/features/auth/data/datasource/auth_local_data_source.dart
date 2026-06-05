import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/common/data/models/user_model.dart';
import '../../../../core/config/app_constant.dart';
import '../../../../core/error/failure.dart';

/// **LocalDataSource (Source de données locale)**
///
/// Le LocalDataSource est responsable de la **persistance locale**
/// des données de l’application.
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Rôle dans l’architecture Clean
/// ─────────────────────────────────────────────────────────
///
/// Repository → LocalDataSource → Stockage local
///
/// (SharedPreferences, SecureStorage, SQLite, Hive, etc.)
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Responsabilités
/// ─────────────────────────────────────────────────────────
///
/// Un LocalDataSource :
/// - Sauvegarde des données localement
/// - Récupère les données persistées
/// - Supprime ou met à jour les données locales
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Gestion des erreurs
/// ─────────────────────────────────────────────────────────
///
/// - Lève des exceptions techniques (CacheException, StorageException)
/// - Ne retourne PAS de [Failure]
/// - Ne contient PAS de logique métier
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Ce que le LocalDataSource NE doit PAS faire
/// ─────────────────────────────────────────────────────────
///
/// - ❌ Ne connaît PAS les règles métier
/// - ❌ Ne décide PAS quoi sauvegarder ou quand
/// - ❌ Ne communique PAS avec le réseau
///
/// 👉 Ces décisions appartiennent au Repository ou au UseCase.
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Exemple
/// ─────────────────────────────────────────────────────────
///
/// ```dart
/// abstract class AuthLocalDataSource {
///   Future<void> saveUser(UserModel user);
///   Future<UserModel?> getUser();
///   Future<void> clearSession();
/// }
/// ```
///
/// ```dart
/// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
///   final FlutterSecureStorage storage;
///
///   @override
///   Future<void> saveUser(UserModel user) async {
///     await storage.write(
///       key: 'user',
///       value: jsonEncode(user.toMap()),
///     );
///   }
///
///   @override
///   Future<UserModel?> getUser() async {
///     final jsonString = await storage.read(key: 'user');
///     if (jsonString == null) return null;
///     return UserModel.fromMap(jsonDecode(jsonString));
///   }
///
///   @override
///   Future<void> clearSession() async {
///     await storage.deleteAll();
///   }
/// }
/// ```

abstract interface class AuthLocalDataSource {

  /// Récupère l’utilisateur actuellement stocké en local
  Future<UserModel?> getCurrentUser();

  /// Sauvegarde les informations utilisateur en local
  Future<void> saveUser(UserModel user);

  /// Supprime toutes les données utilisateur locales (user + token)
  Future<void> clearUserData();

  // Gestion du token

  /// Récupère le token d’authentification stocké
  Future<String?> getAuthToken();

  /// Sauvegarde le token d’authentification
  Future<void> saveAuthToken(String token);

  /// Supprime uniquement le token d’authentification
  Future<void> clearToken();
}


class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  /// Stockage sécurisé pour les données sensibles
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
  });

  @override
  Future<UserModel?> getCurrentUser() async {
    /// Lit l’utilisateur depuis le stockage sécurisé
    try {
      final userJson = await secureStorage.read(
        key: AppConstant.currentUserKey,
      );

      if (userJson == null) {
        return null;
      }

      /// Désérialise l’utilisateur stocké
      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromMap(userMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveUser(UserModel userModel) async {
    /// Sérialise et stocke l’utilisateur en local
    await secureStorage.write(
      key: AppConstant.currentUserKey,
      value: json.encode(userModel.toMap()),
    );
  }

  @override
  Future<void> clearUserData() async {
    /// Supprime le token et les informations utilisateur
    await secureStorage.delete(key: AppConstant.currentUserKey);
    await secureStorage.delete(key: AppConstant.authTokenKey);
  }

  @override
  Future<String?> getAuthToken() async {
    /// Récupère le token depuis le stockage sécurisé
    try {
      return await secureStorage.read(
        key: AppConstant.authTokenKey,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    /// Stocke le token d’authentification
    await secureStorage.write(
      key: AppConstant.authTokenKey,
      value: token,
    );
  }

  @override
  Future<void> clearToken() async {
    /// Supprime uniquement le token stocké
    await secureStorage.delete(
      key: AppConstant.authTokenKey,
    );
  }
}
