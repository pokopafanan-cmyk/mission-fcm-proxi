import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/config/enums.dart';
import '../../../../core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/otp_data.dart';

/// **Repository (Contrat d’accès aux données métier)**
///
/// Le Repository représente la **porte d’entrée unique vers les données**
/// pour le domaine métier.
///
/// Il agit comme un **intermédiaire** entre :
/// - les UseCases (logique métier)
/// - et les sources de données (API, base locale, cache, etc.)
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Rôle dans l’architecture Clean
/// ─────────────────────────────────────────────────────────
///
/// UI → BLoC → UseCase → Repository → DataSource
///
/// - Le UseCase ne sait PAS d’où viennent les données
/// - Le Repository décide quelle source utiliser
///   (remote, local, cache, ou combinaison des trois)
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Responsabilités d’un Repository
/// ─────────────────────────────────────────────────────────
///
/// Un Repository :
/// - Expose des **méthodes métier compréhensibles**
///   (ex: signIn, requestOtp, verifyOtp)
/// - Appelle un ou plusieurs DataSources
/// - Traduit les exceptions techniques en erreurs métier [Failure]
/// - Retourne des objets métier (entités ou modèles du domaine)
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Ce que le Repository NE doit PAS faire
/// ─────────────────────────────────────────────────────────
///
/// ❌ Ne contient PAS de logique UI
/// ❌ Ne connaît PAS Flutter (Widget, BuildContext, etc.)
/// ❌ Ne contient PAS de règles métier complexes
/// ❌ Ne gère PAS l’état de l’application
///
/// 👉 Toute logique métier (hash, validation, enchaînement complexe)
/// doit être placée dans un **UseCase**
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Gestion des erreurs
/// ─────────────────────────────────────────────────────────
///
/// - Les DataSources peuvent lever des exceptions techniques
///   (ServerException, NetworkException, etc.)
/// - Le Repository les intercepte et les transforme en [Failure]
/// - Le reste de l’application ne manipule JAMAIS d’exceptions techniques
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Exemple
/// ─────────────────────────────────────────────────────────
///
/// ```dart
/// abstract class AuthRepository {
///   Future<Either<Failure, AuthSuccess>> signIn({
///     required String login,
///     required String password,
///   });
/// }
/// ```
///
/// Implémentation :
///
/// ```dart
/// class AuthRepositoryImpl implements AuthRepository {
///   final AuthRemoteDataSource remote;
///   final AuthLocalDataSource local;
///
///   @override
///   Future<Either<Failure, AuthSuccess>> signIn({
///     required String login,
///     required String password,
///   }) async {
///     try {
///       final response = await remote.signIn(login, password);
///       await local.saveUser(response.user);
///       return Right(response);
///     } on ServerException catch (e) {
///       return Left(ServerFailure(e.message));
///     }
///   }
/// }
/// ```
abstract interface class AuthRepository {

  /// Inscription d’un nouvel utilisateur avec ses informations de base
  Future<Either<Failure, Unit>> signUp({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String hashedPassword,
    required String mobile,
    required String gds,
  });

  /// Authentification via login et mot de passe (déjà hashé)
  Future<Either<Failure, User>> signInWithLoginPassword({
    required String login,
    required String password,
  });

  /// Demande explicite d’un code OTP pour un numéro donné
  Future<Either<Failure, OtpData>> requestOtpCode({
    required String mobile,
  });

  /// Lance la demande de réinitialisation du mot de passe par email
  Future<Either<Failure, Unit>> requestPasswordReset({
    required String email,
  });

  /// Réinitialisation du mot de passe
  Future<Either<Failure, Unit>> resetPassword({
    required String userKey,
    required String password,
    required String gds,
  });

  /// Vérifie l’OTP pour finaliser la connexion
  Future<Either<Failure, User>> verifyOtpCode({
    required String mobile,
    required String otp,
  });

  /// Récupère le GDS associé à un utilisateur
  Future<Either<Failure, String>> fetchUserGds({
    required String login,
  });

  /// Déconnecte l’utilisateur associé au numéro de téléphone
  Future<Either<Failure, Unit>> logout({required LogoutReason reason});

  /// Récupère l’utilisateur actuellement authentifié
  Future<Either<Failure, User>> getCurrentUser();

  /// Sauvegarder l'utilisateur dans les pref
  Future<Either<Failure, Unit>> saveUser({required User user});
}



